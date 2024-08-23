/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Modelos.Tarifa;
import Modelos.TarifaDAO;
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

/**
 *
 * @author HP
 */
@WebServlet(name = "TarifaController", urlPatterns = {"/TarifaController"})
@MultipartConfig
public class TarifaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TarifaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TarifaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("listar")) {

            ArrayList<Tarifa> tarifas = new TarifaDAO().obtenerTarifas();
            request.setAttribute("tarifas", tarifas);

            request.getRequestDispatcher("/tarifas.jsp").forward(request, response);
        }

        if (action.equalsIgnoreCase("registrar")) {
            request.getRequestDispatcher("/registrarTarifa.jsp").forward(request, response);
        }

        if (action.equals("eliminar")) {

            int idTarifa = Integer.parseInt(request.getParameter("idTarifa"));

            new TarifaDAO().eliminarTarifa(idTarifa);

            // Redirigir a la página correspondiente
            response.sendRedirect("TarifaController?action=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("guardar")) {

            // Obtener los parámetros del formulario
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String categoria = request.getParameter("categoria");

            // Obtener el Part que contiene la imagen enviada desde el formulario
            Part imagenPart = request.getPart("imagen");

            try (InputStream imagenStream = imagenPart.getInputStream()) {

                // Leer los bytes de la imagen
                byte[] bytesImagen = leerBytesDesdeInputStream(imagenStream);

                // Convertir los bytes de la imagen a Base64
                String imagenBase64 = Base64.getEncoder().encodeToString(bytesImagen);

                // Crear una instancia de la clase Tarifa con los datos obtenidos
                Tarifa tarifa = new Tarifa(descripcion, precio, categoria, imagenBase64);

                // Guardar la tarifa en la base de datos utilizando el TarifaDAO
                TarifaDAO tarifaDAO = new TarifaDAO();
                tarifaDAO.registrarTarifa(tarifa);

                // Redirigir a la página de tarifas registradas
                response.sendRedirect("TarifaController?action=listar");

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

        }

        if (action.equalsIgnoreCase("editar")) {
            // Obtener los parámetros del formulario
            int idTarifa = Integer.parseInt(request.getParameter("idTarifa"));
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String categoria = request.getParameter("categoria");

            // Obtener el Part que contiene la imagen enviada desde el formulario
            Part imagenPart = request.getPart("imagen");

            // Verificar si se envió una imagen
            if (imagenPart != null && imagenPart.getSize() > 0) {

                try (InputStream imagenStream = imagenPart.getInputStream()) {

                    // Leer los bytes de la imagen
                    byte[] bytesImagen = leerBytesDesdeInputStream(imagenStream);

                    // Convertir los bytes de la imagen a Base64
                    String imagenBase64 = Base64.getEncoder().encodeToString(bytesImagen);

                    // Crear una instancia de la clase Tarifa con los datos obtenidos
                    Tarifa tarifa = new Tarifa(idTarifa,descripcion, precio, categoria, imagenBase64);

                    // Guardar la tarifa en la base de datos utilizando el TarifaDAO
                    TarifaDAO tarifaDAO = new TarifaDAO();
                    tarifaDAO.editarTarifaImage(tarifa);

                    // Redirigir a la página de tarifas registradas
                    response.sendRedirect("TarifaController?action=listar");

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            } else {

                // Crear una instancia de la clase Tarifa con los datos obtenidos
                Tarifa tarifa = new Tarifa(idTarifa, descripcion, precio, categoria);

                System.out.println(tarifa);

                // Guardar la tarifa en la base de datos utilizando el TarifaDAO
                TarifaDAO tarifaDAO = new TarifaDAO();
                tarifaDAO.editarTarifa(tarifa);

                // Redirigir a la página de tarifas registradas
                response.sendRedirect("TarifaController?action=listar");
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
