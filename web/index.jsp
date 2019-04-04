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
        <title>Iniciar sesión</title>
        <link href="//oss.maxcdn.com/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!-- Optional theme -->

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

            <center><img src="image/logopacifico.png" width="250" height="150" alt="" class="img-circle"/></center>

            <form action="sesion.do" method="post" id="FormLogin">
                <div class="form-group">
                    <input type="hidden" name="accion" value="entrar">
                    <p  class="alert alert-danger" style="color:#ff0000;<c:if var="prueba" test="${mensaje == null}" > display: none; </c:if>">${mensaje}</p> 
                    <label for="usuario">Nombre de usuario</label>
                    <input type="text" class="form-control"  id="usuario" placeholder="Usuario" name="usuario" >
                </div>
                <div class="form-group">

                    <label >Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-addon" onclick="mostrarContra()"><span onclick="mostrarContra()" id="span" class="glyphicon glyphicon-eye-open {toggleClass}"></span></span>
                        <input type="password" class="form-control"  id="password" placeholder="Contraseña" name="password" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" id="btnIngresar">Iniciar sesión</button><br><br>
                <!--                    <center><a href="Registro.jsp" >No tengo un usuario</a></center>-->
            </form>
        </div>
        <script src="//oss.maxcdn.com/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
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

                            $(document).ready(function () {
                                $("#FormLogin").bootstrapValidator({
                                    message: 'Este valor no es valido',
                                    feedbackIcons: {
                                        valid: 'glyphicon glyphicon-ok',
                                        invalid: 'glyphicon glyphicon-remove',
                                        validating: 'glyphicon glyphicon-refresh'
                                    },
                                    fields: {
                                        usuario: {
                                            validators: {
                                                notEmpty: {
                                                    message: "El usuario es requerido \n para iniciar sesion"
                                                }
                                            }
                                        },
                                        password: {
                                            validators: {
                                                notEmpty: {
                                                    message: "Ingrese Contraseña"
                                                }
                                            }
                                        }
                                    }
                                });
                            });
        </script>
    </body>
</html>
