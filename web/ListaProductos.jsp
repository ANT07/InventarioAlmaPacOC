<%-- 
    Document   : ListaProducto
    Created on : 8/11/2018, 09:06:21 AM
    Author     : William Vasquez
--%>

<%@page import="retail.modelo.entidades.Producto"%>
<%@page import="java.util.List"%>
<%@page import="retail.modelo.servicios.ServiciosProducto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../css/bootstrap-theme.css" rel="stylesheet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/BuscadorTabla.js" type="text/javascript"></script>
        <title>Producto</title>
    </head>
    <body>
        <%

            ServiciosProducto serviciosProducto = new ServiciosProducto();

            List<Producto> producto = serviciosProducto.obtenerProducto();
            pageContext.setAttribute("serviciosProducto",
                    serviciosProducto);
            pageContext.setAttribute("producto",
                    producto);

        %>
        <%@include file="WEB-INF/jspf/NavBar.jspf" %>
    

        <div class="container well" id="ContainerLogin">

            <h1>Productos</h1>

            <hr><center>
                <input class="form-control" style="width: 150px" id="txtBuscar" type="text" onkeyup="Buscar()" placeholder="Buscar" ></center>
            <a href="InsertarProductos.jsp" class="btn btn-primary" style="float: left;">+ Insertar producto</a> <br> 


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
                                    <form action="productoscontrolador.do" method="post">
                                        <input type="hidden" value='' name='cod' id='cod'>
                                        <input type="hidden" value='eliminar' name='Tipo'>
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
                <table  style="width: 100%;"  class="table table-condensed table-striped table-hover table-bordered col-md-10" id="lista">
                    <thead class="thead-light"> 
                        <tr class="info">
                            <th style="width: 5%;"><center>ID</center></th>
                    <!--                    <th><center>Código de Barra</center></th>-->
                    <th style="width: 15%;"><center >Nombre</center></th>
                    <th style="width: 40%;"><center >Descripcion</center></th>
                    <th style="width: 15%;"><center>Precio</center></th>
                    <th style="width: 15%;"><center>Existencia</center></th>
                    <th style="width: 10%;"><center>Acciones</center></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="producto" items="${producto}">
                        <tr>

                            <td><center><b>${producto.codigoProducto}</b></center></td>
    <!--                        <td style="text-align: center;"><img src="barra.do?value=${producto.codigoProducto}"></td>-->
                    <td>${producto.nombreProducto}</td>

                    <td>${producto.descripcionProducto}</td>
                    <td>$   ${producto.precioProducto}</td>
                    <td>${producto.existenciaProducto}</td>

                    <td >


                        <c:url var="urlEditar" value="productoscontrolador.do">
                            <c:param name="txtCarnet" value="${producto.codigoProducto}"></c:param>
                            <c:param name="Tipo" value="editar"></c:param>
                        </c:url>
                        <script type="text/javascript">
                            function CambiarValor(userId)
                            {
                                var hiddenCod = document.getElementById("cod");
                                hiddenCod.value = userId;
                            }
                        </script>
                        <a href="#modalEliminar" onclick="CambiarValor('${producto.codigoProducto}')" data-toggle="modal" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span></a> 
                        <form action="productoscontrolador.do" method="post" style="display: inline;">
                            <input type="hidden" name="Tipo" value="buscar">
                            <input type="hidden" name="codigoProducto" value="${producto.codigoProducto}"> 
                            
                            <button type="submit" class="btn btn-info btn-sm" ><span class="glyphicon glyphicon-pencil"></span></button>
                            <!--<a href="${urlEditar}">Editar</a>-->
                        </form>
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
