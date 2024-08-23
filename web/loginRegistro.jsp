
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de sesion</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/resources/jquery-3.5.1.slim.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/bootstrap.bundle.min.js"></script>

        <style>

            body {
                background-image: url("${pageContext.request.contextPath}/resources/fondo3.jpg");
                background-repeat: no-repeat;
                background-size: cover;

            }

            .login-container {
                width: 600px;
                margin: 0 auto;
                margin-top: 100px;
                background-color: rgba(0, 0, 0, 0.7);
                padding: 10px;
            }

            .labelLogin{
                color: white;
            }

        </style>
    </head>
    <body>
        <div class="container login-container">
            <h2 class="text-center labelLogin">Registro de usuario</h2>

            <form action="UsuarioController?action=guardarUserCliente" method="post">
                <div class="row">
                    <div class="form-group col-6">
                        <label for="nombre" class="labelLogin">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="form-group col-6">
                        <label for="apellido" class="labelLogin">Apellido:</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" required>
                    </div>
                    <div class="form-group col-6">
                        <label for="tipoDocumento" class="labelLogin">Tipo de Documento:</label>
                        <select class="form-control" id="tipoDocumento" name="tipoDocumento" required>
                            <option value="Pasaporte">Pasaporte</option>
                            <option value="Cedula">Cedula</option>
                        </select>
                    </div>
                    <div class="form-group col-6">
                        <label for="numeroDocumento" class="labelLogin">Número de Documento:</label>
                        <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" required>
                    </div>
                    <div class="form-group col-6">
                        <label for="correo" class="labelLogin">Correo Electrónico:</label>
                        <input type="email" class="form-control" id="correo" name="correo" required>
                    </div>
                    <div class="form-group col-6">
                        <label for="telefono" class="labelLogin">Teléfono:</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" required>
                    </div>
                    <div class="form-group col-6">
                        <label for="username" class="labelLogin">Usuario:</label>
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="form-group col-6">
                        <label for="password" class="labelLogin" class="labelLogin">Contraseña:</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Registrar</button>
            </form>
        </div>
    </body>
</html>
