<%-- 
    Document   : index
    Created on : 07-nov-2017, 22:32:43
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="cabecera.jsp"/>

<c:choose>
    <c:when test="${sessionScope.USUARIO != null}">
        <div class="col-md-2" style="margin: 0; padding: 0; height: 100%; border-right: 1px solid white;">
            <jsp:include page="panelIzquierdo.jsp"/>
        </div>
       <div class="col-sm-12 col-md-10" style="margin: 0; padding: 0; height: 100%;">
    </c:when>
    <c:otherwise>
        <div style="margin: 0; padding: 0; height: 100%;">
    </c:otherwise>
</c:choose>
    <div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
        <div class="panel-heading" style="padding-left: 5%; background-color: #d94442; border-radius: 0;">
            <h1 style="color: #111;">Actualmente en directo</h1>
        </div>
        <div class="panel-body" style="background-color: #f2dede; height: 100%; padding-top: 5%;">
        
        </div>
    </div>
</div>