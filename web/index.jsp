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

        <!-- Banner section -->
        <section id="home" class="banner_wrapper p-0">
            <div class="swiper mySwiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" style="background-image: url(./images/slider/slider2.webp);">
                        <div class="slide-caption text-center">
                            <div>
                                <h1>BIENVENIDO AL HOTEL JM&A</h1>
                                <p> Tenemos el mejor resort para que te sientas 
                                    como en casa, ven y disfruta de tus vacaciones junto a la naturaleza,. </p>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide" style="background-image: url(./images/slider/slider1.webp);">
                        <div class="slide-caption text-center">
                            <div>
                                <h1>BIENVENIDO AL HOTEL JM&A</h1>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                                    incididunt ut labore et dolore magna aliqua. Ut enim </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="swiper-pagination"></div>
            </div>
            <div class="container booking-area">
                <form class="row">
                    <div class="col-lg mb-3 mb-lg-0">
                        <input type="date" class="form-control" placeholder="Date">
                    </div>
                    <div class="col-lg mb-3 mb-lg-0">
                        <input type="date" class="form-control" placeholder="Date">
                    </div>
                    <div class="col-lg mb-3 mb-lg-0">
                        <select class="form-select">
                            <option selected>Adults</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                        </select>
                    </div>
                    <div class="col-lg mb-3 mb-lg-0">
                        <select class="form-select">
                            <option selected>Children</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                        </select>
                    </div>
                    <div class="col-lg mb-3 mb-lg-0">
                        <button type="submit" class="main-btn rounded-2 px-lg-3">Check Availability</button>
                    </div>
                </form>
            </div>
        </section>
        <!-- Banner section exit -->

        <!-- About section -->
        <section id="about" class="about_wrapper">
            <div class="container">
                <div class="row flex-lg-row flex-column-reverse ">
                    <div class="col-lg-6 text-center text-lg-start">
                        <h3>Welcome to <span>Hotel <br class="d-none d-lg-block">
                                the haven</span> of your weekend</h3>
                        <p style="color: #000">Disfrute de elegancia y lujo en el impresionante JM&A Hotel Quito, ubicado en el centro de la capital de Ecuador. 
                            Las lujosas habitaciones de nuestro hotel en Quito ofrecen elegante estilo y comodidades de primera clase. Para una experiencia exclusiva 
                            y amenidades adicionales como balcones privados y desayuno gratuito, elija una de nuestras lujosas suites o habitaciones ejecutivas en Quito</p>
                        <a href="#" class="main-btn mt-4">Explore</a>
                    </div>
                    <div class="col-lg-6 mb-4 mb-lg-0 ps-lg-4 text-center">
                        <img decoding="async" src="images/about-img.svg" class="img-fluid" alt="About Us">
                    </div>

                </div>
            </div>
        </section>
        <!-- About section exit -->


        <!-- Footer section -->
        <section id="contact" class="footer_wrapper mt-3 mt-md-0 pb-0">
            <div class="container pb-3">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <h5>Hotel Location</h5>
                        <p class="ps-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim erat ut laoreet
                            pharetra....</p>
                        <div class="contact-info">
                            <ul class="list-unstyled">
                                <li><a href="#"><i class="fa fa-home me-3"></i> No. 96, South City, London</a></li>
                                <li><a href="#"><i class="fa fa-phone me-3"></i>+1 222 3333</a></li>
                                <li><a href="#"><i class="fa fa-envelope me-3"></i>info@example.com</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>More Links</h5>
                        <ul class="link-widget p-0">
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Our Office</a></li>
                            <li><a href="#">Delivery</a></li>
                            <li><a href="#">Our Store</a></li>
                            <li><a href="#">Guarantee</a></li>
                            <li><a href="#">Buy Gift Card</a></li>
                            <li><a href="#">Return Policy</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>Demo Links</h5>
                        <ul class="link-widget p-0">
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Our Office</a></li>
                            <li><a href="#">Delivery</a></li>
                            <li><a href="#">Our Store</a></li>
                            <li><a href="#">Guarantee</a></li>
                            <li><a href="#">Buy Gift Card</a></li>
                            <li><a href="#">Return Policy</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>Newsletter</h5>
                        <div class="form-group mb-4">
                            <input type="email" class="form-control bg-transparent" placeholder="enter your email here">
                            <button type="submit" class="main-btn rounded-2 mt-3 border-white text-white">Subscribe</button>
                        </div>
                        <h5>Stay Connected</h5>
                        <ul class="social-network d-flex align-items-center p-0">
                            <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                            <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                            <li><a href="#"><i class="fab fa-vimeo-v"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="container-fluid copyright-section">
                <p>Copyright <a href="#">Â© CODE4EDUCATION.</a> All Rights Reserved</p>
            </div>
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
