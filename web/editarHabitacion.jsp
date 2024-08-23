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
<%@page import="Modelos.HabitacionDAO"%>
<%@page import="Modelos.Habitacion"%>
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


            function validarNumeros(input) {
                // Eliminar cualquier carácter que no sea un dígito del 0 al 9 utilizando una expresión regular
                input.value = input.value.replace(/[^\d]/g, '');
            }

            function validarNumerosDecimales(input) {

                // Reemplazar cualquier coma por un punto (para permitir el uso de decimales con punto)
                input.value = input.value.replace(/,/g, '.');

                // Permitir solo números enteros o decimales con punto
                input.value = input.value.replace(/[^\d.]/g, '');

                // Asegurarse de que solo haya un punto decimal
                if (input.value.split('.').length > 2) {
                    input.value = input.value.slice(0, -1);
                }
            }

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

            function validarNumeros(input) {
                // Eliminar cualquier carácter que no sea un dígito del 0 al 9 utilizando una expresión regular
                input.value = input.value.replace(/[^\d]/g, '');
            }

            function validarNumerosDecimales(input) {

                // Reemplazar cualquier coma por un punto (para permitir el uso de decimales con punto)
                input.value = input.value.replace(/,/g, '.');

                // Permitir solo números enteros o decimales con punto
                input.value = input.value.replace(/[^\d.]/g, '');

                // Asegurarse de que solo haya un punto decimal
                if (input.value.split('.').length > 2) {
                    input.value = input.value.slice(0, -1);
                }
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
        <div class="container">

            <%
                Habitacion habitacion = new HabitacionDAO().buscarHabitacion(Integer.parseInt(request.getParameter("idHabitacion")));
            %>


            <h1>Editar Habitación</h1>
            <form action="HabitacionController?action=editar" enctype="multipart/form-data" method="POST" onsubmit="return validarFormulario();">
                <input type="hidden" name="habitacionId" value="<%= habitacion.getId()%>">
                <div class="form-group">
                    <label>Capacidad:</label>
                    <input type="text" name="capacidad" class="form-control" value="<%= habitacion.getCapacidad()%>" oninput="validarNumeros(this)" required>
                </div>
                <div class="form-group">
                    <div class="form-group">
                        <label for="tipo">Tipo:</label>
                        <select class="form-control" id="tipo" name="tipo" required>
                            <option value="Personal" <%= habitacion.getTipo().equals("Personal") ? "selected" : ""%>>Personal</option>
                            <option value="Pareja" <%= habitacion.getTipo().equals("Pareja") ? "selected" : ""%>>Pareja</option>
                            <option value="Suit" <%= habitacion.getTipo().equals("Suit") ? "selected" : ""%>>Suit</option>
                            <option value="Familiar" <%= habitacion.getTipo().equals("Familiar") ? "selected" : ""%>>Familiar</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Precio por Noche:</label>
                    <input type="text" name="precioNoche" step="0.01" class="form-control"  oninput="validarNumerosDecimales(this)" value="<%= habitacion.getPrecioNoche()%>" required>
                </div>
                <div class="form-group">
                    <label>Imagen de referencia - Seleccionar imagen (JPG, tamaño máximo 1 MB):</label>
                    <input type="file" class="form-control" name="imagen" id="imagen" accept="image/jpeg" maxlength="1048576">
                </div>
                <div class="form-group">
                    <img id="imagenPreview" src="data:image/png;base64, <%= habitacion.getImagen()%>" width="200px" height="200px"> 
                </div>
                <div class="form-group">
                    <label for="disponible">Disponible:</label>
                    <select class="form-control" id="disponible" name="disponible" required>
                        <option value="true" <%= habitacion.isDisponible() ? "selected" : ""%>>Sí</option>
                        <option value="false" <%= !habitacion.isDisponible() ? "selected" : ""%>>No</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Guardar</button>
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
