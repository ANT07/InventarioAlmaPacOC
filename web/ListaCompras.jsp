<%-- 
    Document   : ListaCompras
    Created on : 11-14-2018, 10:44:53 PM
    Author     : Andres
--%>

<%@page import="retail.modelo.entidades.Compra"%>
<%@page import="retail.util.UtilClass"%>
<%@page import="retail.modelo.entidades.Ventas"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="retail.modelo.servicios.ServiciosDetalleVenta"%>
<%@page import="retail.modelo.servicios.ServiciosVenta"%>
<%@page import="retail.modelo.servicios.ServiciosVendedor"%>
<%@page import="retail.modelo.servicios.ServiciosProducto"%>
<%@page import="retail.modelo.servicios.ServiciosCliente"%>

<%@page import="retail.modelo.servicios.ServiciosDetalleCompra"%>
<%@page import="retail.modelo.servicios.ServiciosCompra"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/BuscadorTabla.js" type="text/javascript"></script>
        <title>Confirmar Compras</title>
    </head>
    <body>
        <div class="container well center-block" >
            <center><h1>Compras</h1></center>
            <hr>
            <%
                
                ServiciosProducto serviciosProducto = new ServiciosProducto();

                ServiciosCompra serviciosCompra = new ServiciosCompra();
                                
                ServiciosDetalleCompra serviciosDetalleCompra = new ServiciosDetalleCompra();
                
                UtilClass utilClass = new UtilClass();
                
                List<Compra> compras = serviciosCompra.obtenerCompra();
               
                pageContext.setAttribute("serviciosProducto", serviciosProducto);
                
                pageContext.setAttribute("serviciosDetalleCompra", serviciosDetalleCompra);
                
                pageContext.setAttribute("compras", compras);
                
                pageContext.setAttribute("utilClass", utilClass);
            %>
            <%@include file="WEB-INF/jspf/NavBar.jspf"%>
            <hr><center>
                <input class="form-control" style="width: 150px" id="txtBuscar" type="text" onkeyup="Buscar()" placeholder="Buscar" ></center>
            <div class="form-group" style="float: left;">
                <a href="InsertarCompra.jsp"  class="btn btn-primary">+ Nueva Compra</a>
            </div>
            <div class="form-group col-md-2" style="float: right">
                <a href="#modalFiltros" data-toggle="modal" class="btn btn-link">Filtrar</a>

            </div>
            <div class="modal fade" id="modalFiltros" role="dialog" tabindex="-1" >
                <div class="modal-dialog modal-sm" role="document" style="width:  300px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <center><h3>Filtros</h3></center>  
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
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

                            </div>          
                        </div> 

                        <div class="modal-footer">


                            <center><button type="button"  class="btn btn-success" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-ok" ></span></center>                                            
                        </div>

                    </div>
                </div>
            </div><br>
            <center> <div class="form-group">
                <p  class="alert-info" style="font-size: 16px; color: #007bff; width: 330px;<c:if var="prueba" test="${Mensaje == null}" > display: none; </c:if>">${Mensaje}</p> 
                </div></center>
                <div class="table-condensed" >
                    <table class="table table-condensed table-hover table-striped" id="lista">
                        <thead class="thead-light">
                            <tr class="info" style="align-content: center   ">
                                <th>No. Compra</th>
                                <th>Fecha</th>
                                <th>Proveedor</th>  
                                <th>Monto</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="compra" items="${compras}" >
                            <c:set var="proveedor" value="${serviciosCompra.obtenerComprasById(compra.idCompra)}"></c:set>
                            

                                <tr>
                                <td>${compra.idCompra}</td>
                                <td>${utilClass.formatoFecha(compra.fechaCompra)}</td>
                                <td>${compra.proveedor}</td>
                                
                                <td>$ ${utilClass.formatoDecimales(compra.totalCompra)}</td>
                                <td>
                                    <c:url var="editar" value="EditarCompra.jsp">
                                        <c:param name="idCompra" value="${compra.idCompra}"></c:param>
                                    </c:url>
                                    <c:url var="efectuar" value="comprascontrolador.do">
                                        <c:param name="idCompra" value="${compra.idCompra}"></c:param>
                                        <c:param name="accion" value="efectuar"></c:param>
                                    </c:url>
                                    <c:url var="anular" value="comprascontrolador.do">
                                        <c:param name="idCompra" value="${compra.idCompra}"></c:param>
                                        <c:param name="accion" value="anular"></c:param>
                                    </c:url>
                                    <c:if test="${compra.estado == 0}">
                                        <a href="${efectuar}"  class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Confirmar Compra</a>
                                    </c:if>
                                    <c:if test="${compra.estado == 0}">
                                        <a href="${editar}" class="btn btn-warning"><span class="glyphicon glyphicon-edit"></span> Editar</a>
                                    </c:if>
                                    <c:if test="${compra.estado == 1}">
                                        <a href="${anular}"  class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Anular</a>
                                    </c:if>    
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

