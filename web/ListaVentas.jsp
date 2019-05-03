<%-- 
    Document   : ListaVentas
    Created on : 10/11/2018, 07:25:02 PM
    Author     : ANTHONY MARTINEZ
--%>    

<%@page import="retail.util.UtilClass"%>
<%@page import="retail.modelo.entidades.Ventas"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="retail.modelo.servicios.ServiciosDetalleVenta"%>
<%@page import="retail.modelo.servicios.ServiciosVenta"%>
<%@page import="retail.modelo.servicios.ServiciosVendedor"%>
<%@page import="retail.modelo.servicios.ServiciosProducto"%>
<%@page import="retail.modelo.servicios.ServiciosCliente"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/BuscadorTabla.js" type="text/javascript"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <div class="container well " >
            <center><h1>VENTAS</h1></center>
            <hr>
            <%
                ServiciosCliente serviciosCliente = new ServiciosCliente();
                ServiciosProducto serviciosProducto = new ServiciosProducto();
                ServiciosVendedor serviciosVendedor = new ServiciosVendedor();
                ServiciosVenta serviciosVenta = new ServiciosVenta();
                ServiciosDetalleVenta serviciosDetalleVenta = new ServiciosDetalleVenta();
                UtilClass utilClass = new UtilClass();

                List<Ventas> ventas = serviciosVenta.obtenerVentas();

                pageContext.setAttribute("serviciosCliente", serviciosCliente);
                pageContext.setAttribute("serviciosProducto", serviciosProducto);
                pageContext.setAttribute("serviciosVendedor", serviciosVendedor);
                pageContext.setAttribute("serviciosDetalleVenta", serviciosDetalleVenta);
                pageContext.setAttribute("ventas", ventas);
                pageContext.setAttribute("utilClass", utilClass);
            %>

            <!--            <center>
                            <input class="form-control" style="width: 150px" id="txtBuscar" type="text" onkeyup="Buscar()" placeholder="Buscar" ></center>-->
<!--            <div class="form-group" style="text-align: left;">
                <a href="InsertarVenta.jsp"  class="btn btn-primary" >+ Nueva Venta</a>
            </div>-->
            <!--            <div class="form-group col-md-2" style="float: right">
                            <a href="#modalFiltros" data-toggle="modal" class="btn btn-link">Filtrar</a>
            
                        </div>-->
            <div class="modal fade" style="align-content: center" id="modalFiltros" role="dialog" tabindex="-1" >
                <div class="modal-dialog modal-sm" role="document" style="width:  300px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <center><h3>Filtros</h3></center>  
                        </div>
                        <div class="modal-body" >
                            <center>
                                <div class="form-group" >
                                    <h4>N°Registros</h4>
                                    <select name="state" id="maxRows" class="form-control" style="width: 100px;">
                                        <option value="5000">Ver todo</option>
                                        <option value="5" >5</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="50">50</option>
                                        <option value="75">75</option>
                                        <option value="100">100</option>
                                    </select>

                                </div>    </center>      
                        </div> 

                        <div class="modal-footer">


                            <center><button type="button"  class="btn btn-success" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-ok" ></span></center>                                            
                        </div>

                    </div>
                </div>
            </div><br>
            <center> <div class="form-group">
                </div></center>
            <div class="table-condensed" >
                <table class="table table-condensed table-hover table-striped" id="lista">
                    <thead class="thead-light" style="align-content: center">
                        <tr class="info">
                            <th>No. Venta</th>
                            <th>Fecha</th>
                            <th>Vendedor</th>
                            <th>Cliente</th>
                            <th>Monto</th>
                            <th>Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="venta" items="${ventas}" >

                            <tr>
                                <td><b>${venta.idVenta}</b></td>
                                <td>${utilClass.formatoFecha(venta.fechaVenta)}</td>
                                <td>${venta.vendedor.nombreVendedor} ${venta.vendedor.apellidoVendedor}</td>
                                <td>${venta.clientes.nombreCliente} ${venta.clientes.apellidoCliente}</td>
                                <td>$ ${utilClass.formatoDecimales(venta.totalVenta)}</td>
                                <td>
                                    <c:url var="editar" value="EditarVenta.jsp">
                                        <c:param name="idVenta" value="${venta.idVenta}"></c:param>
                                    </c:url>
                                    <c:url var="efectuar" value="ventascontrolador.do">
                                        <c:param name="idVenta" value="${venta.idVenta}"></c:param>
                                        <c:param name="accion" value="efectuar"></c:param>
                                    </c:url>
                                    <c:url var="reporteVenta" value="reporteVenta.do">
                                        <c:param name="idVenta" value="${venta.idVenta}"></c:param>
                                    </c:url>
                                    <c:if test="${venta.estado == 0}">
                                        <a href="${efectuar}"  class="btn btn-success btn-xs"> <span class="glyphicon glyphicon-ok"></span> Emitir Factura</a>
                                    </c:if>
                                    <c:if test="${venta.estado == 0}">
                                        <a href="${editar}" class="btn btn-warning btn-xs"><span class="glyphicon glyphicon-edit"></span> Editar</a>
                                    </c:if>
                                    <c:if test="${venta.estado == 1}">
                                        <h4><span class="label label-info pull-left" title="niewc">
                                                Factura Emitida
                                            </span>
                                        </h4>&nbsp;&nbsp;
                                    </c:if>
                                    <a href="${reporteVenta}" class="btn btn-primary btn-xs" target="_blank"><span class="glyphicon glyphicon-print"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="pagination-container">
                    <nav>
                        <ul class="pagination" ></ul>
                    </nav>
                </div>
            </div>

        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
        <script src="js/jquery.min.js"></script>

        <script>
            var table = '#lista';
            $('#maxRows').on('change', function () {
                $('.pagination').html('');
                var trnum = 0;
                var maxRows = parseInt($(this).val());
                var totalRows = $(table + ' tbody tr').length;
                $(table + ' tr:gt(0)').each(function () {
                    trnum++;
                    if (trnum > maxRows) {
                        $(this).hide();
                    }
                    if (trnum <= maxRows) {
                        $(this).show();
                    }
                });
                if (totalRows > maxRows) {
                    var pagenum = Math.ceil(totalRows / maxRows);
                    for (var i = 1; i <= pagenum; ) {
                        $('.pagination').append('<li data-page="' + i + '">\<span>' + i++ + '<span class="sr-only">(current)</span></span>\</li>').show();
                    }
                }
                $('.pagination li:first-child').addClass('active');
                $('.pagination li').on('click', function () {
                    var pageNum = $(this).attr('data-page');
                    var trIndex = 0;
                    $('.pagination li').removeClass('active');
                    $(this).addClass('active');
                    $(table + ' tr:gt(0)').each(function () {
                        trIndex++;
                        if (trIndex > (maxRows * pageNum) || trIndex <= ((maxRows * pageNum) - maxRows)) {
                            $(this).hide();
                        } else {
                            $(this).show();
                        }
                    });
                });
            });

        </script>
    </body>
</html>
