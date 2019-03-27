<%-- 
    Document   : ListaClientes
    Created on : 8/11/2018, 09:06:21 AM
    Author     : William Vasquez
--%>

<%@page import="retail.modelo.servicios.OrderTypeImpl"%>
<%@page import="retail.modelo.entidades.OrderType"%>
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
        <title>Tipos de orden</title>
    </head>
    <body>
        <%

            OrderTypeImpl orderTypeImpl = new OrderTypeImpl();

            List<OrderType> orderTypes = orderTypeImpl.getOrderTypes();
            pageContext.setAttribute("orderTypes", orderTypes);

        %>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
    <center>

        <div class="container well" >

            <h1>Tipos de Orden</h1>

            <!--            <a href="ResultadosMaterias.jsp" class="btn btn-info">Ver Materias</a> 
                        <a href="ResultadosNotas.jsp" class="btn btn-info">Ver Asignaciones</a> 
                        <a href="AsignarMateriaAlumno.jsp" class="btn btn-info">Nueva Asinacion</a> -->
            <hr><center>
                <input class="form-control" style="width: 150px" id="txtBuscar" type="text" onkeyup="Buscar()" placeholder="Buscar" ></center>
            <a href="InsertarTipoOrden.jsp" class="btn btn-primary" style="float: left;">+ Insertar Tipo</a><br> 

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

            <div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header" >
                            <center><h5 class="modal-title"><b>Eliminar registro</b></h5></center>  
                            <button type="button" class="close" data-dismiss="modal">&times;</button>                
                        </div>
                        <div class="modal-body">
                            <center>¿Desea eliminar el registro de forma permanente?</center>
                        </div>
                        <center><div class="modal-footer">
                                <center>
                                    <form action="type.do" method="post">
                                        <input type="hidden" value='0' name='typeid' id='cod'>
                                        <input type="hidden" value='eliminar' name='tipo'>
                                        <input type="submit" class="btn btn-danger" value="Sí, eliminar">
                                        <button class="btn btn-info btn-m" data-dismiss="modal" aria-hidden="true">No</button>
                                    </form>
                                </center>
                            </div></center>
                    </div>
                </div>
            </div> 

            <br> <div class="form-group">
                </div>
                <!--class="table table-hover table-striped table-condensed"-->
                <table  style="width: 100%;"  class="table table-condensed table-striped table-hover  col-md-10" id="lista">
                    <thead class="thead-light"> 
                        <tr class="info">
                            <th><center>ID</center></th>
                    <th><center>Nombre Tipo</center></th>
                    <th><center>Acciones</center></th>
                    </tr>
                    </thead>
                <c:forEach var="type" items="${orderTypes}">
                    <tr>

                        <td><center><b>${type.typeid}</b></center></td>
                        <td><center>${type.typename}</center></td>
                        <td style="text-align: center;">

                        <c:url var="urlEditar" value="type.do">
                            <c:param name="txtCarnet" value="${type.typeid}"></c:param>
                            <c:param name="tipo" value="editar"></c:param>
                        </c:url>
                        <script type="text/javascript">
                            function CambiarValor(typeid)
                            {
                                var hiddenCod = document.getElementById("cod");
                                hiddenCod.value = typeid;
                            }
                        </script>
                        <a href="#modalEliminar" onclick="CambiarValor('${type.typeid}')" data-toggle="modal" class="btn btn-danger " style="display: inline"><span class="glyphicon glyphicon-trash"></span> Eliminar</a> 
                        <form action="type.do" method="post" style="display: inline">
                            <input type="hidden" name="tipo" value="buscar">
                            <input type="hidden" name="typeid" value="${type.typeid}"> 
                            <input type="submit" class="btn btn-info" value="Editar">
                        </form>
                    </td>

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
