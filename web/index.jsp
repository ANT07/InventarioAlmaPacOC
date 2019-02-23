<%-- 
    Document   : index
    Created on : 30/08/2018, 03:21:59 PM
    Author     : William Vasquez
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Iniciar sesi�n</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <style>
            body{
                background-color: #00606F;
            }
            #ContainerLogin{
                width: 350px;
                margin-top: 95px;
            }
            #FormLogin{
                margin-top: 30px;

            }
            #btnIngresar{
                width: 100%;
                height: 40px;
            }

        </style>
    </head>
    <body>
        ${NoPermiso}
        <div class="container well" id="ContainerLogin">

            <center><img src="image/ic_login.jpg" alt="" class="img-circle"/></center>

            <form action="sesion.do" method="post" id="FormLogin">
                <div class="form-group">
                    <input type="hidden" name="accion" value="entrar">
                    <p  class="alert alert-danger" style="color:#ff0000;<c:if var="prueba" test="${mensaje == null}" > display: none; </c:if>">${mensaje}</p> 
                    <label for="usuario">Nombre de usuario</label>
                    <input type="text" class="form-control"  id="usuario" placeholder="Usuario" name="usuario" required>
                </div>
                <div class="form-group">

                    <label >Contrase�a</label>
                    <div class="input-group">
                        <input type="password" class="form-control"  id="password" placeholder="Contrase�a" name="password" required>
                        <span class="input-group-addon" onclick="mostrarContra()"><span onclick="mostrarContra()" id="span" class="glyphicon glyphicon-eye-open {toggleClass}"></span></span>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" id="btnIngresar">Iniciar sesi�n</button><br><br>
                <!--                    <center><a href="Registro.jsp" >No tengo un usuario</a></center>-->
            </form>
        </div>
        <script>
            $('#span').click(mostrarContra);
            function mostrarContra() {

                var pass = document.getElementById("password");

                if (pass.type == 'password') {

                    $('#span').addClass('glyphicon glyphicon-eye-close {toggleClass}');
                    pass.type = 'text';
                } else {
                    $('#span').removeClass('glyphicon glyphicon-eye-close {toggleClass}');
                    $('#span').addClass('glyphicon glyphicon-eye-open {toggleClass}');
                    pass.type = 'password'
                }
            }
        </script>
    </body>
</html>
