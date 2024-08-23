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
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "ReservacionController", urlPatterns = {"/ReservacionController"})
public class ReservacionController extends HttpServlet {

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
            out.println("<title>Servlet ReservacionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservacionController at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("/registrarReservacion.jsp").forward(request, response);
        }

        if (action.equals("eliminar")) {

            int idReservacion = Integer.parseInt(request.getParameter("idReservacion"));

            new ReservacionDAO().eliminarReservacion(idReservacion);

            // Redirigir a la página correspondiente
            response.sendRedirect("reservaciones.jsp");
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

        if (action.equalsIgnoreCase("guardar")) {
            int idCliente = Integer.parseInt(request.getParameter("idcliente"));
            int idHabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            int ocupantes = Integer.parseInt(request.getParameter("ocupantes"));

            Reservacion reservacion = new Reservacion(idCliente, idHabitacion, fechaInicio, fechaFin, ocupantes);

            System.out.println(reservacion);

            ReservacionDAO reservacionDAO = new ReservacionDAO();

            reservacionDAO.registrarReservacion(reservacion);

            response.sendRedirect("reservaciones.jsp");
        }

        if (action.equals("editar")) {
            // Obtener los parámetros enviados desde el formulario
            int idReservacion = Integer.parseInt(request.getParameter("idReservacion"));
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFinalizacion = request.getParameter("fechaFin");
            int idHabitacion = Integer.parseInt(request.getParameter("idHabitacion"));
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int ocupantes = Integer.parseInt(request.getParameter("ocupantes"));
            int idHabitacionAnterior = Integer.parseInt(request.getParameter("idHabitacionAnterior"));

            // Llamar al método de actualización en el DAO
            ReservacionDAO reservacionDAO = new ReservacionDAO();
            Reservacion reservacion = new Reservacion(idReservacion, idCliente, idHabitacion, fechaInicio, fechaFinalizacion, ocupantes);
            reservacion.setIdHabitacionAnterior(idHabitacionAnterior);
            reservacionDAO.modificarReservacion(reservacion);

            // Redireccionar a la página de éxito o mostrar un mensaje de éxito
            response.sendRedirect("reservaciones.jsp");
        }

        if (action.equals("busquedaHabitacion")) {
            // Obtener el habiacioId del parámetro de solicitud
            int idHabitacion = Integer.parseInt(request.getParameter("idHabitacion"));

            Habitacion habitacion = new HabitacionDAO().buscarHabitacion(idHabitacion);

            // Crear un objeto JSON utilizando la biblioteca JSON-java
            JSONObject habitacionJson = new JSONObject();

            habitacionJson.put("idHabitacion", habitacion.getId());
            habitacionJson.put("capacidad", habitacion.getCapacidad());
            habitacionJson.put("precioNoche", habitacion.getPrecioNoche());
            habitacionJson.put("tipo", habitacion.getTipo());

            // Establecer la respuesta
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(habitacionJson.toString());
        }

        if (action.equals("reservacionCliente")) {
            // Obtener los parámetros del formulario
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String tipoDocumento = request.getParameter("tipoDocumento");
            String numeroDocumento = request.getParameter("numeroDocumento");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            int idHabitacion = Integer.parseInt(request.getParameter("idhabitacion"));
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFin = request.getParameter("fechaFin");
            int ocupantes = Integer.parseInt(request.getParameter("ocupantes"));
            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double iva = Double.parseDouble(request.getParameter("iva"));
            double total = Double.parseDouble(request.getParameter("total"));
            String tipoPago = request.getParameter("tipoPago");

            Cliente cliente = new Cliente(nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);
            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.registrar(cliente);

            System.out.println(cliente);
            System.out.println("ID GENERADO: " + clienteDAO.idGenerado);
            int idCliente = clienteDAO.idGenerado;

            Reservacion reservacion = new Reservacion(idCliente, idHabitacion, fechaInicio, fechaFin, ocupantes);

            ReservacionDAO reservacionDAO = new ReservacionDAO();
            reservacionDAO.registrarReservacion(reservacion);

            System.out.println(reservacion);
            System.out.println("ID GENERADO RESERVACION: " + reservacionDAO.idGenerado);

            int idReservacion = reservacionDAO.idGenerado;

            // Obtener la fecha actual
            Date fechaActual = new Date();

            // Crear un formateador de fecha
            SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");

            // Formatear la fecha actual como una cadena de texto
            String fecha = formateador.format(fechaActual);

            Factura factura = new Factura(fecha, subtotal, iva, total, idReservacion, idCliente, tipoPago);

            new FacturaDAO().registrar(factura);
            System.out.println(factura);

            // Redireccionar a la página JSP deseada
            response.sendRedirect("detalleReservacion.jsp?idReservacion=" + idReservacion);

        }

        if (action.equals("busquedaReservasCliente")) {
            String cedula = request.getParameter("cedula");

            ArrayList<Reservacion> reservaciones = new ReservacionDAO().getReservacionesCliente(cedula);

            // Construye el JSON para devolver los datos de reservas
            JSONArray jsonArray = new JSONArray();

            for (Reservacion reservacion : reservaciones) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("id", reservacion.getId());
                jsonObject.put("fechaInicio", reservacion.getFechaInicio());
                jsonObject.put("fechaFin", reservacion.getFechaFin());
                jsonObject.put("idHabitacion", reservacion.getIdHabitacion());
                jsonObject.put("idCliente", reservacion.getIdCliente());
                jsonArray.put(jsonObject);
            }

            // Configura la respuesta como JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Envía los datos del reserva como JSON en la respuesta
            PrintWriter out = response.getWriter();
            out.print(jsonArray.toString());
            out.flush();
        }

        if (action.equals("delete")) {
            int idReservacion = Integer.parseInt(request.getParameter("idReservacion"));
            new ReservacionDAO().eliminarReservacion(idReservacion);

            // Envías una respuesta al cliente indicando que la eliminación fue exitosa
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.print("Reservación eliminada con éxito");
            out.flush();
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
