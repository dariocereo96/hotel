
<%@page import="Modelos.Usuario"%>
<%
    if (session.getAttribute("usuario") == null) { %>
<%-- Si no hay una sesi�n activa, redirigir al usuario a la p�gina de inicio de sesi�n --%>
<% response.sendRedirect("index.jsp"); %>
<% }
%>

<%
    if (session.getAttribute("usuario") == null) { %>
<%-- Si no hay una sesi�n activa, redirigir al usuario a la p�gina de inicio de sesi�n --%>
<% response.sendRedirect("index.jsp"); %>
<% }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>


<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Cliente"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sistema Hotelero</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/resources/jquery-3.5.1.slim.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/bootstrap.bundle.min.js"></script>
        <style>
            .dropdown-submenu {
                position: relative;
            }

            .dropdown-submenu .dropdown-menu {
                top: 0;
                left: 100%;
                margin-top: -1px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="principal.jsp">Sistema Hotelero</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>.
            <div style= "background-color: #0000FF" class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a style="color: #ffffff" class="nav-link" href="principal.jsp">Inicio</a>
                    </li>


                    <li class="nav-item dropdown">
                        <a style="color: #ffffff" class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Modulo mantenimiento
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown1">
                            <li class="dropdown-submenu">
                                <a class="dropdown-item dropdown-toggle" href="ClienteController?action=listar">Clientes</a>
                                <%
                                    // Verificar si el usuario est� autenticado y tiene perfil de "administrador"
                                    if (usuario != null && "administrador".equals(usuario.getPerfil())) {
                                %>
                                <a class="dropdown-item dropdown-toggle" href="HabitacionController?action=listar">Habitaciones</a>
                                <%
                                    }
                                %>
                            </li>
                        </ul>
                    </li>


                    <li class="nav-item dropdown">
                        <a style="color: #ffffff" class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Modulo Negocio
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown2">
                            <%
                                // Verificar si el usuario est� autenticado y tiene perfil de "administrador"
                                if (usuario != null && "administrador".equals(usuario.getPerfil())) {
                            %>
                            <li><a class="dropdown-item" href="TarifaController?action=listar">Gestion de tarifas</a></li>
                                <%
                                    }
                                %>

                            <li><a class="dropdown-item" href="ReservacionController?action=registrar">Asignacion de habitaciones</a></li>
                            <li><a class="dropdown-item" href="FacturaController?action=registrar">Generacion de factura</a></li>
                        </ul>
                    </li>
                    <%
                        // Verificar si el usuario est� autenticado y tiene perfil de "administrador"
                        if (usuario != null && "administrador".equals(usuario.getPerfil())) {
                    %>
                    <li class="nav-item dropdown">
                        <a style="color: #ffffff" class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Modulo Reportes
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown2">
                            <li><a class="dropdown-item" href="pdfClientes.jsp">Reportes clientes</a></li>
                            <li><a class="dropdown-item" href="pdfHabitacion.jsp">Reporte de habitaciones</a></li>
                            <li><a class="dropdown-item" href="reservaciones.jsp">Reporte de reservas</a></li>
                            <li><a class="dropdown-item" href="facturas.jsp">Reporte de facturas</a></li>
                        </ul>
                    </li>
                    <%
                        }
                    %>
                    <li class="nav-item dropdown">
                        <a style="color: #ffffff" class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Modulo Seguridad
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown2">
                            <%
                                // Verificar si el usuario est� autenticado y tiene perfil de "administrador"
                                if (usuario != null && "administrador".equals(usuario.getPerfil())) {
                            %>
                            <li><a class="dropdown-item" href="registrarUsuario.jsp">Crear usuario</a></li>
                            <li><a class="dropdown-item" href="usuarios.jsp">Listado de usuario</a></li>
                                <%
                                    }
                                %>
                            <li><a class="dropdown-item" href="UsuarioController?action=exit">Cerrar sesion</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div>
        </nav>
        <div class="container">
            <h1>Listado de Clientes</h1>
            <a class="btn btn-primary mt-2 ml-2 mb-2" href="ClienteController?action=registrar">Agregar cliente</a>
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Nombres</th>
                        <th>Tipo de Documento</th>
                        <th>N�mero de Documento</th>
                        <th>Correo Electr�nico</th>
                        <th>Tel�fono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% ArrayList<Cliente> clientes = (ArrayList<Cliente>) request.getAttribute("clientes");
                        for (Cliente cliente : clientes) {%>
                    <tr>
                        <td><%= cliente.getNombreCompleto()%></td>
                        <td><%= cliente.getTipoDocumento()%></td>
                        <td><%= cliente.getNumeroDocumento()%></td>
                        <td><%= cliente.getCorreo()%></td>
                        <td><%= cliente.getTelefono()%></td>
                        <td>
                            <a class="btn btn-primary" href="editarCliente.jsp?idCliente=<%=cliente.getId()%>">Editar</a>
                            <a class="btn btn-danger" href="ClienteController?action=eliminar&idCliente=<%= cliente.getId()%>">Eliminar</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
