
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


<%@page import="Modelos.TarifaDAO"%>
<%@page import="Modelos.Tarifa"%>
<%@page import="Modelos.ClienteDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Página con Submenús</title>
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
        <script>
            function validarFormulario() {
                // Obtener el elemento del input de la imagen
                let imagenInput = document.getElementById('imagen');

                /* Verificar si se ha seleccionado un archivo
                 if (imagenInput.files.length === 0) {
                 alert('Por favor, seleccione una imagen.');
                 return false;
                 }
                 */

                // Obtener la imagen seleccionada
                let imagen = imagenInput.files[0];

                // Verificar el formato de la imagen
                if (imagen.type !== 'image/jpeg') {
                    alert('La imagen debe estar en formato JPG.');
                    return false;
                }

                // Verificar el tamaño de la imagen (1 MB = 1024 * 1024 bytes)
                if (imagen.size > 1024 * 1024) {
                    alert('La imagen debe tener un tamaño máximo de 1 MB.');
                    return false;
                }

                // Si todo está correcto, permitir el envío del formulario
                return true;
            }
        </script>
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

        <%
            Tarifa tarifa = new TarifaDAO().buscarTarifa(Integer.parseInt(request.getParameter("idTarifa")));
        %>

        <div class="container">
            <h1>Agregar Nueva Tarifa</h1>
            <form action="TarifaController?action=editar" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario();">
                <input type="hidden" name="idTarifa" value="<%= tarifa.getIdTarifa()%>">
                <div class="form-group">
                    <label for="descripcion">Descripción:</label>
                    <input type="text" class="form-control" id="descripcion" name="descripcion" value="<%=tarifa.getDescripcion()%>" required>
                </div>
                <div class="form-group">
                    <label>Imagen de referencia - Seleccionar imagen (JPG, tamaño máximo 1 MB):</label>
                    <input type="file" class="form-control" name="imagen" id="imagen" accept="image/jpeg" maxlength="1048576">
                </div>
                <div class="form-group">
                    <img id="imagenPreview" src="data:image/png;base64, <%= tarifa.getImagen()%>" width="200px" height="200px"> 
                </div>
                <div class="form-group">
                    <label for="tipoDocumento">Categoria:</label>
                    <select class="form-control" id="categoria" name="categoria" required>
                        <option value="alimentacion" <%= tarifa.getCategoria().equals("alimentacion") ? "selected" : ""%>>Alimentacion</option>
                        <option value="entretenimiento" <%= tarifa.getCategoria().equals("entretenimiento") ? "selected" : ""%>>Entretenimiento</option>
                        <option value="bienestar" <%= tarifa.getCategoria().equals("bienestar") ? "selected" : ""%>>Bienestar</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="precio">Precio:</label>
                    <input type="number" step="0.01" class="form-control" id="precio" name="precio" value="<%=tarifa.getPrecio()%>" required>
                </div>
                <button type="submit" class="btn btn-primary">Guardar Tarifa</button>
            </form>
        </div>
    </body>
    <script>
        const imagenInput = document.getElementById('imagen');
        const imagenPreview = document.getElementById('imagenPreview');

        imagenInput.addEventListener('change', function () {
            const archivo = imagenInput.files[0];

            if (archivo) {
                const lector = new FileReader();

                lector.addEventListener('load', function () {
                    // La imagen se carga en el atributo src de la etiqueta <img>
                    imagenPreview.src = lector.result;
                });

                lector.readAsDataURL(archivo);
            }
        });

    </script>
</html>
