<%-- 
    Document   : VendedorDropDown
    Created on : 02-07-2018, 10:25:58 AM
    Author     : anthony
--%>

<%@page import="retail.modelo.entidades.Vendedor"%>
<%@page import="retail.modelo.servicios.ServiciosVendedor"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<select name="sellerid" id="sellerid" class="form-control input-sm">
    <option value="-1" selected>Seleccione...</option>
    <%
        ServiciosVendedor serviciosVendedor = new ServiciosVendedor();
        List<Vendedor> sellers = serviciosVendedor.obtenerVendedores();
        pageContext.setAttribute("sellerList", sellers);
    %>
    <c:forEach items="${sellerList}" var="seller">
        <option value="${seller.idVendedor}">${seller.nombreVendedor}</option>
    </c:forEach>
</select>
