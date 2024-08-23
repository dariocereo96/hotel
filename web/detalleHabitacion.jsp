<%-- 
    Document   : iniciocliente
    Created on : 17 jul 2023, 20:21:06
    Author     : JOSELYN
--%>

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

        <style>
            .slide {
                position: relative;
                box-shadow: 0px 1px 6px rgba(0, 0, 0, 0.64);
            }
            .slide-inner {
                position: relative;
                overflow: hidden;
                width: 100%;
                height: calc( 300px + 3em);
            }
            .slide-open:checked + .slide-item {
                position: static;
                opacity: 100;
            }
            .slide-item {
                position: absolute;
                opacity: 0;
                -webkit-transition: opacity 0.6s ease-out;
                transition: opacity 0.6s ease-out;
            }
            .slide-item img {
                height: auto;
                width: 100%;
            }
            .slide-control {
                background: rgba(0, 0, 0, 0.28);
                border-radius: 50%;
                color: #fff;
                cursor: pointer;
                display: none;
                font-size: 40px;
                height: 40px;
                line-height: 35px;
                position: absolute;
                top: 50%;
                -webkit-transform: translate(0, -50%);
                cursor: pointer;
                -ms-transform: translate(0, -50%);
                transform: translate(0, -50%);
                text-align: center;
                width: 40px;
                z-index: 10;
            }
            .slide-control.prev {
                left: 2%;
            }
            .slide-control.next {
                right: 2%;
            }
            .slide-control:hover {
                background: rgba(0, 0, 0, 0.8);
                color: #aaaaaa;
            }
            #slide-1:checked ~ .control-1,
            #slide-2:checked ~ .control-2,
            #slide-3:checked ~ .control-3 {
                display: block;
            }
            .slide-indicador {
                list-style: none;
                margin: 0;
                padding: 0;
                position: absolute;
                bottom: 2%;
                left: 0;
                right: 0;
                text-align: center;
                z-index: 10;
            }
            .slide-indicador li {
                display: inline-block;
                margin: 0 5px;
            }
            .slide-circulo {
                color: #828282;
                cursor: pointer;
                display: block;
                font-size: 35px;
            }
            .slide-circulo:hover {
                color: #aaaaaa;
            }
            #slide-1:checked ~ .control-1 ~ .slide-indicador 
            li:nth-child(1) .slide-circulo,
            #slide-2:checked ~ .control-2 ~ .slide-indicador 
            li:nth-child(2) .slide-circulo,
            #slide-3:checked ~ .control-3 ~ .slide-indicador 
            li:nth-child(3) .slide-circulo {
                color: #428bca;
            }
            #titulo {
                width: 100%;
                position: absolute;
                padding: 0px;
                margin: 0px auto;
                text-align: center;
                font-size: 27px;
                color: rgba(255, 255, 255, 1);
                font-family: 'Open Sans', sans-serif;
                z-index: 9999;
                text-shadow: 0px 1px 2px rgba(0, 0, 0, 0.33), 
                    -1px 0px 2px rgba(255, 255, 255, 0);
            }
        </style>

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
                                <a class="main-btn" href="listaHabitaciones.jsp" style="font-weight: bold;color: #fff">Reservar</a>
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
            Habitacion habitacion = new HabitacionDAO().buscarHabitacion(Integer.parseInt(request.getParameter("id")));

        %>



        <!-- Rooms section -->
        <section class="container">

            <h3>Habitacion N° <%=habitacion.getId()%></h3>

            <div class="row">
                <div class="slide col-7">
                    <div class="slide-inner">
                        <input class="slide-open" type="radio" id="slide-1" 
                               name="slide" aria-hidden="true" hidden="" checked="checked">
                        <div class="slide-item">
                            <img src="ImagenController?nombre=<%=habitacion.getImagenes().get(0)%>">
                        </div>
                        <input class="slide-open" type="radio" id="slide-2" 
                               name="slide" aria-hidden="true" hidden="">
                        <div class="slide-item">
                            <img src="ImagenController?nombre=<%=habitacion.getImagenes().get(1)%>">
                        </div>
                        <input class="slide-open" type="radio" id="slide-3" 
                               name="slide" aria-hidden="true" hidden="">
                        <div class="slide-item">
                            <img src="ImagenController?nombre=<%=habitacion.getImagenes().get(2)%>">
                        </div>
                        <label for="slide-3" class="slide-control prev control-1">‹</label>
                        <label for="slide-2" class="slide-control next control-1">›</label>
                        <label for="slide-1" class="slide-control prev control-2">‹</label>
                        <label for="slide-3" class="slide-control next control-2">›</label>
                        <label for="slide-2" class="slide-control prev control-3">‹</label>
                        <label for="slide-1" class="slide-control next control-3">›</label>
                        <ol class="slide-indicador">
                            <li>
                                <label for="slide-1" class="slide-circulo">•</label>
                            </li>
                            <li>
                                <label for="slide-2" class="slide-circulo">•</label>
                            </li>
                            <li>
                                <label for="slide-3" class="slide-circulo">•</label>
                            </li>
                        </ol>
                    </div>
                </div>
                <div class="col-5">
                    <h4>Descripcion</h4>
                    <p style="color: #828282"><%=habitacion.getDescripcion()%></p>
                    <p style="color: #000"><strong>Precio: </strong>$ <%=habitacion.getPrecioNoche()%></p>
                    <p style="color: #000"><strong>Capacidad: </strong><%=habitacion.getCapacidad()%> personas</p>
                    <a href="pageReservacion2.jsp?id=<%=habitacion.getId()%>" class="btn btn-success d-block fw-bold">RESERVAR</a>
                </div> 

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
