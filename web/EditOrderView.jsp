<%-- 
    Document   : NewOrderView
    Created on : 02-07-2018, 10:55:47 AM
    Author     : anthony
--%>


<%@page import="retail.modelo.entidades.OrderMaster"%>
<%@page import="retail.modelo.servicios.OrdermasterImpl"%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <style>
            body{

            }
            #tableCont{
                height: 300px !important;
            }
            
            input[type='text']{
                font-size: 8pt !important;
            }
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/NavBar.jspf"%>
        <div class="container">
            
            <form style="width: 100%;" class="center-block form-horizontal" action="EditOrderServlet" method="post"  id="formulario">
                <div class="well well-lg">
                <div class="">
                            <% 
                                    String orderId = request.getParameter("orderId");
                                    OrdermasterImpl ordermasterImpl = new OrdermasterImpl();
                                    OrderMaster orderMaster = ordermasterImpl.getOrderMasterById(
                                            orderId);
                                    pageContext.setAttribute("orderMaster",
                                              orderMaster);
                                  
                                    SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
                                    pageContext.setAttribute("formato",
                                                formato);
                                    
                                    DecimalFormat decimalFormat = new DecimalFormat("###,##0.00");
                                    pageContext.setAttribute("decimalFormat",
                                                decimalFormat);
                                    
                                    String fecha = formato.format(orderMaster.getOrderdate());
                                    pageContext.setAttribute("fecha",
                                            fecha);
                            %>
                            

                        <div class="form-group">
                            <div class="col-xs-12"><h2><label class="label label-success">Fecha: ${fecha}</label></h2></div>
                            <input type="hidden" name="fecha" value="${fecha}" >
                            <input type="hidden" name="orderid" value="${orderMaster.orderid}">
                            <div class="col-xs-12"><h2><label class="label label-primary ">Orden No.: ${orderMaster.orderid}</label></h2></div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-4">
                                <label>Proveedor: </label>
                            </div>
                            <div class="col-md-8">
                                <input type="hidden" id="hiddenproviderId" value="${orderMaster.provider.providerid}">
                                <jsp:include page="HelperPages/ProviderDropDown.jsp"></jsp:include>
                            </div>
                        </div>
<!--                         <div class="form-group">
                             <div class="col-md-4">
                                <label>Vendedor: </label>
                            </div>
                            <div class="col-md-8">
                                <input type="hidden" id="hiddensellerId" value="${orderMaster.vendedor.idVendedor}">
                                <jsp:include page="HelperPages/SellerDropDown.jsp"></jsp:include>
                            </div>
                        </div>-->
                        <div class="form-group">
                            <div class="col-md-4">
                                <label>Tipo de Orden: </label>                               
                            </div>
                            <div class="col-md-8">
                                <input type="hidden" id="hiddentypeId" value="${orderMaster.orderType.typeid}">
                                <jsp:include page="HelperPages/TypeDropDown.jsp"></jsp:include>
                            </div>
                        </div>
