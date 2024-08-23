/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Modelos.Habitacion;
import Modelos.HabitacionDAO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "HabitacionController", urlPatterns = {"/HabitacionController"})
@MultipartConfig
public class HabitacionController extends HttpServlet {

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
            out.println("<title>Servlet HabitacionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HabitacionController at " + request.getContextPath() + "</h1>");
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
        if (action.equalsIgnoreCase("listar")) {

            ArrayList<Habitacion> habitaciones = this.mostrarHabitaciones();
            request.setAttribute("habitaciones", habitaciones);

            request.getRequestDispatcher("/habitaciones.jsp").forward(request, response);

        }

        if (action.equalsIgnoreCase("guardar")) {
            request.getRequestDispatcher("/registrar.jsp").forward(request, response);
        }

        if (action.equals("eliminar")) {

            int idHabitacion = Integer.parseInt(request.getParameter("idHabitacion"));

            new HabitacionDAO().eliminarHabitacion(idHabitacion);

            // Guardar el mensaje en un atributo de la solicitud
            request.setAttribute("mensaje", "La habitación ha sido eliminada exitosamente.");

            // Redirigir a la página correspondiente
            response.sendRedirect("HabitacionController?action=listar");
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

        if (action.equals("registrar")) {
            int capacidad = Integer.parseInt(request.getParameter("capacidad"));
            String tipo = request.getParameter("tipo");
            double precioNoche = Double.parseDouble(request.getParameter("precioNoche"));
            boolean disponible = Boolean.parseBoolean(request.getParameter("disponible"));

            // Obtener el Part que contiene la imagen enviada desde el formulario
            Part imagenPart = request.getPart("imagen");

            try (InputStream imagenStream = imagenPart.getInputStream()) {
                // Leer los bytes de la imagen
                byte[] bytesImagen = leerBytesDesdeInputStream(imagenStream);

                // Convertir los bytes de la imagen a Base64
                String imagenBase64 = Base64.getEncoder().encodeToString(bytesImagen);

                System.out.println(imagenBase64);

                Habitacion habitacion = new Habitacion(capacidad, tipo, precioNoche, disponible, imagenBase64);
                HabitacionDAO habitacionDAO = new HabitacionDAO();
                habitacionDAO.registrar(habitacion);

                response.sendRedirect("HabitacionController?action=listar");

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

        }

        if (action.equals("editar")) {
            // Obtener los datos enviados desde el formulario
            int idHabitacion = Integer.parseInt(request.getParameter("habitacionId"));
            int capacidad = Integer.parseInt(request.getParameter("capacidad"));
            String tipo = request.getParameter("tipo");
            double precioNoche = Double.parseDouble(request.getParameter("precioNoche"));
            boolean disponible = Boolean.parseBoolean(request.getParameter("disponible"));

            // Obtener el Part que contiene la imagen enviada desde el formulario
            Part imagenPart = request.getPart("imagen");

            // Verificar si se envió una imagen
            if (imagenPart != null && imagenPart.getSize() > 0) {

                try (InputStream imagenStream = imagenPart.getInputStream()) {
                    // Leer los bytes de la imagen
                    byte[] bytesImagen = leerBytesDesdeInputStream(imagenStream);

                    // Convertir los bytes de la imagen a Base64
                    String imagenBase64 = Base64.getEncoder().encodeToString(bytesImagen);

                    System.out.println(imagenBase64);

                    // Crear un objeto Habitacion con los datos actualizados
                    Habitacion habitacion = new Habitacion(idHabitacion, capacidad, tipo, precioNoche, disponible, imagenBase64);

                    // Actualizar la habitación en la base de datos
                    HabitacionDAO habitacionDAO = new HabitacionDAO();
                    habitacionDAO.editarHabitacionImage(habitacion);

                    // Redirigir a la página de lista de habitaciones o a una página de confirmación
                    response.sendRedirect("HabitacionController?action=listar");

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            } else {

                Habitacion habitacion = new Habitacion(idHabitacion,capacidad, tipo, precioNoche, disponible);
                HabitacionDAO habitacionDAO = new HabitacionDAO();
                habitacionDAO.editarHabitacion(habitacion);

                response.sendRedirect("HabitacionController?action=listar");
            }
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

    public ArrayList<Habitacion> mostrarHabitaciones() {
        HabitacionDAO habitacionDAO = new HabitacionDAO();
        return habitacionDAO.getHabitaciones();
    }

    // Método para leer los bytes desde un InputStream
    private byte[] leerBytesDesdeInputStream(InputStream inputStream) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        int nRead;
        byte[] data = new byte[1024];
        while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        buffer.flush();
        return buffer.toByteArray();
    }
}
