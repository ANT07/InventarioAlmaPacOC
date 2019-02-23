<%-- 
    Document   : EditarCompra
    Created on : 11-15-2018, 12:19:27 AM
    Author     : Andres
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="retail.modelo.entidades.Detallecompra"%>
<%@page import="retail.modelo.entidades.Compra"%>
<%@page import="retail.modelo.servicios.ServiciosCompra"%>
<%@page import="retail.modelo.entidades.Detalleventa"%>
<%@page import="retail.modelo.entidades.Ventas"%>
<%@page import="retail.modelo.servicios.ServiciosVenta"%>
<%@page import="retail.modelo.servicios.ServiciosDetalleVenta"%>
<%@page import="retail.modelo.servicios.ServiciosDetalleCompra"%>
<%@page import="retail.util.UtilClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Editar Compra</title>
        <style>
            input[type="text"],input[type="number"]{

            }

        </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <%
            int idCompra = Integer.parseInt(request.getParameter("idCompra"));
            
            
            ServiciosCompra serviciosCompra = new ServiciosCompra();
            
           
            ServiciosDetalleCompra serviciosDetalleCompra = new ServiciosDetalleCompra();
            
            ServiciosProducto serviciosProducto = new ServiciosProducto();
            
            UtilClass utilClass = new UtilClass();

            
            Compra compra = serviciosCompra.obtenerComprasById(idCompra);
            
            
            List<Detallecompra> compraDetalles = serviciosDetalleCompra.obtenerDetallecomprasByIdCompra(idCompra);

            pageContext.setAttribute("serviciosDetalleCompra",serviciosDetalleCompra);
            pageContext.setAttribute("serviciosCompra",serviciosCompra);
            pageContext.setAttribute("compra",compra);
            pageContext.setAttribute("compraDetalless",compraDetalles);
            pageContext.setAttribute("serviciosProducto",serviciosProducto);
            pageContext.setAttribute("utilClass",utilClass);
        %>

        <div class="container well">
            <form class="form-horizontal" action="comprascontrolador.do" method="post" onsubmit="validarFormulario(event)">
                <input type="hidden" value="actualizar" name="accion">
                <div class="form-group">
                    <div class="col-md-2">
                        <input type="hidden" name="fechaCompra" value="${utilClass.formatoFecha(compra.fechaCompra)}">
                        <input type="hidden" value="${compra.idCompra}" name="idCompra">
                        <div style="display: inline;">
                            <h2><span class="label label-info">Compra No.: ${compra.idCompra}</span></h2>
                        </div>
                        <div style="display: inline;">
                            <h2><span class="label label-info">${utilClass.formatoFecha(compra.fechaCompra)}</span></h2>
                        </div>
                    </div>
                </div>
                
                 
                <div class="form-group">
                    <label class="control-label col-md-2 ">Proveedor: </label>
                    <div class="col-md-4">
                        <input type="text" class="form-control input-sm" required name="txtProveedor" value="${compra.proveedor}">
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
                                <c:set var="num" value="1"></c:set>
                                <c:forEach var="detalleCompra" items="${compraDetalless}">
                                    <c:set var="productoDetalle" value="${serviciosProducto.obtenerProductoByCod(detalleCompra.idProducto)}"></c:set>
                                    <tr id="fila${num}">
                                        <td >
                                            <%@include file="WEB-INF/jspf/productosDataList.jspf" %>
                                            <input type="text" onblur="obtenerNombreProducto(this)"  name="codigoProducto" id="codigoProducto" class="form-control input-sm" list="iProducto" value="${detalleCompra.idProducto}">
                                        </td>
                                        <td >
                                            <input type="text" id="descripcion" value="${productoDetalle.nombreProducto}" readonly class="form-control input-sm" >
                                        </td>
                                        <td>
                                            <input type="number" name="cantidadDetalle" value="${detalleCompra.cantidadDetalle}" oninvalid="validarExistencia(event)" id="cantidadDetalle" class="form-control input-sm" step="1" min="1" onblur="totalizarDetalle(this)">
                                        </td>
                                        <td  >
                                            <input type="number" min="0" name="precioDetalle" value="${detalleCompra.precioDetalle}" id="precioDetalle" step="0.01" class="form-control input-sm" onblur="totalizarDetalle(this)">
                                        </td>
                                        <td  >
                                            <input type="number" min="0" name="totalDetalle"  value="${detalleCompra.totalDetalle}" id="totalDetalle" step="1" readonly class="form-control input-sm" >
                                        </td>
                                        <td  >
                                            <input type="button" id="eliminarFila" value="X" class="btn btn-sm btn-danger" onclick="eliminarFilas(this)" >
                                        </td>
                                    </tr>
                                    <c:set var="num" value="$num + 1"></c:set>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Total: $</span>
                                <div>
                                    <input type="text" class="form-control input-sm" name="totalCompra" value="${compra.totalCompra}" id="totalVenta" readonly> 
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btn btn-info btn-sm btn-block" value="Registrar"> 
                        </div>
                    </div>
                </div>
                <div id="jGrowl-container1" class="jGrowl bottom-right"></div>
            </form>
        </div>
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
            var totalVentaText = document.querySelector("#totalVenta");
            var total = 0;
            for (var i = 0; i < totalDetalleTexts.length; i++) {
                total += parseFloat(totalDetalleTexts[i].value);
            }

            totalVentaText.value = total;
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


            var inputsNuevaFila = document.querySelectorAll("#" + nuevaFila.id + " input[type='text']," + "#" + nuevaFila.id + " input[type='number']");
            for (var i = 0; i < inputsNuevaFila.length; i++) {
                inputsNuevaFila[i].value = "";
            }

        }

        function numerarFilas() {
            var filasCuerpo = document.querySelectorAll("tbody tr");

            for (var i = 0; i < filasCuerpo.length; i++) {
                filasCuerpo[i].id = "fila" + (i + 1);
            }
        }



        function obtenerNombreProducto(element) {
            var codigoProducto = element.value;
            $.post("comprascontrolador.do", {accion: "nombreProducto", idProducto: codigoProducto}, function (text) {
                var fila = element.parentNode.parentNode;
                var nombreProdcutoText = document.querySelector("#" + fila.id + " input[type='text']#descripcion");
                var cantidadDetalleNumber = document.querySelector("#" + fila.id + " input[type='number']#cantidadDetalle");
                var precioDetalleNumber = document.querySelector("#" + fila.id + " input[type='number']#precioDetalle");
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

