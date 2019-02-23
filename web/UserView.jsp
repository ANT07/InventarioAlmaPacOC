


<%@page import="retail.modelo.servicios.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>


    </head>
    <body>
        <%@include file="/WEB-INF/jspf/NavBar.jspf"%>
        <%
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            List<Usuario> usuarios = usuarioDAO.obtenerUsuarios();
            pageContext.setAttribute("usuarios",
                    usuarios);
        %>

        <div class="container">

            <div class="row">
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Usuarios</h4>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/usuario.do" method="post" id="form">
                                    <input name="tipo" id="tipo" value="guardar" type="hidden">
                                    <input name="usuarioId" id="usuarioId" type="hidden" value="0">
                                    <div class="form-group">
                                        <label>Usuario: </label>
                                        <input type="text" name="usuario" id="usuario" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Nombre: </label>
                                        <input type="text" name="nombreUsuario" id="nombreUsuario" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>Roll de Usuario: </label>
                                        <input type="hidden" name="rollId" value="" id="rollId" >
                                        <%@include file="/WEB-INF/jspf/SelectRoll.jspf" %>
                                    </div>
                                    <div class="form-group">
                                        <label>Contraseña: </label>
                                        <div class="input-group">
                                            <input type="password" name="contrasena" id="contrasena" class="form-control">
                                            <div class=" input-group-addon" ><span class="glyphicon glyphicon-eye-open" onclick="mostrarContrasena(this)"></span></div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-success" form="form" >Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-md-offset-2">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-success btn-sm btn-block" data-toggle="modal" data-target="#myModal" onclick="resetForm(), habilitarSelect()">
                        <span class="glyphicon glyphicon-plus"></span> Nuevo Usuario
                    </button><br><br>
                    <div  id="tableCont" class="table-responsive well well-sm">
                        <table  class="table table-hover table-striped table-condensed">
                            <tr class="success"><th>Usuario</th><th>Nombre</th><th>Roll</th><th></th></tr>
                                    <c:forEach items="${usuarios}" var="usuario">
                                <tr>
                                    <td>${usuario.usuario}</td>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.roll.rollName}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-sm btn-block" data-toggle="modal" data-target="#myModal" onclick="abrirDialogoUsuario('${usuario.usuario}', '${usuario.nombre}', '${usuario.roll.rollId}', '${usuario.contrasena}')">
                                            <span class="glyphicon glyphicon-edit"></span> Editar
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script>

    $("#selectRoll").on("change", function (e) {
        $("#rollId").val(e.target.value);
    });

    function abrirDialogoUsuario(usuarioId, nombreUsuario, rollId, contrasena) {
        document.getElementById("tipo").value = "editar";
        var usuarioIdText = document.getElementById("usuario");
        var nombreUsuarioText = document.getElementById("nombreUsuario");
        var rollIdSelect = document.getElementById("selectRoll");
        var rollIdHidden = document.querySelector("input[name='rollId']");
        var contrasenaText = document.getElementById("contrasena");
        usuarioIdText.readOnly = true;
        usuarioIdText.value = usuarioId;
        nombreUsuarioText.value = nombreUsuario;
        rollIdSelect.value = rollId;
        rollIdHidden.value = rollId;
        contrasenaText.value = contrasena;

    }

    function habilitarInput() {
        var usuarioIdText = document.getElementById("usuario");
        usuarioIdText.readOnly = false;
    }

    function resetForm() {
        var formulario = document.getElementById("form");
        formulario.reset();
    }

    function mostrarContrasena(element) {
        var contrasenaText = document.getElementById("contrasena");

        if (contrasenaText.type == 'password') {
            element.classList.toggle('glyphicon-eye-open', false);
            element.classList.toggle('glyphicon-eye-close', true);
            contrasenaText.type = 'text';
        } else {
            element.classList.toggle('glyphicon-eye-close', false);
            element.classList.toggle('glyphicon-eye-open', true);
            contrasenaText.type = 'password';
        }

    }
</script>
