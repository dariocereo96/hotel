<%-- 
    Document   : iniciocliente
    Created on : 17 jul 2023, 20:21:06
    Author     : JOSELYN
--%>

<%@page import="Modelos.Tarifa"%>
<%@page import="Modelos.TarifaDAO"%>
<%@page import="Modelos.Habitacion"%>
<%@page import="Modelos.HabitacionDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hotel Website</title>

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
            List<Tarifa> tarifas = new TarifaDAO().obtenerTarifasCategoria(request.getParameter("categoria").trim().toLowerCase());

        %>

        <!-- Rooms section -->
        <section id="rooms" class="container">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12 section-title text-center">
                        <h3>SERVICIOS PARA TI</h3>
                    </div>
                </div>
                <div class="row m-0">


                    <%for (Tarifa tarifa : tarifas) {%>

                    <div class="col-md-4 mb-4 mb-lg-0">
                        <div class="room-item mb-4 p-2">
                            <img decoding="async" src="data:image/png;base64,<%=tarifa.getImagen()%>" width="100%" height="300px">
                            <div>
                                <h4 style="text-align: center;padding-top: 10px;color: #007bff"><%=tarifa.getDescripcion().toUpperCase()%></h4>
                                <p style="color: black"><strong>Precio: </strong>$ <%=tarifa.getPrecio()%></p>
                            </div>
                        </div> 
                    </div>


                    <% }%>


                </div>
            </div>
        </section>
        <!-- Rooms Section Exit -->


    </section>
    <!-- Footer section exit -->

    <!-- Bootstrap 5 JS CDN Links -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js"></script>

    <!-- Swiper JS -->
    <script src="https://unpkg .com/swiper/swiper-bundle.min.js"></script>

    <!-- Custom Js Link -->
    <script src="js/main.js"></script>
</body>

</html>
