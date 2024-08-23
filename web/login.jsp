<%-- 
    Document   : index
    Created on : 14/07/2023, 22:44:25
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Verificar si hay un error en el inicio de sesión y mostrar un mensaje correspondiente --%>
<%

    if (session != null && session.getAttribute("usuario") != null) {
        response.sendRedirect("principal.jsp");
    }

    String error = request.getParameter("error");
    String errorMessage = "";
    int intentos;
    int intentosRestantes;

    if (error != null && error.equals("1")) {
        errorMessage = "Usuario no esta registado en el sistema";
    }

    if (error != null && error.equals("2")) {
        intentos = Integer.parseInt(session.getAttribute("intentosFallidos").toString());
        intentosRestantes = 3 - intentos;
        errorMessage = "Contraseña incorrecta, tienes " + intentosRestantes + " intentos, si no tu usuario se bloqueara.";
    }

    if (error != null && error.equals("3")) {
        errorMessage = "Cuenta bloqueada, contacte con el administrado.";
    }

%>



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
                width: 400px;
                margin: 0 auto;
                margin-top: 100px;
                background-color: rgba(0, 0, 0, 0.7);
                padding: 25px;
            }

            .labelLogin{
                color: white;
            }

        </style>
    </head>
    <body>
        <div class="container login-container">
            <h2 class="text-center labelLogin">Inicio de Sesión</h2>
            <%-- Mostrar mensaje de error si corresponde --%>
            <% if (!errorMessage.isEmpty()) {%>
            <div class="alert alert-danger">
                <%= errorMessage%>
            </div>
            <% }%>
            <form action="UsuarioController?action=login" method="post">
                <div class="form-group">
                    <label for="username" class="labelLogin">Usuario:</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Ingrese su usuario" required="">
                </div>
                <div class="form-group">
                    <label for="password" class="labelLogin">Contraseña:</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su contraseña" required="">
                </div>

                <button type="submit" class="btn btn-primary btn-block">Iniciar sesion</button>
                <a href="index.jsp" class="btn btn-secondary btn-block">Regresar al inicio</a>
                <!--
                 <label class="labelLogin font-weight-bold p-2">¿No estas registrado? <a href="loginRegistro.jsp">Click para registrarte</a</label>
                -->
            </form>
        </div>
    </body>
</html>
