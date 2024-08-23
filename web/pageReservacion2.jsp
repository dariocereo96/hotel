<%-- 
    Document   : iniciocliente
    Created on : 17 jul 2023, 20:21:06
    Author     : JOSELYN
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Modelos.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.HabitacionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hotel Website Design by Code4education</title>

        <!-- FAVICON -->
        <link rel="icon" type="image/png" href="images/favicon.png">

        <!-- Bootstrap 5 CDN Links -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- Link Swiper's CSS -->
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

        <!-- Custom File's Link -->
        <link rel="stylesheet" href="css/css.css">
        <link rel="stylesheet" href="css/responsive-style.css">

        <script>

            function obtenerDatosHabitacion(idHabitacion) {
                if (idHabitacion !== "") {
                    fetch("ReservacionController?action=busquedaHabitacion", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "idHabitacion=" + idHabitacion
                    })
                            .then(response => response.json())
                            .then(data => {
                                // Procesar la respuesta del servlet
                                let idHabitacion = data.idHabitacion;
                                let capacidad = data.capacidad;
                                let precioNoche = data.precioNoche;
                                let tipo = data.tipo;

                                console.log(data);

                                //Actualizar los campos con los datos obtenidos
                                document.getElementById("idNumero").value = idHabitacion;
                                document.getElementById("ocupantes").value = capacidad;
                                document.getElementById("precioNoche").value = precioNoche;

                                obtenerDias();





                            })
                            .catch(error => {
                                // Manejar el error de la solicitud AJAX
                                console.error(error);
                            });
                } else {
                    // Limpiar los campos si no se selecciona ningún cliente
                    //Actualizar los campos con los datos obtenidos
                    document.getElementById("idNumero").value = "";
                    document.getElementById("ocupantes").value = "";
                    document.getElementById("precioNoche").value = "";
                    document.getElementById("totalDias").value = "";
                    document.getElementById("subtotal").value = "";
                    document.getElementById("iva").value = "";
                    document.getElementById("total").value = "";

                }
            }


            function obtenerDias() {
                // Obtener el elemento del campo de entrada de las fechas
                let fechaInicio = document.getElementById("fechaInicio");
                let fechaFin = document.getElementById("fechaFin");

                // Obtener el valor del campo de entrada (formato "YYYY-MM-DD")
                let valorFechaInicio = fechaInicio.value.trim();
                let valorFechaFin = fechaFin.value.trim();

                // Validar que se haya seleccionado una fecha
                if (valorFechaInicio.length > 0 && valorFechaFin.length > 0) {
                    const fechaInicioObj = new Date(valorFechaInicio);
                    const fechaFinObj = new Date(valorFechaFin);

                    // Calcular la diferencia en milisegundos entre las dos fechas
                    const diferenciaEnMilisegundos = fechaFinObj - fechaInicioObj;

                    // Convertir la diferencia en milisegundos a días
                    const milisegundosEnUnDia = 24 * 60 * 60 * 1000;
                    const diferenciaEnDias = diferenciaEnMilisegundos / milisegundosEnUnDia;

                    document.getElementById("totalDias").value = diferenciaEnDias;

                    let precioNoche = document.getElementById("precioNoche").value;

                    let subtotal = precioNoche * diferenciaEnDias;

                    document.getElementById("subtotal").value = subtotal;

                    let iva = subtotal * 0.12;

                    document.getElementById("iva").value = iva;

                    let total = subtotal + iva;

                    document.getElementById("total").value = total;




                }
            }


        </script>

    </head>


    <body data-bs-spy="scroll" data-bs-target=".navbar" data-bs-offset="100">
        <!-- Navbar section -->
        <!-- Navbar section -->
        <header class="header_wrapper">
            <nav class="navbar navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand" href="#">
                        <img src="images/logo.png" class="img-fluid" alt="logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fas fa-stream navbar-toggler-icon"></i>
                    </button>

                    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                        <ul class="navbar-nav menu-navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">INICIO</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="listaHabitaciones.jsp">HABITACIONES</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="servicios.jsp">SERVICIOS</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="misReservaciones.jsp">MIS RESERVACIONES</a>
                            </li>

                            <li class="nav-item mt-3 mt-lg-0 btn-success">
                                <a class="main-btn" href="pageReservacion.jsp" style="font-weight: bold;color: #fff">Reservar</a>
                            </li>
                            <li class="nav-item mt-3 mt-lg-0 btn-danger">
                                <a class="main-btn" href="UsuarioController?action=iniciar" style="font-weight: bold;color: #fff">Login</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!-- Navbar section exit -->

        <div class="container" style="width: 900px">
            <h4 class="mt-4">Detalles del cliente</h4>
            <form action="ReservacionController?action=reservacionCliente" method="post">
                <div class="row">
                    <div class="form-group col-4">
                        <label for="nombre">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="form-group col-4">
                        <label for="apellido">Apellido:</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" required>
                    </div>
                    <div class="form-group col-4">
                        <label for="tipoDocumento">Tipo de Documento:</label>
                        <select class="form-control" id="tipoDocumento" name="tipoDocumento" required>
                            <option value="cedula">CEDULA</option>
                            <option value="ruc">RUC</option>
                            <option value="pasaporte">PASAPORTE</option>
                        </select>
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="numeroDocumento">Número de Documento:</label>
                        <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" required>
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="correo">Correo Electrónico:</label>
                        <input type="email" class="form-control" id="correo" name="correo" required>
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="telefono">Teléfono:</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" required>
                    </div>
                </div>

                <%
                    Habitacion habitacionSeleccionada = new HabitacionDAO().buscarHabitacion(Integer.parseInt(request.getParameter("id")));
                %>


                <h4 class="mt-4 mb">Detalles de la reservacion</h4>
                <div class="row">
                    <input type="hidden" name="idReservacion" id="idReservacion" value="">

                    <div class="form-group col-6">
                        <label for="habitacion">Habitaciones disponibles:</label>
                        <select class="form-control" id="idHabitacion" name="idhabitacion" onchange="obtenerDatosHabitacion(this.value)" required>
                            <option value="" selected>Seleccionar habitacion</option>
                            <% ArrayList< Habitacion> habitaciones = new HabitacionDAO().getHabitaciones(); // Obtener la lista de habitaciones desde la base de datos
                                for (Habitacion habitacion : habitaciones) {
                                    if (habitacion.isDisponible()) {%>
                            <option value="<%= habitacion.getId()%>" <%= habitacion.getId() == habitacionSeleccionada.getId() ? "selected" : ""%> ><%= habitacion.getDatoHabitacion()%></option>
                            <% }
                                }%>

                        </select>
                    </div>
                    <div class="form-group col-3">
                        <label for="numeroHabitacion">Número de Habitación:</label>
                        <input type="text" class="form-control" id="idNumero" name="idNumero" value="<%=habitacionSeleccionada.getId()%>" readonly>
                    </div>
                    <div class="form-group col-3">
                        <label for="numeroPersonas">Numero de personas:</label>
                        <input type="number" class="form-control" id="ocupantes" name="ocupantes" value="1" min="1" max="<%=habitacionSeleccionada.getCapacidad()%>" required>
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="fechaInicio">Fecha de entrada:</label>
                        <input type="date" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" min="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" class="form-control" id="fechaInicio" name="fechaInicio" onchange="obtenerDias()" required>
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="fechaFin">Fecha de salida</label>
                        <input type="date" min="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" class="form-control" id="fechaFin" name="fechaFin" onchange="obtenerDias()" required>
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="valorNoche">Valor del hospedaje diario</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="precioNoche" name="precioNoche" value="<%=habitacionSeleccionada.getPrecioNoche()%>" readonly>
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="totalDias">Total de dias:</label>
                        <input type="text" class="form-control" id="totalDias" name="totalDias" readonly="">
                    </div>
                </div>

                <h4>Pago</h4>
                <div class="row">
                    <div class="col-6"></div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="subtotal">Subtotal:</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="text" class="form-control" id="subtotal" name="subtotal" aria-label="Amount (to the nearest dollar)" readonly="">
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="iva">IVA 12%</label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="text" class="form-control" id="iva" name="iva" aria-label="Amount (to the nearest dollar)" readonly="">
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="total">Total: </label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="text" class="form-control" id="total" name="total" aria-label="Amount (to the nearest dollar)" readonly="">
                                <div class="input-group-append">
                                    <span class="input-group-text">.00</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
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
                    </div> 

                    <div class="form-group d-flex py-4">
                        <button type="submit" class="btn btn-primary flex-fill py-2">Generar Reservacion</button>
                    </div>
            </form>
        </div>


        <!-- Bootstrap 5 JS CDN Links -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js"></script>

        <!-- Swiper JS -->
        <script src="https://unpkg .com/swiper/swiper-bundle.min.js"></script>

        <!-- Custom Js Link -->
        <script src="js/main.js"></script>
    </body>

</html>
