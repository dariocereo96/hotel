
<%@page import="Modelos.Usuario"%>
<%
    if (session.getAttribute("usuario") == null) { %>
<%-- Si no hay una sesión activa, redirigir al usuario a la página de inicio de sesión --%>
<% response.sendRedirect("index.jsp"); %>
<% }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Página con Submenús</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
                                    // Verificar si el usuario está autenticado y tiene perfil de "administrador"
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
                                // Verificar si el usuario está autenticado y tiene perfil de "administrador"
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
                        // Verificar si el usuario está autenticado y tiene perfil de "administrador"
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
                                // Verificar si el usuario está autenticado y tiene perfil de "administrador"
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
        <div class="container w-50">
            <h1 class="mt-5">Registro de Usuarios</h1>

            <form action="UsuarioController?action=guardar" method="post" class="mt-4">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <div class="input-group">
                        <input type="password" id="password" name="password" class="form-control" required>
                        <div class="input-group-append">
                            <button type="button" id="togglePassword" class="btn btn-outline-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirmar Password:</label>
                    <div class="input-group">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                        <div class="input-group-append">
                            <button type="button" id="toggleConfirmPassword" class="btn btn-outline-secondary">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <small id="passwordMatch" class="form-text text-muted"></small>
                </div>
                <div class="form-group">
                    <label for="perfil">Selecciona el perfil:</label>
                    <select class="form-control" required id="perfil" name="perfil">
                        <option value="administrador">Administrador</option>
                        <option value="cliente">Cliente</option>
                        <option value="recepcionista">Recepcionista</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="perfil">Estado:</label>
                    <select class="form-control" required id="estado" name="estado">
                        <option value="true">Activo</option>
                        <option value="false">Inactivo</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Registrar</button>
            </form>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#togglePassword").click(function () {
                var passwordInput = $("#password");
                var passwordFieldType = passwordInput.attr("type");

                if (passwordFieldType === "password") {
                    passwordInput.attr("type", "text");
                    $(this).find("i").removeClass("fa-eye").addClass("fa-eye-slash");
                } else {
                    passwordInput.attr("type", "password");
                    $(this).find("i").removeClass("fa-eye-slash").addClass("fa-eye");
                }
            });

            $("#toggleConfirmPassword").click(function () {
                var confirmPasswordInput = $("#confirmPassword");
                var confirmPasswordFieldType = confirmPasswordInput.attr("type");

                if (confirmPasswordFieldType === "password") {
                    confirmPasswordInput.attr("type", "text");
                    $(this).find("i").removeClass("fa-eye").addClass("fa-eye-slash");
                } else {
                    confirmPasswordInput.attr("type", "password");
                    $(this).find("i").removeClass("fa-eye-slash").addClass("fa-eye");
                }
            });

            $("#confirmPassword").keyup(function () {
                var password = $("#password").val();
                var confirmPassword = $(this).val();

                if (password === confirmPassword) {
                    $("#passwordMatch").text("Las contraseñas coinciden").removeClass("text-danger").addClass("text-success");
                } else {
                    $("#passwordMatch").text("Las contraseñas no coinciden").removeClass("text-success").addClass("text-danger");
                }
            });
        });
    </script>

</html>
