<%-- 
    Document   : TypeDropDown
    Created on : 02-07-2018, 10:30:47 AM
    Author     : anthony
--%>

<%@page import="retail.modelo.entidades.OrderType"%>
<%@page import="retail.modelo.servicios.OrderTypeImpl"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<select name="typeid" id="typeid" class="form-control input-sm">
    <option value="-1" selected>Seleccione...</option>
    <%
        OrderTypeImpl typeImpl = new OrderTypeImpl();
        List<OrderType> types = typeImpl.getOrderTypes();
        pageContext.setAttribute("typeList", types);
    %>
    <c:forEach items="${typeList}" var="type">
        <option value="${type.typeid}">${type.typename}</option>
    </c:forEach>
</select>
