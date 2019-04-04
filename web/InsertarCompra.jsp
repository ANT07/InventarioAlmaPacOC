<%-- 
    Document   : InsertarCompra
    Created on : 11-13-2018, 10:07:16 PM
    Author     : Andres
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="retail.modelo.servicios.ServiciosProducto"%>
<%@page import="retail.util.UtilClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--        <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
                <link rel="stylesheet" href="css/jquery.jgrowl.css" type="text/css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
                <script type="text/javascript" src="js/jquery.jgrowl.js"></script>-->

        <title>JSP Page</title>
        <style>
            input[type="text"],input[type="number"]{

            }

        </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <%
            String fecha = UtilClass.getFechaServidor();
            ServiciosProducto serviciosProducto = new ServiciosProducto();
            pageContext.setAttribute("serviciosProducto",
                    serviciosProducto);
            pageContext.setAttribute("fecha",
                    fecha);
        %>
        <div class="container well">
            <form class="form-horizontal" action="comprascontrolador.do" method="post" onsubmit="validarFormulario(event)">

                <input type="hidden" value="insertar" name="accion">
                <div class="form-group">
                    <h2 style="padding-left: 50px;">NUEVA COMPRA</h2>
                </div>
                <div class="form-group has-feedback ">
                    <label class="control-label col-md-2 ">Proveedor: </label>
                    <div class="col-md-4">
                        <jsp:include page="/HelperPages/ProviderDropDown.jsp"></jsp:include>
                        </div>
                    </div>
                    <div class="form-group has-feedback ">
                        <label class="control-label col-md-2 ">No. Documento: </label>
                        <div class="col-md-4">
                            <input type="text" class="form-control input-sm" required name="noDocumento">
                        </div>
                    </div>
                    <div class="form-group has-feedback ">
                        <input type="hidden" name="fechaCompra" value="${fecha}">
                    <label for="idCliente" class="control-label col-md-2 ">Fecha Documento: </label>
                    <div class="col-md-4">
                        <input type="date" name="fechaDocumento" step="1" required pattern="[0-9]{2}-[0-9]{2}-[0-9]{4}" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <input type="button" class="btn btn-info btn-sm" value="+ Fila" onclick="insertarFila()">
                </div>
                <div class="form-group">
                    <div class="col-md-9">
                        <table class="table table-condensed table-hover table-striped">
                            <thead>
                                <tr class="info">
                                    <th>Producto</th>
                                    <th>Descripcion</th>
                                    <th>Cant.</th>
                                    <th>Precio</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="fila1">
                                    <td >
                                        <%@include file="WEB-INF/jspf/productosDataList.jspf" %>
                                        <input type="text" onblur="obtenerNombreProducto(this)" name="codigoProducto" id="codigoProducto" class="form-control input-sm" list="iProducto">
                                    </td>
                                    <td >
                                        <input type="text" id="descripcion" readonly class="form-control input-sm" >
                                    </td>
                                    <td >
                                        <input type="number" name="cantidadDetalle"  oninvalid="validarExistencia(event)" id="cantidadDetalle" class="form-control input-sm" step="1" min="1" onblur="totalizarDetalle(this)">
                                    </td>
                                    <td >
                                        <input type="number" min="0" name="precioDetalle" id="precioDetalle" step="0.01" class="form-control input-sm" onblur="totalizarDetalle(this)">
                                    </td>
                                    <td >
                                        <input type="number" min="0" name="totalDetalle" id="totalDetalle" step="1" readonly class="form-control input-sm" value="0.00" >
                                    </td>
                                    <td >
                                        <input type="button" id="eliminarFila" value="X" class="btn btn-sm btn-danger" onclick="eliminarFilas(this)"  >
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">SubTotal: $</span>
                                <div>
                                    <input type="text" class="form-control input-sm" name="totalCompra" id="totalCompra" value="0.00" readonly> 
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">I.V.A: $</span>
                                <div>
                                    <input type="text" class="form-control input-sm"  id="iva" value="0.00" readonly> 
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Total: $</span>
                                <div>
                                    <input type="text" class="form-control input-sm" id="totalFinal" value="0.00" readonly> 
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-info btn-sm btn-block" value="Registrar"> 
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div id="jGrowl-container1" class="jGrowl bottom-right"></div>
    </body>
    <script>
        function totalizarDetalle(element) {
            var fila = element.parentNode.parentNode;
            var totalDetalleText = document.querySelector("tr#" + fila.id + " #totalDetalle");
            var cantidadDetalleText = document.querySelector("tr#" + fila.id + " #cantidadDetalle");
            var precioDetalleText = document.querySelector("tr#" + fila.id + " #precioDetalle");

            totalDetalleText.value = redondear(cantidadDetalleText.value * precioDetalleText.value);
            totalizarTotal();
        }



        function totalizarTotal() {
            var totalDetalleTexts = document.querySelectorAll("#totalDetalle");
            var totalVentaText = document.querySelector("#totalCompra");
            var ivaText = document.querySelector("#iva");
            var totalFinalText = document.querySelector("#totalFinal");
            var total = 0;
            for (var i = 0; i < totalDetalleTexts.length; i++) {
                total += parseFloat(totalDetalleTexts[i].value);
            }

            totalVentaText.value = total;
            ivaText.value = Math.round((total * 0.13) * 100) / 100;
            totalFinalText.value = total + parseFloat(ivaText.value);
        }

        function redondear(number) {
            return Math.round(number * 100) / 100;
        }


        function eliminarFilas(element) {
            var filaEliminar = element.parentNode.parentNode;
            var cuerpoTabla = document.querySelector("tbody");
            var filasCuerpo = document.querySelectorAll("tbody tr");

            if (filasCuerpo.length > 1) {
                cuerpoTabla.removeChild(filaEliminar);
                numerarFilas();
            }
            totalizarTotal();
        }

        function insertarFila() {
            var cuerpoTabla = document.querySelector("tbody");
            var primeraFila = document.querySelector("#fila1");
            var nuevaFila = document.createElement("tr");
            nuevaFila.innerHTML = primeraFila.innerHTML;
            var filasCuerpo = document.querySelectorAll("tbody tr");

            nuevaFila.id = "fila" + (filasCuerpo.length + 1);
            cuerpoTabla.appendChild(nuevaFila);

        }

        function numerarFilas() {
            var filasCuerpo = document.querySelectorAll("tbody tr");

            for (var i = 0; i < filasCuerpo.length; i++) {
                filasCuerpo[i].id = "fila" + (i + 1);
            }
        }

        function obtenerNombreProducto(element) {
            var codigoProducto = element.value;
            $.post("ventascontrolador.do", {accion: "nombreProducto", idProducto: codigoProducto}, function (text) {
                var fila = element.parentNode.parentNode;
                var nombreProdcutoText = document.querySelector("#" + fila.id + " input[type='text']#descripcion");
                var info = text.split(",");
                nombreProdcutoText.value = info[0];
            });
        }

        function validarFormulario(e) {
            $.jGrowl.defaults.closerTemplate = '<div class="alert alert-default">Cerrar Todo</div>';
            var descripcionProducto = document.querySelectorAll("input[type='text']#descripcion");
            var inputs = document.querySelectorAll("input[type='text'], input[type='number']");
            var estadoValidacion = true;

            //validacion para productos
            for (var i = 0; i < descripcionProducto.length; i++) {
                if (descripcionProducto[i].value == "Error de Producto" || descripcionProducto[i].value == "") {
                    estadoValidacion = false;
                    descripcionProducto[i].parentNode.classList.add("has-error");
                    mensajeError(
                            "<h5>Error, Codigos Incorrectos</h5>",
                            '<h6>Ingresar codigos existentes</h6>',
                            "alert-danger");
                }
            }

            var camposVacios = false;
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value == "") {
                    estadoValidacion = false;
                    inputs[i].parentNode.classList.add("has-error");
                    camposVacios = true;
                }
            }

            if (camposVacios) {
                mensajeError(
                        "<h5>Error, Campos Vacios</h5>",
                        '<h6>Complete todos los campos</h6>',
                        "alert-danger");
            }


            if (!estadoValidacion) {
                e.preventDefault();
                e.stopPropagation();
            }
        }


        function mensajeError(header, menssge, alertType) {
            $('#jGrowl-container1').jGrowl({
                header: header,
                message: menssge,
                group: alertType,
                life: 5000
            });
        }

    </script>
</html>
