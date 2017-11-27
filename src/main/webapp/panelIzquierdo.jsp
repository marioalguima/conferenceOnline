<%-- 
    Document   : panelIzquierdo
    Created on : 24-nov-2017, 12:52:09
    Author     : Mario
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%">
    <div class="panel-heading" style="padding-left: 10%; background-color: #050505; border-radius: 0; ">
        <h1 style="color: #ffffff;">Bienvenido</h1>
    </div>
    <div class="panel-body" style="background-color: #909090; height: 100%; padding-left: 0; padding-right: 0;">
        <ul class="list-unstyled" style="margin-left: 8%;">
            <li><h4><a href="${sessionScope.path}/index.jsp" style="color: #000;">Inicio</a></h4></li>
            <li><h4><a href="${sessionScope.path}/canal.jsp" style="color: #000;">Mi canal</a></h4></li>
            <li><h4><a href="${sessionScope.path}/configuracionCuenta.jsp" style="color: #000;">Configuraci&oacute;n</a></h4></li>
        </ul>
        <div style="background-color: #050505; text-align: center;">
            <h3 style="color: #d94442; padding-top: 1%; padding-bottom: 1%; border-bottom: 1px solid white; border-top: 1px solid white;">Gente a la que sigues</h3>
            <ul>
            </ul>
        </div>
    </div>
</div>