<!--                         <div class="form-group">
                             <div class="col-md-4">
                                <label>Departamento Solicitante: </label>
                             </div>
                             <div class="col-md-8">
                                 <input type="hidden" id="hiddendepartmentId" value="${orderMaster.department.departmentid}">
                                <jsp:include page="HelperPages/DepartmentDropDown.jsp"></jsp:include>
                            </div>
                        </div>-->
                        <div class="form-group">
                                <textarea id="orderComent"   placeholder="Comentario..." rows="7" class="form-control input-sm" style="resize:none;" name="comentario">${orderMaster.ordercoment}</textarea>
                        </div>
                </div>
                <div class="well well-lg" style="margin-top: 40px;">
                    <div class="form-group">
                        <button class="btn btn-sm btn-success " type="button" id="newRow"><span class="glyphicon glyphicon-plus"></span> Fila</button>
                    </div>

                    <div class="table-responsive" id="tableCont">
                        <table class="table table-striped table-hover table-condensed" >
                            <thead>
                                <tr>
                                    <th style="width: 4%;">No.:</th>
                                    <th style="width: 15%;">Producto</th>
                                    <th style="width: 20%;">Descripcion</th>
                                    <th style="width: 15%;">Color</th>                                    
                                    <th style="width: 15%;">Cantidad</th>
                                    <th style="width: 15%;">Precio U.</th>
                                    <th style="width: 15%;">Importe</th>
                                    <th style="width: 6%;"></th>
                                </tr>
                            </thead>
                            <tbody id="tableDetail">
                            <c:forEach var="orderDetail" items="${orderMaster.orderDetails}">
                                <tr id="${orderDetail.id.orderdetailid}" >
                                    <td style="vertical-align: middle;"><h5><label class="label label-default" id="numberRow">${orderDetail.id.orderdetailid}</label></h5></td>
                                    <input type="hidden" id="hiddenproductid" value="${orderDetail.product.codigoProducto}">
                                    <td><jsp:include page="HelperPages/ProductDataList.jsp"></jsp:include></td>
                                    <td><input type="text" value="${orderDetail.product.nombreProducto}" class="form-control input-sm" readonly id="nameProduct"></td>
                                    <td><input type="text" value="${orderDetail.productcolor}" class="form-control input-sm" id="color" name="color"></td>                                   
                                    <td><input type="text" value="${orderDetail.orderdetailquantity}" placeholder="0.00" class="form-control input-sm" onkeypress="return onlyDecimalNumber(event)" onblur="sumaDetalle(event)" id="cantidad" name="cantidad"></td>
                                    <td><input type="text" value="${orderDetail.orderdetailunitprice}" placeholder="0.00" class="form-control input-sm" onkeypress="return onlyDecimalNumber(event)" onblur="sumaDetalle(event)" id="precioUnitario" name="precioUnitario"></td>
                                    <td><input type="text" value="${orderDetail.orderdetailtotal}" placeholder="0.00" class="form-control input-sm" readonly id="monto" name="monto"></td>
                                    <td style="vertical-align: middle;"><button class="btn btn-xs btn-danger" type="button" onclick="deleteRow(event)">X</button></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row" style="padding-top : 20px;">
                        <div class="col-md-4 col-md-offset-1">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Sub-Total $</span>
                                    <input type="text" value="${decimalFormat.format(orderMaster.ordertotal)}" placeholder="0.00" class="form-control input-sm" id="subTotal" disabled name="subTotal">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon ">Total IVA $</span>
                                    <input type="text" value="${decimalFormat.format((orderMaster.ordertotal * 0.13))}" placeholder="0.00" class="form-control input-sm" id="totalIva" disabled name="iva">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Total $</span>
                                    <input type="text" value="${decimalFormat.format(orderMaster.ordertotal+(orderMaster.ordertotal * 0.13))}" placeholder="0.00" class="form-control input-sm" id="total" disabled name="total">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-md-offset-4" style="padding-left: 30px;">
                            <div class="form-group">
                                <input type="submit" class="btn btn-success btn-block" value="Guardar" >
                            </div>
                            <div class="form-group">
                                <input type="reset" class="btn btn-primary btn-block" value="Borrar Campos">
                            </div>
                            <div class="form-group">
                                <a href="OrdersView.jsp" class="btn btn-warning btn-block">Cancelar</a>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </form>
        </div>
    </body>
