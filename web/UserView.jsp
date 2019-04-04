


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
                                <h4 class="modal-title" id="myModalLabel">USUARIO DE SISTEMA</h4>
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
                <div class="modal fade" id="modalUserImage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">IMAGEN DE USUARIO</h4>
                            </div>
                            <div class="modal-body"> 
                                <form action="${pageContext.request.contextPath}/ImagenControlador" method="post" id="formImage"  enctype='multipart/form-data'>
                                    <input name="usuarioIdImg" id="usuarioIdImg" type="hidden" value="0">
                                    <input name="accion" id="accion" type="hidden" value="cambiarImagen">
                                    <div class="form-group">
                                        <h3 id="nombreUsuarioTitle"></h3>
                                    </div>
                                    <div class="form-group text-center">
                                        <img src="image/ic_login.jpg" width="300px" height="300px" id="imagen" class="img-rounded"> 
                                    </div>
                                    <div class="form-group">
                                        <label>Seleccione archivo: </label>
                                        <input type="file" name="fileImage" onchange="cambiarImagen(this)" class="form-control" required>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-success" form="formImage" >Guardar</button>
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
                            <tr class="success"><th>Usuario</th><th>Nombre</th><th>Foto</th><th>Roll</th><th></th></tr>
                                    <c:forEach items="${usuarios}" var="usuario">
                                <tr>
                                    <td>${usuario.usuario}</td>
                                    <td>${usuario.nombre}</td>
                                    <td><img src="${pageContext.request.contextPath}${usuario.rutaImagen}" height="50px" width="50px" class="img-circle"></td>
                                    <td>${usuario.roll.rollName}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-sm " data-toggle="modal" data-target="#myModal" onclick="abrirDialogoUsuario('${usuario.usuario}', '${usuario.nombre}', '${usuario.roll.rollId}', '${usuario.contrasena}')">
                                            <span class="glyphicon glyphicon-edit"></span> Editar
                                        </button>
                                        <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalUserImage" onclick="abrirDialogoImg('${usuario.usuario}', '${usuario.nombre}','${usuario.rutaImagen}')">
                                            <span class="glyphicon glyphicon-user"></span> Editar
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

    function cambiarImagen(elemet) {
        var file = elemet.files[0];
        var reader = new FileReader();
        var allowedExtensions = /(.jpg|.jpeg|.png|.gif)$/i;

        if (!allowedExtensions.exec(elemet.value)) {
            alertify.alert("TIPO DE ARCHIVO INCORRECTO,\n SELECCIONE UN ARCHIVO DE IMAGEN CORRECTO");
            elemet.value = '';
        } else {
            reader.readAsDataURL(file);
            reader.onload = function (e) {
                cargar(e);
            };
        }
    }

    function cargar(e) {
        var img = document.getElementById("imagen");
        img.src = e.target.result;
    }
    
    function abrirDialogoImg(usuario,nombreUsuario,rutaImagen){
        var usuarioHidden = document.getElementById("usuarioIdImg");
        usuarioHidden.value = usuario;
        var usuarioNombre = document.getElementById("nombreUsuarioTitle");
        usuarioNombre.innerHTML = nombreUsuario;
        var img = document.getElementById("imagen");
        img.src = '${pageContext.request.contextPath}'+rutaImagen;
    }

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
        habilitarInput();
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

    $("#form").validate({
        rules: {
//            name: "required",
            usuario: {
                required: true
            },
            nombreUsuario: {
                required: true
            },
            selectRoll: {
                required: true
            },
            contrasena: {
                required: true
            }
        },
        messages: {
//            name: "Please specify your name",
            usuario: {
                required: "Usuario es requerido"
            },
            nombreUsuario: {
                required: "Nombre de usuario es requerido"
            },
            selectRoll: {
                required: "Seleccione..."
            },
            contrasena: {
                required: "Contraseña es requerida"
            }
        }
    });
</script>
