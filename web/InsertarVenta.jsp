<%-- 
    Document   : InsertarVenta
    Created on : 11-08-2018, 01:21:39 PM
    Author     : anthony
--%>

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
        <%
            String fecha = UtilClass.getFechaServidor();
            ServiciosProducto serviciosProducto = new ServiciosProducto();
            pageContext.setAttribute("serviciosProducto",
                    serviciosProducto);
            pageContext.setAttribute("fecha",
                    fecha);
        %>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <div class="container well" style="height:  500px;">
            <form class="form-horizontal" action="ventascontrolador.do" method="post" onsubmit="validarFormulario(event)">
                <input type="hidden" value="insertar" name="accion">
                <div class="form-group ">
                    <input type="hidden" name="fechaVenta" value="${fecha}">
                    <div class="col-md-2">
                        <h2><span class="label label-info">${fecha}</span></h2>
                    </div>
                </div>
                <div class="form-group has-feedback ">
                    <label for="idCliente" class="control-label col-md-2 ">Cliente: </label>
                    <div class="col-md-4">
                        <%@include file="WEB-INF/jspf/clientesSelect.jspf" %>
                    </div>
                </div>
                <div class="form-group">
                    <label for="idCliente" class="control-label col-md-2" >Vendedor </label>
                    <div class="col-md-4">
                        <%@include file="WEB-INF/jspf/vendedorSelect.jspf" %>
                    </div>
                </div>
                <div class="form-group">
                    <input type="button" class="btn btn-info btn-sm" value="+ Fila" onclick="insertarFila()">
                </div>
                <div class="form-group">
                    <div class="col-md-9">
                        <div class="table-responsive" style="overflow: auto; height: 225px;">
                            <table class="table table-condensed table-hover table-striped">
                                <thead>
                                    <tr class="info">
                                        <th style="width: 20%;">Producto</th>
                                        <th style="width: 35%;">Descripcion</th>
                                        <th style="width: 15%;">Cant.</th>
                                        <th style="width: 15%;">Precio</th>
                                        <th style="width: 15%;">Total</th>
                                        <th ></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr id="fila1">
                                        <td >
                                            <input type="hidden" value="" id="codigoProductoHidden">
                                            <%@include file="WEB-INF/jspf/productosDataList.jspf" %>
                                            <input type="text" onblur="obtenerNombreProducto(this)"  name="codigoProducto" id="codigoProducto" class="form-control input-sm" list="iProducto">
                                        </td>
                                        <td >
                                            <input type="text" id="descripcion" readonly class="form-control input-sm" >
                                        </td>
                                        <td >
                                            <input type="number" name="cantidadDetalle"  oninvalid="validarExistencia(event)" id="cantidadDetalle" class="form-control input-sm" step="1" min="1" max="0" onblur="totalizarDetalle(this)">
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

                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Total: $</span>
                                <div>
                                    <input type="text" class="form-control input-sm" name="totalVenta" id="totalVenta" value="0.00" readonly> 
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
                var codigoProdctoHidden = document.querySelector("#" + fila.id + " input[type='hidden']#codigoProductoHidden");
                var cantidadDetalleNumber = document.querySelector("#" + fila.id + " input[type='number']#cantidadDetalle");
                var precioDetalleNumber = document.querySelector("#" + fila.id + " input[type='number']#precioDetalle");
                var info = text.split(",");
                codigoProdctoHidden.value = codigoProducto;
                nombreProdcutoText.value = info[0];
                cantidadDetalleNumber.max = info[1];
                precioDetalleNumber.value = info[2] || 0;
                totalizarDetalle(element);
                totalizarTotal();
            });

        }

        function validarFormulario(e) {

            $.jGrowl.defaults.closerTemplate = '<div class="alert alert-default">Cerrar Todo</div>';
            var selects = document.querySelectorAll("select");
            var codigosProductos = document.querySelectorAll("input[type='text']#codigoProducto");
            var descripcionProducto = document.querySelectorAll("input[type='text']#descripcion");
            var inputs = document.querySelectorAll("input[type='text'], input[type='number']");
            var estadoValidacion = true;
            //validacion de existencias por productos             
            for (var i = 0; i < codigosProductos.length; i++) {
                estadoValidacion = validarExistenciaByCodigo(codigosProductos[i]);

            }
            //validacion para selects
            for (var i = 0; i < selects.length; i++) {
                if (selects[i].value == -1) {
                    estadoValidacion = false;
                    selects[i].parentNode.parentNode.classList.add("has-error");
                    mensajeError(
                            "<h5>Error, Campos Incompletos</h5>",
                            '<h6>Seleccionar Cliente o Vendedor de la Venta</h6>',
                            "alert-warning");
                }
            }
            //validacion para productos
            for (var i = 0; i < descripcionProducto.length; i++) {
                if (descripcionProducto[i].value == "Error de Producto" || descripcionProducto[i].value == "") {
                    estadoValidacion = false;
                    descripcionProducto[i].parentNode.classList.add("danger");
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
                    inputs[i].parentNode.classList.add("danger");
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

        function validarExistencia(e) {
            e.preventDefault();
            var cantidadesDetalles = document.querySelectorAll("input[type='number']#cantidadDetalle");
            var estadoValidacion = true;
            for (var i = 0; i < cantidadesDetalles.length; i++) {
                if (cantidadesDetalles[i].validity.rangeOverflow || cantidadesDetalles[i].value == "") {
                    var fila = cantidadesDetalles[i].parentNode.parentNode;
                    var codigoProductoText = document.querySelector("#" + fila.id + " input[type='text']#codigoProducto");
                    codigoProductoText.parentNode.classList.add("danger");
                    cantidadesDetalles[i].parentNode.classList.add("danger");
                    estadoValidacion = false;
                    mensajeError(
                            "<h5>Error, Existencia no disponible</h5>",
                            '<h6>Codigo: ' + codigoProductoText.value + ' Existencia disponible: ' + cantidadesDetalles[i].max + '</h6>',
                            "alert-info");
                }

            }
        }

        function validarExistenciaByCodigo(element) {
            var otrosCodigosSimilares = $("input[type='hidden'][value='" + element.value + "']#codigoProductoHidden");
            var sumaExistencia = 0;
            var estado = true;
            var existenciaCodigoReal = 0;
            for (var i = 0; i < otrosCodigosSimilares.length; i++) {
                var fila = otrosCodigosSimilares[i].parentNode.parentNode;
                var cantidadProdcutos = document.querySelector("tr#" + fila.id + " input[type='number']#cantidadDetalle");
                otrosCodigosSimilares[i].parentNode.classList.add("danger");
                cantidadProdcutos.parentNode.classList.add("danger");
                existenciaCodigoReal = parseFloat(cantidadProdcutos.max);
                sumaExistencia += parseFloat(cantidadProdcutos.value);
            }

            if (sumaExistencia > existenciaCodigoReal) {
                estado = false;
                mensajeError(
                        "<h5>Error, Existencia no disponible</h5>",
                        '<h6>Codigo: ' + element.value + ' Existencia disponible: ' + existenciaCodigoReal + '</h6>',
                        "alert-danger");
            }

            return estado;
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
