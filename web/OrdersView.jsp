<%-- 
    Document   : OrdersView
    Created on : 03-07-2018, 11:30:58 AM
    Author     : anthony
--%>

<%@page import="retail.modelo.entidades.OrderDetail"%>
<%@page import="retail.modelo.servicios.OrdermasterImpl"%>
<%@page import="retail.modelo.entidades.OrderMaster"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    </head>
    <style>
        td{
            font-size: 9pt !important;
            vertical-align: middle !important;
            padding: 1px !important;

        }
        
        th{
            font-size: 11pt !important;
            vertical-align: middle !important;
            padding: 1px !important;
        }

        
    </style>
        <%@include file="/WEB-INF/jspf/NavBar.jspf"%> 
        <%
            List<OrderMaster> ordersMastersBusqueda = (List<OrderMaster>) request.getAttribute(
                    "orders");
            OrdermasterImpl orderMasterImpl = new OrdermasterImpl();

            List<OrderMaster> ordersMasters = ordersMastersBusqueda == null ? orderMasterImpl.getOrderMastersDesc() : ordersMastersBusqueda;

            SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

            DecimalFormat decimalFormat = new DecimalFormat("$ ###,#00.00");

        %>
        <div class="container">
<!--            <form class="form-horizontal" action="ServletBusqueda" method="post">
                <div class="row well well-sm">
                    <div class="col-md-4">
                        <div class="form-group">
                            <div class="col-md-4">
                                <label for="orderId">No. Orden</label>
                            </div>
                            <div class="col-md-8">
                                <input type="text" name="orderId" id="orderId" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-md-offset-2" style="text-align: right;">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-sm" value="Buscar">
                        </div>
                    </div>
                </div>

            </form>-->

            <div class="row">
                <div class="col-md-12 well well-sm">
                    
                    <h1>ORDENES DE COMPRA</h1><br><br>
                    <div class="table-responsive" id="tableCont">
                        <table  class="table table-hover table-striped table-condensed">
                            <tr class="success">
                                <th style="width: 7%">Fecha</th>
                                <th style="width: 10%">No.: Orden</th>
                                <!--<th style="width: 20%">Vendedor</th>-->
                                <th style="width: 23%">Proveedor</th>
                                <!--<th style="width: 15%">Departamento</th>-->
                                <th style="width: 15%">Tipo</th>
                                <th style="width: 15%">Monto + IVA</th>
                                <th style="width: 10%"></th>
                                <th style="width: 10%"></th>
                            </tr>
                            <%for (OrderMaster ordersMaster : ordersMasters) {%>
                            <tr>
                                <td><%= formato.format(ordersMaster.getOrderdate())%></td>
                                <td><%= ordersMaster.getOrderid()%></td>
                                <!--<td ordersMaster.getVendedor().getNombreVendedor()%></td>-->
                                <td><%= ordersMaster.getProvider().getProvidername()%></td>
                                <!--<td> ordersMaster.getDepartment().getDepartmentname()%></td>-->
                                <td><%= ordersMaster.getOrderType().getTypename()%></td>
                                <td> <%= decimalFormat.format(ordersMaster.getOrdertotal())%></td>
<!--                                <td>
                                        <button type="button" class="btn btn-success btn-sm btn-block" onclick="despliege('<%= ordersMaster.getOrderid()%>')">
                                        <span class="glyphicon glyphicon-eye-open"></span>
                                    </button>
                                </td>                                    -->
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm btn-block" data-toggle="modal" data-target="#myModal" onclick="redirigirReporte('<%= ordersMaster.getOrderid()%>')">
                                        <span class="glyphicon glyphicon-print"></span>
                                    </button>
                                </td>
                                <td>
                                    <c:url value="EditOrderView.jsp" var="url">
                                        <c:param name="orderId" value="<%= ordersMaster.getOrderid()%>"></c:param>
                                    </c:url>
                                    <a class="btn btn-default btn-sm btn-block" href="${url}">
                                        <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                                </td>
                            </tr>
                            <!--                                <tr >
                                                                <td colspan="8" style="padding-top : 5px;padding-bottom: 5px;">
                                                                    <div class="center-block" id="<%= ordersMaster.getOrderid()%>" style="display: none;width:65%;">
                                                                        <table class="table table-condensed table-hover table-striped">
                                                                            <tr><th>No.:</th><th>Codigo</th><th>Descripcion</th><th>Cantidad</th><th>Precio</th><th>Total</th></tr>
                            <%
                                Set<OrderDetail> details = ordersMaster.getOrderDetails();
                            %>
                            <%for (OrderDetail orderDetail : details) {%>
                                <tr>
                                    <td style="font-size: 9pt;"><%= orderDetail.getId().getOrderdetailid()%></td>
                                    <td style="font-size: 9pt;"><%=orderDetail.getProduct().getCodigoProducto()%></td>
                                    <td style="font-size: 9pt;"><%=orderDetail.getProduct().getNombreProducto()%></td>
                                    <td style="font-size: 9pt;"><%=orderDetail.getOrderdetailquantity()%></td>
                                    <td style="font-size: 9pt;"><%=orderDetail.getOrderdetailunitprice()%></td>
                                    <td style="font-size: 9pt;"><%=orderDetail.getOrderdetailtotal()%></td>
                                </tr>
                            <%}%>
                        </table>
                    </div>
                </td>
            </tr>     -->

                            <%}%>
                            <!--<//c:forEach items="${ordersMaster}" var="orderMaster">
                                    <tr>
                                        <td>${orderMaster.orderdate}</td>
                                        <td>${orderMaster.orderid}</td>
                                        <td>${orderMaster.seller.sellername}</td>
                                        <td>${orderMaster.department.departmentname}</td>
                                        <td>${orderMaster.orderType.typename}</td>
                                        <td>${orderMaster.ordertotal}</td>
                                        <td>
                                            <button type="button" class="btn btn-warning btn-sm btn-block" data-toggle="modal" data-target="#myModal" onclick="redirigirReporte('${orderMaster.orderid}')">
                                                <span class="glyphicon glyphicon-print"></span>
                                            </button>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-warning btn-sm btn-block" onclick="despliege('${orderMaster.orderid}')">
                                                <span class="glyphicon glyphicon-eye-open"></span>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td colspan="8" style="padding-top : 5px;padding-bottom: 5px;">
                                            <div class="center-block" id="${orderMaster.orderid}" style="display: none;width:65%;">
                                                <table class="table table-condensed table-hover table-striped">
                                                    <tr><th>No.:</th><th>Codigo</th><th>Descripcion</th><th>Cantidad</th><th>Precio</th><th>Total</th></tr>
                                                    <//c:forEach items="${orderMaster.orderDetails}" var="orderDetail">
                                                        <tr>
                                                            <td style="font-size: 9pt;">${orderDetail.id.orderdetailid}</td>
                                                            <td style="font-size: 9pt;">${orderDetail.product.productid}</td>
                                                            <td style="font-size: 9pt;">${orderDetail.product.productname}</td>
                                                            <td style="font-size: 9pt;">${orderDetail.orderdetailquantity}</td>
                                                            <td style="font-size: 9pt;">${orderDetail.orderdetailunitprice}</td>
                                                            <td style="font-size: 9pt;">${orderDetail.orderdetailtotal}</td>
                                                        </tr>
                                                    <///c:forEach>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                            <///c:forEach>-->
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script>
//    function despliege(id){
//        var elementoDesplegado = $('[name = "desplegado"]');
//        elementoDesplegado.slideUp();
//        $("#"+id).slideDown();
//        $("#"+id).attr("name","desplegado");
//    }
//    
    function redirigirReporte(id) {
        //$.post("ViewReport.jsp",{orderId : id});
        window.open("reporte.do?orderId=" + id, "Orden de Compra No.:" + id);
    }
</script>
