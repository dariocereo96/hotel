<%-- 
    Document   : iniciocliente
    Created on : 17 jul 2023, 20:21:06
    Author     : JOSELYN
--%>

<%@page import="Modelos.FacturaDAO"%>
<%@page import="Modelos.Factura"%>
<%@page import="Modelos.ClienteDAO"%>
<%@page import="Modelos.Cliente"%>
<%@page import="Modelos.ReservacionDAO"%>
<%@page import="Modelos.Reservacion"%>
<%@page import="Modelos.Reservacion"%>
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

        <%
            Reservacion reservacion = new ReservacionDAO().buscarReservacion(Integer.parseInt(request.getParameter("idReservacion")));
            Cliente cliente = new ClienteDAO().buscarCliente(reservacion.getIdCliente());
            Habitacion habitacion = new HabitacionDAO().buscarHabitacion(reservacion.getIdHabitacion());
            Factura factura = new FacturaDAO().buscarFacturaIdReservacion(Integer.parseInt(request.getParameter("idReservacion")));
        %>


        <div class="container shadow px-4" style="width: 1000px">

            <form action="ReservacionControl    ler?action=reservacionCliente" method="post" class="mt-4">
                <h1 style="color: #000;font-size: 35px;padding-top: 20px">Número de reservación: <%= request.getParameter("idReservacion")%></h1>
                <div class="row">
                    <div class="form-group col-4">
                        <label for="nombre">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%= cliente.getNombre()%>" readonly="">
                    </div>
                    <div class="form-group col-4">
                        <label for="apellido">Apellido:</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" value="<%= cliente.getApellido()%>"  readonly="">
                    </div>
                    <div class="form-group col-4">
                        <label for="tipoDocumento">Tipo de Documento:</label>
                        <input type="text" class="form-control" id="tipodocumento" name=tipodocumento" value="<%=cliente.getTipoDocumento()%>" readonly="">
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="numeroDocumento">Número de Documento:</label>
                        <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" value="<%= cliente.getNumeroDocumento()%>" readonly="">
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="correo">Correo Electrónico:</label>
                        <input type="email" class="form-control" id="correo" name="correo" value="<%= cliente.getCorreo()%>" readonly="">
                    </div>
                    <div class="form-group col-4 mt-4">
                        <label for="telefono">Teléfono:</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" value="<%= cliente.getTelefono()%>" readonly="">
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="form-group col-6">
                        <label for="habitacion">Habitacion</label>
                        <input type="text" class="form-control" id="detalleHabitacion" name="detalleHabitacion" value="<%=habitacion.getDatoHabitacion()%>" readonly="">
                    </div>
                    <div class="form-group col-3">
                        <label for="numeroHabitacion">Número de Habitación:</label>
                        <input type="text" class="form-control" id="idNumero" name="idNumero" value="<%= habitacion.getId()%>" readonly="">
                    </div>
                    <div class="form-group col-3">
                        <label for="numeroPersonas">Numero de personas:</label>
                        <input type="text" class="form-control" id="numeroPersonas" name="numeroPersonas" value="<%=reservacion.getOcupantes()%>" readonly>
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="fechaInicio">Fecha de entrada:</label>
                        <input type="date" value="<%= reservacion.getFechaInicio()%>" class="form-control" id="fechaInicio" name="fechaInicio" readonly="">
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="fechaFin">Fecha de salida</label>
                        <input type="date" value="<%= reservacion.getFechaFin()%>" class="form-control" id="fechaFin" name="fechaFin" readonly="">
                    </div>
                    <div class="form-group col-6 mt-4">
                        <label for="valorNoche">Valor del hospedaje diario</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="precioNoche" name="precioNoche" value="<%= habitacion.getPrecioNoche()%>" readonly>
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-4">
                        <label for="subtotal">Subtotal:</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="subtotal" name="subtotal" value="<%= factura.getSubtotal()%>" readonly="">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-4">
                        <label for="iva">IVA 12%</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="iva" name="iva" value="<%= factura.getIva()%>" readonly="">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-4">
                        <label for="iva">Tipo Pago</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="iva" name="iva" value=" <%= factura.getTipoPago().toUpperCase()%> " readonly="">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-4">
                        <label for="total">Total: </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">$</span>
                            </div>
                            <input type="text" class="form-control" id="total" name="total" value="<%= factura.getTotal()%>" readonly="">
                            <div class="input-group-append">
                                <span class="input-group-text">.00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group d-flex py-4">
                    <a href="index.jsp" class="btn btn-primary flex-fill">Regresar al inicio</a>
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
