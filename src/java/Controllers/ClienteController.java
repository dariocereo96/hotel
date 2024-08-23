/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Modelos.Cliente;
import Modelos.ClienteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
@WebServlet(name = "ClienteController", urlPatterns = {"/ClienteController"})
public class ClienteController extends HttpServlet {

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
            out.println("<title>Servlet ClienteController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClienteController at " + request.getContextPath() + "</h1>");
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

            ArrayList<Cliente> clientes = this.mostrarClientes();
            request.setAttribute("clientes", clientes);

            request.getRequestDispatcher("/clientes.jsp").forward(request, response);

        }

        if (action.equalsIgnoreCase("registrar")) {
            request.getRequestDispatcher("/registrarCliente.jsp").forward(request, response);
        }

        if (action.equals("eliminar")) {

            int idCliente = Integer.parseInt(request.getParameter("idCliente"));

            new ClienteDAO().eliminarCliente(idCliente);

            // Redirigir a la página correspondiente
            response.sendRedirect("ClienteController?action=listar");
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
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String tipoDocumento = request.getParameter("tipoDocumento");
            String numeroDocumento = request.getParameter("numeroDocumento");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");

            Cliente cliente = new Cliente(nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);

            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.registrar(cliente);

            response.sendRedirect("ClienteController?action=listar");
        }

        if (action.equalsIgnoreCase("editar")) {
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String tipoDocumento = request.getParameter("tipoDocumento");
            String numeroDocumento = request.getParameter("numeroDocumento");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");

            Cliente cliente = new Cliente(idCliente, nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);

            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.editarCliente(cliente);

            response.sendRedirect("ClienteController?action=listar");
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

    public ArrayList<Cliente> mostrarClientes() {
        ClienteDAO clienteDAO = new ClienteDAO();
        return clienteDAO.getClientes();
    }

}
