<%-- 
    Document   : ProductDataList
    Created on : 02-07-2018, 10:05:29 AM
    Author     : anthony
--%> 

<%@page import="retail.modelo.entidades.Producto"%>
<%@page import="retail.modelo.servicios.ServiciosProducto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
    <%
        ServiciosProducto productImpl = new ServiciosProducto();
        List<Producto> products = productImpl.obtenerProducto();
        pageContext.setAttribute("products", products);
    %>
    <datalist id="products">
        <c:forEach var="product" items="${products}">
            <option value="${product.codigoProducto}" label="${product.nombreProducto}"></option>
        </c:forEach>
    </datalist>
    
    <input type="text" list="products" id="productid" name="productid" class="form-control input-sm" onblur="productName(event)">
    
