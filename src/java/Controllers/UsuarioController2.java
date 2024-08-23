/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Modelos.Cliente;
import Modelos.ClienteDAO;
import Modelos.Usuario;
import Modelos.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
@WebServlet(name = "UsuarioController", urlPatterns = {"/UsuarioController"})
public class UsuarioController2 extends HttpServlet {

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
            out.println("<title>Servlet UsuarioController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UsuarioController at " + request.getContextPath() + "</h1>");
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

        if (action.equalsIgnoreCase("iniciar")) {

//            HttpSession session = request.getSession(false);
//            if (session != null) {
//                session.invalidate();
//            }
            response.sendRedirect("login.jsp"); // Redirige a la página de inicio de sesión
        }

        if (action.equalsIgnoreCase("exit")) {

            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp"); // Redirige a la página de inicio de sesión
        }

        if (action.equals("eliminar")) {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            new UsuarioDAO().eliminarUsuario(idUsuario);
            // Redirigir a la página correspondiente
            response.sendRedirect("usuarios.jsp");
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

        if (action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario usuario = usuarioDAO.login(username, password);

            System.out.println(usuario);

            // Obtener el contador de intentos fallidos de la sesión
            HttpSession session = request.getSession(true);

            Integer intentosFallidos = (Integer) session.getAttribute("intentosFallidos");

            if (intentosFallidos == null) {
                intentosFallidos = 0;
            }

            if (usuario == null) {
                response.sendRedirect("login.jsp?error=1");
                intentosFallidos = 0;
                session.setAttribute("intentosFallidos", intentosFallidos);

            } else {

                if (usuario.isActivo()) {
                    if (usuario.getPassword().equals(password)) {
                        session.setAttribute("usuario", usuario);
                        intentosFallidos = 0;
                        session.setAttribute("intentosFallidos", intentosFallidos);
                        response.sendRedirect("principal.jsp");
                    } else {
                        intentosFallidos++;

                        if (intentosFallidos >= 3) {
                            intentosFallidos = 0;
                            session.setAttribute("intentosFallidos", intentosFallidos);
                            usuarioDAO.desabilitarUsuario(usuario.getId());
                            response.sendRedirect("login.jsp?error=3");

                        } else {
                            session.setAttribute("intentosFallidos", intentosFallidos);

                            response.sendRedirect("login.jsp?error=2");
                        }

                    }
                } else {
                    response.sendRedirect("login.jsp?error=3");
                }

            }
        }

        if (action.equals("guardar")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String perfil = request.getParameter("perfil");
            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

            new UsuarioDAO().registrarUsuario(new Usuario(username, password, perfil,estado));
            // Redireccionar a la página de listado de usuarios
            response.sendRedirect("usuarios.jsp");
        }

        if (action.equals("guardarUserCliente")) {
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String tipoDocumento = request.getParameter("tipoDocumento");
            String numeroDocumento = request.getParameter("numeroDocumento");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");

            Cliente cliente = new Cliente(nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);

            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.registrar(cliente);

            System.out.println(clienteDAO.idGenerado);
            int idCliente = clienteDAO.idGenerado;

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Usuario usuario = new Usuario(username, password, "cliente", idCliente);

            System.out.println(usuario);

            new UsuarioDAO().registrarUsuarioCliente(usuario);

        }

        if (action.equals("editar")) {
            // Obtener los parámetros del formulario    
            int usuarioId = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String perfil = request.getParameter("perfil");
            boolean isActivo = Boolean.parseBoolean(request.getParameter("activo"));

            // Crear un objeto Usuario con los datos modificados
            Usuario usuario = new Usuario(usuarioId, username, password, perfil,isActivo);

            // Llamar al método de tu DAO para modificar el usuario en la base de datos
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.modificarUsuario(usuario);

            // Redireccionar a la página de listado de usuarios
            response.sendRedirect("usuarios.jsp");
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
