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


<%@page import="Modelos.ClienteDAO"%>
<%@page import="Modelos.Cliente"%>
<%@page import="java.util.ArrayList"%>
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
            function obtenerDatosCliente(clienteId) {
                if (clienteId !== "") {
                    fetch("FacturaController?action=busquedaCliente", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "clienteId=" + clienteId
                    })
                            .then(response => response.json())
                            .then(data => {
                                // Procesar la respuesta del servlet
                                var nombre = data.nombre;
                                var documento = data.documento;
                                var email = data.email;
                                var idReservacion = data.idReservacion;
                                var fechaInicio = data.fechaInicio;
                                var fechaFinalizacion = data.fechaFinalizacion;
                                var numeroHabitacion = data.numeroHabitacion;
                                var tipoHabitacion = data.tipoHabitacion;
                                var precioNoche = data.precioNoche;
                                var totalDias = data.totalDias;
                                var subtotal = data.precioNoche * data.totalDias;
                                var iva = subtotal * 0.12;
                                var total = subtotal + iva;

                                console.log(data);

                                // Actualizar los campos con los datos obtenidos
                                document.getElementById("nombre").value = nombre;
                                document.getElementById("documento").value = documento;
                                document.getElementById("email").value = email;
                                document.getElementById("idReservacion").value = idReservacion;
                                document.getElementById("fechaInicio").value = fechaInicio;
                                document.getElementById("fechaFinalizacion").value = fechaFinalizacion;
                                document.getElementById("idHabitacion").value = numeroHabitacion;
                                document.getElementById("tipoHabitacion").value = tipoHabitacion;
                                document.getElementById("precioNoche").value = precioNoche;
                                document.getElementById("totalDias").value = totalDias;
                                document.getElementById("subtotal").value = subtotal;
                                document.getElementById("iva").value = iva;
                                document.getElementById("total").value = total;

                            })
                            .catch(error => {
                                // Manejar el error de la solicitud AJAX
                                console.error(error);
                            });
                } else {
                    // Limpiar los campos si no se selecciona ningún cliente
                    document.getElementById("nombre").value = "";
                    document.getElementById("documento").value = "";
                    document.getElementById("email").value = "";
                    document.getElementById("idReservacion").value = "";
                    document.getElementById("fechaInicio").value = "";
                    document.getElementById("fechaFinalizacion").value = "";
                    document.getElementById("idHabitacion").value = "";
                    document.getElementById("tipoHabitacion").value = "";
                    document.getElementById("precioNoche").value = "";
                    document.getElementById("totalDias").value = "";
                    document.getElementById("subtotal").value = "";
                    document.getElementById("iva").value = "";
                    document.getElementById("total").value = "";
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
            <h4>Facturación</h4>
            <form action="FacturaController?action=guardar" method="post">
                <div class="form-group">
                    <label for="cliente">Cliente:</label>
                    <select class="form-control" id="idCliente" name="idCliente" onchange="obtenerDatosCliente(this.value)">
                        <option value="">Seleccione un cliente</option>
                        <% ArrayList<Cliente> clientes = new ClienteDAO().getClientes();
                            for (Cliente cliente : clientes) {%>
                        <option value="<%= cliente.getId()%>"><%= cliente.getNombreCompleto()%></option>
                        <% }%>
                    </select>
                </div>
                <div class="row">
                    <div class="form-group col">
                        <label for="nombre">Nombre:</label>
                        <input type="text" class="form-control form-control-inline" id="nombre" name="nombre" readonly>
                    </div>
                    <div class="form-group col">
                        <label for="documento">Documento:</label>
                        <input type="text" class="form-control form-control-inline" id="documento" name="documento" readonly>
                    </div>
                    <div class="form-group col">
                        <label for="email">Email:</label>
                        <input type="text" class="form-control form-control-inline" id="email" name="email" readonly>
                    </div>
                </div>

                <h4>Detalles de la reservacion</h4>
                <div class="row">
                    <input type="hidden" name="idReservacion" id="idReservacion" value="">
                    <div class="form-group col-3">
                        <label for="fechaInicio">Fecha de Inicio:</label>
                        <input type="text" class="form-control" id="fechaInicio"  name="fechaInicio" readonly>
                    </div>
                    <div class="form-group col-3">
                        <label for="fechaFinalizacion">Fecha de Finalización:</label>
                        <input type="text" class="form-control" id="fechaFinalizacion" name="fechaFinalizacion" readonly>
                    </div>
                    <div class="form-group col-3">
                        <label for="numeroHabitacion">Número de Habitación:</label>
                        <input type="text" class="form-control" id="idHabitacion" name="idHabitacion" readonly>
                    </div>
                    <div class="form-group col-3">
                        <label for="tipoHabitacion">Tipo de Habitación:</label>
                        <input type="text" class="form-control" id="tipoHabitacion" name="tipoHabitacion" readonly>
                    </div>
                    <div class="form-group col-3">
                        <label for="tipoHabitacion">Valor:</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="precioNoche" name="precioNoche" aria-label="Amount (to the nearest dollar)">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-3">
                        <label for="tipoHabitacion">Total de dias:</label>
                        <input type="text" class="form-control" id="totalDias" name="totalDias" readonly>
                    </div>
                </div>

                <h4>Pago</h4>
                <div class="form-group col-3">
                    <label for="subtotal">Subtotal:</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <input type="text" class="form-control" id="subtotal" name="subtotal" aria-label="Amount (to the nearest dollar)">
                        <div class="input-group-append">
                            <span class="input-group-text">.00</span>
                        </div>
                    </div>
                </div>
                <div class="form-group col-3">
                    <label for="iva">IVA 12%</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <input type="text" class="form-control" id="iva" name="iva" aria-label="Amount (to the nearest dollar)">
                        <div class="input-group-append">
                            <span class="input-group-text">.00</span>
                        </div>
                    </div>
                </div>
                <div class="form-group col-3">
                    <label for="total">Total: </label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">$</span>
                        </div>
                        <input type="text" class="form-control" id="total" name="total" aria-label="Amount (to the nearest dollar)">
                        <div class="input-group-append">
                            <span class="input-group-text">.00</span>
                        </div>
                    </div>
                </div>
                <div class="form-group col-3">
                    <label for="total">Tipo Pago: </label>
                    <div class="input-group mb-3">
                        <select class="form-control" id="tipoPago" name="tipoPago" required>
                            <option value="efectivo">EFECTIVO</option>
                            <option value="transferencia">TRANSFERENCIA</option>
                            <option value="debito">PAGO CON TARJETA DE DEBITO</option>
                            <option value="credito">PAGO CON TARJETA DE CREDITO</option>
                        </select>
                    </div>
                </div>
                <div class="form-group d-flex">
                    <button type="submit" class="btn btn-primary flex-fill">Generar Factura</button>
                </div>
            </form>
        </div>
    </body>
</html>
