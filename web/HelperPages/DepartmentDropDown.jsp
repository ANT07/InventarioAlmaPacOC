<%-- 
    Document   : DepartmentDropDown
    Created on : 02-07-2018, 10:23:29 AM
    Author     : anthony
--%>

<%@page import="retail.modelo.entidades.Department"%>
<%@page import="retail.modelo.servicios.DepartmentImpl"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<select name="departmentid" id="departmentid" class="form-control input-sm">
    <option value="-1" selected>Seleccione...</option>
    <%
        DepartmentImpl departmentImpl = new DepartmentImpl();
        List<Department> departments = departmentImpl.getDepartments();
        pageContext.setAttribute("departmentList", departments);
    %>
    <c:forEach items="${departmentList}" var="department">
        <option value="${department.departmentid}">${department.departmentname}</option>
    </c:forEach>
</select>