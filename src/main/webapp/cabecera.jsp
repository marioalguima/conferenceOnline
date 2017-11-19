<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="author" content="Mario Alberto Guisado Mateos" />
        <meta name="generator" content="NetBeans IDE 8.2" />
        <meta name="robots" content="index, follow" />
        <title>Conference Online</title>
        <meta name="description" content="Proyecto tienda online" />
        <link href="img/logotipo_min.ico" type="image/x-icon" rel="shortcut icon"/>
        <link rel="stylesheet" type="text/css" href="${sessionScope.path}/css/bootstrap.css" />
        <script src="${sessionScope.path}/js/jquery-3.1.1.min.js"></script>
        <script src="${sessionScope.path}/js/bootstrap.min.js"></script>
    </head>
    <body class="container-fluid">

        <header class="page-header container-fluid row" style="padding-bottom: 1%; padding-top: 1%; margin-top: 0; ">
            <div class="col-xs-12 col-md-3">
                <a href="${sessionScope.path}"><img src="${sessionScope.path}/img/logotipo.png" alt="Logotipo" class="img-responsive" style="margin-left: 30%; max-width: 50%"/></a>
            </div>
            <div class="col-xs-12 col-md-9" style="margin-top: 2%;">
                <div class="col-xs-12 col-md-7">
                    <form action="${sessionScope.path}/" method="post">
                        <div class="form-group col-md-11" style="margin-right: 0; padding-right: 0;">
                            <input type="text" class="form-control" name="nombre" placeholder="Buscar" style="border-radius: 0;"/>
                        </div>
                        <input type="submit" class="btn btn-default col-md-1" name="buscar" value="" style="border-radius: 0; margin-left: 0; padding-left: 0; background-image: url(${sessionScope.path}/img/lupa.png); background-size: cover; border-left: none; opacity: 0.8"/>
                    </form>
                </div>
                <div class="col-xs-6 col-md-5" style="padding-left: 15%;">
                    <c:choose>
                        <c:when test="${sessionScope.USUARIO==null}">
                            <button class="btn btn-default" style="border-radius: 0;">Iniciar sesi&oacute;n</button>
                            <button class="btn btn-default" style="border-radius: 0;">Registrarse</button>
                        </c:when>
                        <c:when test="${sessionScope.USUARIO!=null}">
                            <button class="btn btn-default" style="border-radius: 0;">Mi canal</button>
                        </c:when>                            
                    </c:choose>
                </div>
            </div>   
        </header>