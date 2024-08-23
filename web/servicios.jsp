<%-- 
    Document   : iniciocliente
    Created on : 17 jul 2023, 20:21:06
    Author     : JOSELYN
--%>

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

        <!-- Services section -->
        <section id="services" class="services_wrapper">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 section-title text-center mb-5">
                        <h6>We Are Here For You</h6>
                        <h3>Nuestros servicios</h3>
                    </div>
                </div>
                <div class="row align-items-center service-item-wrap">
                    <div class="col-lg-7 p-lg-0">
                        <!--Service Area Start-->
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade active show" id="spa" role="tabpanel">

                                <img decoding="async" src="./images/services/service1.webp" alt="">
                            </div>
                            <div class="tab-pane fade" id="restaurent" role="tabpanel">
                                <img decoding="async" src="./images/services/service2.webp" alt="">
                            </div>
                            <div class="tab-pane fade" id="swimming" role="tabpanel">
                                <img decoding="async" src="images/services/service3.webp" alt="">
                            </div>
                            <div class="tab-pane fade" id="conference" role="tabpanel">
                                <img decoding="async" src="./images/services/service6.webp" alt="">
                            </div>
                        </div>
                        <!--Service Area End-->
                    </div>
                    <div class="col-lg-5 position-relative">
                        <!--Service Tab Menu Area Start-->
                        <div class="service-menu-area">
                            <ul class="nav">
                                <li>
                                    <a href="detalleServicio.jsp?categoria=bienestar" class="active">
                                        <span class="service-icon">
                                            <img decoding="async" src="./images/services/service-icon1.webp" alt="">
                                        </span>
                                        <h5>BIENESTAR</h5>
                                        <p><span>Spa and beauty </span>luptatem quia voluptas sit aspernatur aut odit aut
                                            fugit, sed quia </p>
                                    </a>
                                </li>
                                <li>
                                    <a href="detalleServicio.jsp?categoria=alimentacion">
                                        <span class="service-icon">
                                            <img decoding="async" src="./images/services/service-icon2.webp" alt="">
                                        </span>
                                        <h5>RESTAURANTES</h5>
                                        <p><span>Restaurant</span> lup provide grro tatem quia voluptas sit aspernatur aut
                                            odit aut fugit, </p>
                                    </a>
                                </li>
                                <li>
                                    <a href="detalleServicio.jsp?categoria=entretenimiento">
                                        <span class="service-icon">
                                            <img decoding="async" src="./images/services/service-icon3.webp" alt="">
                                        </span>
                                        <h5>ENTRETENIMIENTO Y RELAJACION</h5>
                                        <p><span>Swimming</span> pool luptatem quia voluptas sit aspernatur aut odit aut
                                            fugit, sed quia </p>
                                    </a>
                                </li>

                            </ul>
                        </div>
                        <!--Service Tab Menu Area End-->
                    </div>
                </div>
            </div>

        </section>

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
