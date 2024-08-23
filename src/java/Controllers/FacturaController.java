/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Modelos.Cliente;
import Modelos.ClienteDAO;
import Modelos.Factura;
import Modelos.FacturaDAO;
import Modelos.Habitacion;
import Modelos.HabitacionDAO;
import Modelos.Reservacion;
import Modelos.ReservacionDAO;
import Modelos.TarifaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "FacturaController", urlPatterns = {"/FacturaController"})
public class FacturaController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FacturaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FacturaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("registrar")) {
            request.getRequestDispatcher("/registrarFactura.jsp").forward(request, response);
        }

        if (action.equals("eliminar")) {

            int idFactura = Integer.parseInt(request.getParameter("idFactura"));

            new FacturaDAO().eliminarFactura(idFactura);

            // Redirigir a la página correspondiente
            response.sendRedirect("facturas.jsp");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("busquedaCliente")) {

            // Obtener el clienteId del parámetro de solicitud
            int clienteId = Integer.parseInt(request.getParameter("clienteId"));

            ClienteDAO clienteDAO = new ClienteDAO();
            Cliente cliente = clienteDAO.buscarCliente(clienteId);

            ReservacionDAO reservacionDAO = new ReservacionDAO();
            Reservacion reservacion = reservacionDAO.buscarReservacionCliente(cliente.getId());

            HabitacionDAO habitacionDAO = new HabitacionDAO();
            Habitacion habitacion = habitacionDAO.buscarHabitacion(reservacion.getIdHabitacion());

            System.out.println(habitacion);

            // Crear un objeto JSON utilizando la biblioteca JSON-java
            JSONObject clienteJson = new JSONObject();
            clienteJson.put("nombre", cliente.getNombreCompleto());
            clienteJson.put("documento", cliente.getNumeroDocumento());
            clienteJson.put("email", cliente.getCorreo());
            clienteJson.put("idReservacion", reservacion.getId());
            clienteJson.put("fechaInicio", reservacion.getFechaInicio());
            clienteJson.put("fechaFinalizacion", reservacion.getFechaFin());
            clienteJson.put("numeroHabitacion", habitacion.getId());
            clienteJson.put("tipoHabitacion", habitacion.getTipo());
            clienteJson.put("precioNoche", habitacion.getPrecioNoche());

            // Convertir las cadenas en objetos LocalDate
            LocalDate fechaInicio = LocalDate.parse(reservacion.getFechaInicio());
            LocalDate fechaFin = LocalDate.parse(reservacion.getFechaFin());

            // Calcular la diferencia en días
            long dias = ChronoUnit.DAYS.between(fechaInicio, fechaFin);

            clienteJson.put("totalDias", dias);

            // Establecer la respuesta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(clienteJson.toString());
        }

        if (action.equalsIgnoreCase("guardar")) {

            // Obtener la fecha actual
            Date fechaActual = new Date();

            // Crear un formateador de fecha
            SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");

            // Formatear la fecha actual como una cadena de texto
            String fecha = formateador.format(fechaActual);

            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double iva = Double.parseDouble(request.getParameter("iva"));
            double total = Double.parseDouble(request.getParameter("total"));
            int idReservacion = Integer.parseInt(request.getParameter("idReservacion"));
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String tipoPago = request.getParameter("tipoPago");

            // Crear un objeto Factura con los datos
            Factura factura = new Factura(fecha, subtotal, iva, total, idReservacion, idCliente,tipoPago);

            System.out.println(total);
            System.out.println(factura);
            FacturaDAO facturaDAO = new FacturaDAO();

            facturaDAO.registrar(factura);

            System.out.println("");
            response.sendRedirect("pdfFactura.jsp?idFactura=" + facturaDAO.idGenerado);

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
