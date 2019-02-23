<%-- 
    Document   : ListaClientes
    Created on : 8/11/2018, 09:06:21 AM
    Author     : William Vasquez
--%>

<%@page import="retail.util.UtilClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="retail.modelo.entidades.Vendedor"%>
<%@page import="retail.modelo.servicios.ServiciosVendedor"%>
<%@page import="retail.modelo.entidades.Clientes"%>
<%@page import="java.util.List"%>
<%@page import="retail.modelo.servicios.ServiciosCliente"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/BuscadorTabla.js" type="text/javascript"></script>
        <title>Clientes</title>
    </head>
    <body>
        <%

            ServiciosCliente cliente = new ServiciosCliente();
            ResultSet rs = cliente.SelectClientes();
            UtilClass utilClass = new UtilClass();
            pageContext.setAttribute("utilClass", utilClass);

        %>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
    <center>

        <div class="container well" >

            <h1>Compras por cliente</h1>


            <hr><center>
                <input class="form-control" style="width: 150px" id="txtBuscar" type="text" onkeyup="Buscar()" placeholder="Buscar" ></center>
            <br>
            <form action="ventascontrolador.do" method="POST">
                <input type="hidden" name="accion" value="ventasCliente" >
                <div class="col-md-4 selectContainer">
                    <label class=" col-md-4 control-label" style="font-size: 16px" for="clienteVenta" >Cliente</label>
                    <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                        <select style="width: 200px " name="clienteVenta" class="form-control selectpicker" id="clienteVenta" data-minLength="5" data-error="some error" required>
                            <option value="0" >Seleccione cliente</option>
                            <%  rs.beforeFirst();
                                while (rs.next()) {
                            %> 
                            <option value="<%= rs.getString(1)%>" ><%= rs.getString(2)%> <%=rs.getString(3)%></option>
                            <%}
                            %> 
                        </select>
                        
                    </div><br>
                        <input type="submit" class="btn btn-success col-md-3" value="Buscar"><br>
                        <br>
                </div>
            </form>
<h3 class="text-info col-md-4">Compras de: ${cliente.nombreCliente} ${cliente.apellidoCliente}</h3>
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
            </div>



            <br> <div class="form-group">
                <p  class="alert-info" style="font-size: 16px; color: #007bff; width: 330px;<c:if var="prueba" test="${Mensaje == null}" > display: none; </c:if>">${Mensaje}</p> 
                </div>
                <!--class="table table-hover table-striped table-condensed"-->
                <table  style="width: 100%;"  class="table table-condensed table-striped table-hover  col-md-10" id="lista">
                    <thead class="thead-light"> 
                        <tr class="info">
                            <th><center>ID venta</center></th>
                    <th><center>Fecha venta</center></th>
                    <th><center>Total venta</center></th>

                    </tr>
                    </thead>
                <c:forEach var="clientes" items="${clientes}">
                    <tr>
                        <td><center><b>${clientes.idVenta}</b></center></td>
                    <td><center>${utilClass.formatoFecha(clientes.fechaVenta)}</center></td>
                    <td><center>$ ${clientes.totalVenta}</center></td>
                    </tr>
                </c:forEach>
            </table>

            <div class="pagination-container">
                <nav>
                    <ul class="pagination" ></ul>
                </nav>
            </div>
        </div>  

    </center>








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