</html>
<script>
    window.addEventListener("load",initPage,false);
    
    function initPage(){
        $("#formulario").submit(function (e){
            validarSelect(e);
        });
        
        newRowBtn = document.getElementById("newRow");
        newRowBtn.addEventListener("click",newRow,false);
        
        var productIdText = document.getElementById("productid");
         productIdText.addEventListener("blur",function(e){
            productName(e);
        },false);
        
        asignarValores();
    }
    
    function newRow(){
        var table = document.getElementById("tableDetail");
        var rows = document.querySelectorAll("tbody tr");
        var textoHtml = rows[0].innerHTML;
        

        if(rows.length < 15){
            var newElement = document.createElement("tr");
            newElement.innerHTML = textoHtml;
            var numeroFila = parseInt(rows.length) + 1;
            newElement.id = numeroFila;

            table.appendChild(newElement);

            var numerRowLabel = $("tr#"+(numeroFila)+ " label");
            numerRowLabel.html((numeroFila));
            
            var numerRowInput = $("tr#"+(numeroFila)+ " input");
            
            $.each(numerRowInput,function (i,data){
                data.value = "";
            });

            var deleteBtn = $("tr#"+numeroFila+" td button");
            
        }else{
            alert("Solo se permiten 15 registros");
        }
        
//        deleteBtn.on("click",function(e){
//            deleteRow(e);
//        });
        
//        var productIdTex  = $("tr#"+numeroFila+" td input[name='productid']");
//        productIdTex.on("blur",productName); 
        

    }
    
    function deleteRow(e){
        var rows = $("#tableDetail tr");
        
        if(rows.length == 1){
            return;
        }
        
        var fila = e.target.parentNode.parentNode;
        var tabla = document.getElementById("tableDetail");
        tabla.removeChild(fila);
        
        //$("tr#"+numRow).remove();
        
        rows = $("#tableDetail tr");
        
        for(a = 0; a<rows.length ; a++){
            rows[a].id = ((a+1)+"");
        }
        
        var labelsNumber = $("table label#numberRow");
        for(i = 0; i<labelsNumber.length ; i++){
            labelsNumber[i].innerHTML = ((i+1)+"");
        }
        
            totalizar();
    }
    
    function productName(eventObj){
        var textField = eventObj.target;
        var celda = textField.parentNode;
        var fila = celda.parentNode;
        
        
        var nameProductText = $("table tbody tr#"+fila.id+" input[id='nameProduct']");
        
        $.post("HelperServlet",{accion : "getProductName",productid : textField.value},function(responseText){
            nameProductText.val(responseText);
        });
    }
    
    function validarSelect(e){
        var selects = document.querySelectorAll("select");
        var estado = true;
        var pruebaProductos = document.querySelectorAll("input#nameProduct");
        
        for(k = 0 ; k < pruebaProductos.length ; k++){
            var nombre = pruebaProductos[k].value;
            if(nombre == "Error de Codigo" || nombre == ""){
                e.preventDefault();
                alert("Error de Codigos en el Registro");
                return;
            }
        }


        for(i = 0; i < selects.length ; i++){
            var value = selects[i].value;
            if(value == -1){
                e.preventDefault();
                alert("Complete todos los campos");
                return;
            }
        }
    }
    
    function asignarValores(){
//        var hiddenSellerId = document.getElementById("hiddensellerId");
        var hiddenProviderId = document.getElementById("hiddenproviderId");
        var hiddenTypeId = document.getElementById("hiddentypeId");
//        var hiddenDepartmentId = document.getElementById("hiddendepartmentId");
        var hiddenContactName = document.getElementById("hiddencontactname");
        
//        var selectSellerId = document.getElementById("sellerid");
        var selectProviderId = document.getElementById("providerid");
        var selectTypeId = document.getElementById("typeid");
//        var selectDepartmentId = document.getElementById("departmentid");
        
//        selectSellerId.value = hiddenSellerId.value;
        selectProviderId.value = hiddenProviderId.value;
        selectTypeId.value = hiddenTypeId.value;
//        selectDepartmentId.value = hiddenDepartmentId.value;

        
        var hiddenProductid = document.querySelectorAll("#hiddenproductid");
        var inputProductid = document.querySelectorAll("#productid");
        
        for(i = 0 ; i < hiddenProductid.length; i++){
            inputProductid[i].value = hiddenProductid[i].value;
        }
    }
    
</script>