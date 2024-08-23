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

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/resources/jquery-3.5.1.slim.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/bootstrap.bundle.min.js"></script>

        <!-- Custom File's Link -->
        <link rel="stylesheet" href="css/css.css">
        <link rel="stylesheet" href="css/responsive-style.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <script>
            function buscarCliente() {
                let cedula = $("#cedula").val();

                if (cedula.length > 0) {
                    $.ajax({
                        url: "ReservacionController?action=busquedaReservasCliente",
                        method: "POST",
                        data: {cedula: cedula},
                        success: function (data) {
                            // Procesar los datos recibidos y construir la tabla
                            console.log(data);
                            if (data.length > 0) {
                                construirTabla(data);
                            } else {
                                // Ocultar el campo de búsqueda y mostrar la tabla
                                $("#tablaCliente").show();
                                // Limpiar la tabla
                                $("#tablaClienteBody").empty();
                                $("#tablaClienteBody").append("<tr><td>No existen registros para el cliente</td><td>");
                            }

                        },
                        error: function () {
                            alert("Error al buscar el cliente.");
                        }
                    });
                } else {
                    alert("Ingrese la cedula del cliente");
                }


            }

            function eliminarReservacion(idReservacion) {
                $.ajax({
                    url: 'ReservacionController?action=delete',
                    type: 'POST', // O 'GET' si prefieres enviar la solicitud GET
                    data: {idReservacion: idReservacion},
                    success: function (data) {
                        buscarCliente();
                        console.log(data);
                    },
                    error: function (error) {
                        // La solicitud AJAX falló, aquí puedes manejar el error si es necesario
                        console.error('Error al eliminar la reservación: ' + error.statusText);
                    }
                });
            }


            function construirTabla(data) {
                // Ocultar el campo de búsqueda y mostrar la tabla
                $("#tablaCliente").show();

                // Limpiar la tabla
                $("#tablaClienteBody").empty();

                // Construir las filas de la tabla con los datos recibidos
                for (let i = 0; i < data.length; i++) {
                    let reservacion = data[i];

                    let acciones = '<td><a class="btn btn-primary btn-sm" href="detalleReservacion.jsp?idReservacion=' + reservacion.id + '">Ver detalle</a> ' +
                            '<a class="btn btn-danger btn-sm" onclick="eliminarReservacion(' + reservacion.id + ')">Eliminar</a></td></tr>';

                    let row = "<tr><td>" + reservacion.id + "</td><td>" + reservacion.idHabitacion + "</td><td>" + reservacion.fechaInicio + "</td><td>" + reservacion.fechaFin + "</td>";
                    row = row + acciones;

                    console.log(row);
                    $("#tablaClienteBody").append(row);
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
        <div class="container">
            <h1 style="color: #000;font-size: 30px;margin-top: 10px">Busqueda de reservacion</h1>
            <main class="mt-4">

                <div class="form-group">
                    <label for="cedula" class="fw-bold mb-2 col-4">Ingrese cédula del cliente:</label>
                    <div class="input-group col-8 w-50">
                        <input type="text" class="form-control" id="cedula" name="cedula" required>
                        <button class="btn btn-primary" onclick="buscarCliente()">Buscar</button>
                    </div>
                </div>
                <!-- Div para mostrar la tabla -->
                <div id="tablaCliente" style="padding: 16px;display: none">
                    <table class="table table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th>Numero de reservacion</th>
                                <th>Habitacion</th>
                                <th>Fecha de entrada</th>
                                <th>Fecha de salida</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tablaClienteBody">
                            <!-- Aquí se mostrarán las filas de la tabla -->
                        </tbody>
                    </table>
                </div>
            </main>
        </div>

        <!-- Navbar section exit -->

    </body>

</html> 