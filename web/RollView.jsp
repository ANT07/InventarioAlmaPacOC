<%-- 
    Document   : ProviderView
    Created on : 01-24-2018, 05:07:38 PM
    Author     : anthony
--%>




<%@page import="retail.modelo.entidades.Roll"%>
<%@page import="retail.modelo.servicios.RollDAO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    </head>
    <body>
        <style>
            td{
                vertical-align: middle !important;
            }
        </style>
        <%@include file="/WEB-INF/jspf/NavBar.jspf"%>
        <%
            RollDAO rollDAO = new RollDAO();
            List<Roll> rolles = rollDAO.obtenerRolls();

            pageContext.setAttribute("rolles",
                    rolles);

        %>
        <div class="container">

            <div class="row">
                <!-- Modal -->
                <div class="modal fade" id="myModalRoll" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Nuevo Roll</h4>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/roll.do" method="post" id="formRoll">
                                    <input name="tipo" id="tipoRoll" value="guardar" type="hidden">
                                    <input name="rollId" id="rollId" type="hidden" value="0">
                                    <div class="form-group">
                                           <label>Nombre Roll: </label>
                                        <input name="nombreRoll" id="nombreRoll" type="text" class="form-control">
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary" form="formRoll" >Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="col-md-8 col-md-offset-2">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary btn-sm btn-block" data-toggle="modal" data-target="#myModalRoll" onclick="resetForm('formRoll')">
                        <span class="glyphicon glyphicon-plus"></span> Nuevo Roll
                    </button><br><br>
                    <div>
                        <div  id="contenerdorRolls" class="  panel-group">
                            <c:forEach items="${rolles}" var="roll">
                                <div class="panel panel-default">

                                    <div class="panel-heading">
                                        <div class="btn-group btn-group-sm">
                                            <button type="button" class="btn btn-success btn-sm " data-toggle="modal" data-target="#myModalRoll" onclick=""><span class="glyphicon glyphicon-pencil" ></span></button>
                                            <a href="${pageContext.request.contextPath}/roll.do?tipo=eliminar&rollId=${roll.rollId}" class="btn btn-danger btn-sm "><span class="glyphicon glyphicon-remove"></span></a>
                                        </div>
                                        <span style="font-weight: bold;">${roll.rollName}</span>
                                        <button type="button" class="btn btn-default btn-sm pull-right"  onclick="expandir('${roll.rollId}')"><span class="caret"></span></button>

                                    </div>
                                    <div class="panel-body" expandido="false" style="display: none;" id="${roll.rollId}">
                                        <div>
                                            <div>
                                                <h4>Opciones</h4>
                                                <div class="well">
                                                    <table class="table table-hover table-condensed">
                                                        <tbody>
                                                        <form action="${pageContext.request.contextPath}/opciones.do" method="post">

                                                            <c:forEach items="${roll.rollSubmenus}" var="rollSubMenu">
                                                                <tr>
                                                                    <td>${rollSubMenu.subMenu.submenuName}</td>
                                                                    <td>
                                                                        <input type="hidden" name="opcion" id="c${rollSubMenu.rollSubmenuId}" value="${rollSubMenu.rollSubmenuId}-${rollSubMenu.estado}">
                                                                        <input  type="checkbox"  onclick="cambiarHiddenValor(this, '${rollSubMenu.rollSubmenuId}')" <c:if test="${rollSubMenu.estado == 1}">checked</c:if>>
                                                                        </td>
                                                                    </tr>
                                                            </c:forEach>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <input type="submit" value="Guardar Cambios" class="btn btn-sm btn-info center-block">
                                                                </td>
                                                            </tr>
                                                        </form>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script>
    function cambiarHiddenValor(check, rollSubmenuId) {
        var selector = "input[type='hidden']#c" + rollSubmenuId;
        elementHidden = document.querySelector(selector);
        if (check.checked) {
            $(elementHidden).val(rollSubmenuId + "-1");
        } else {
            $(elementHidden).val(rollSubmenuId + "-0");
        }
    }
    function resetForm(formId) {
        var formulario = document.getElementById(formId);
        formulario.reset();
    }

    function expandir(rollId) {
        var elemento = $("#" + rollId);
        var expandido = elemento.attr("expandido");
        var elementoExpandido = document.querySelector("div [expandido='true']");

        if (elementoExpandido != null) {
            $(elementoExpandido).slideUp();
            $(elementoExpandido).attr("expandido", "false")
        }

        if (expandido == "false") {
            elemento.slideDown();
            elemento.attr("expandido", "true");
        }
//        else {
//            elemento.slideUp();
//            elemento.attr("expandido","false") ;
//        }

    }

    function abrirDialogoRoll(rollId, rollName) {
        var tipo = document.querySelector("form#formRoll #tipoRoll");
        tipo.value = "editar";

        var rollIdHidden = document.querySelector("form#formRoll #rollId");
        var rollNameText = document.querySelector("form#formRoll #nombreRoll");

        rollIdHidden.value = rollId;
        rollNameText.value = rollName;
    }

    function abrirDialogoSubRoll(rollId, subrollId, subrollName, url) {
        var tipo = document.querySelector("form#formSubroll #tipoSubroll");
        tipo.value = "editar";

        var subrollIdHidden = document.querySelector("form#formSubroll #SubRollId");
        var subrollNameText = document.querySelector("form#formSubroll #nombreRoll");
        var rollIdHidden = document.querySelector("form#formSubroll #rollId");
        var urlSelect = document.querySelector("form#formSubroll select#url");
        var urlHidden = document.querySelector("form#formSubroll input[type='hidden']#url");


        subrollIdHidden.value = subrollId;
        subrollNameText.value = subrollName;
        rollIdHidden.value = rollId;
        urlHidden.value = url;
        urlSelect.value = url;
        urlSelect.disabled = true;
    }

    function abrirDialogoGuardarSubRoll(rollId) {
        var rollIdHidden = document.querySelector("form#formSubroll #rollId");
        var urlSelect = document.querySelector("form#formSubroll select#url");
        urlSelect.disabled = false;
        rollIdHidden.value = rollId;
    }

    function cambiarTipo(inputId) {
        var hiddenTipo = document.getElementById(inputId);
        hiddenTipo.value = "editar";
    }

    function cambioValorSelect(e) {
        var element = e.target;
        var urlHidden = document.querySelector("form#formSubroll input[type='hidden']#url");
        urlHidden.value = element.value;
    }
    
    $("#formRoll").validate({
        rules: {
//            name: "required",
            nombreRoll: {
                required: true
            }
        }, 
        messages: {
//            name: "Please specify your name",
            nombreRoll: {
                required: "Nombre del roll es requerido"
            }
        }
    });
</script>