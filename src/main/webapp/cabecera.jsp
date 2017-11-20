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
        <script src="${sessionScope.path}/js/eventos.js"></script>
    </head>
    <body class="container-fluid">

        <!-- MODAL DE REGISTRO Y LOGIN DE USUARIOS -->
        <div class="modal fade" id="formRegistroLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 5%;">
            <div class="modal-dialog">                                    
                <div class="modal-content">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin: 2%;" >
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <div class="modal-header">
                        <ul class="nav nav-tabs nav-justified">
                            <li id="CabInicioSesion" class="active"><a href="#inicioSesion" data-toggle="tab">Iniciar sesi&oacute;n</a></li>
                            <li id="CabRegistro"><a href="#registro" data-toggle="tab">Registrarse</a></li>
                        </ul>
                        <div class="modal-body tab-content">
                            <div id="inicioSesion" class="tab-pane fade in active">
                                <h3>Inicio Sesi&oacute;n</h3>

                            </div>
                            <div id="registro" class="tab-pane fade">
                                <h3>Registro</h3>

                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <!-- HEADER COMUN A TODAS LAS PÁGINAS -->
        <header class="page-header container-fluid row" style="padding-bottom: 1%; padding-top: 1%; margin-top: 0; ">
            <div class="col-xs-12 col-md-3">
                <a href="${sessionScope.path}"><img src="${sessionScope.path}/img/logotipo.png" alt="Logotipo" class="img-responsive" style="margin-left: 30%; max-width: 50%"/></a>
            </div>
            <div class="col-xs-12 col-md-9" style="margin-top: 2%;">
                <div class="col-xs-12 col-md-7">
                    <form action="${sessionScope.path}/" method="post">
                        <div class="form-group col-xs-11 col-sm-11 col-md-11 col-lg-11" style="margin-right: 0; padding-right: 0;">
                            <input type="text" class="form-control" name="nombre" placeholder="Buscar" style="border-radius: 0;"/>
                        </div>
                        <input type="submit" class="btn btn-default col-xs-1 col-sm-1 col-md-1 col-lg-1" name="buscar" value="" style="border-radius: 0; margin-left: 0; padding-left: 0; background-image: url(${sessionScope.path}/img/lupa.png); background-size: cover; border-left: none; opacity: 0.8"/>
                    </form>
                </div>
                <div class="col-xs-6 col-md-5" style="padding-left: 15%;">
                    <c:choose>
                        <c:when test="${sessionScope.USUARIO==null}">
                            <div class="col-xs-12 col-md-12">
                                <button id="btnEntrar" class="btn btn-default" data-toggle="modal" data-target="#formRegistroLogin" style="border-radius: 0;">Iniciar sesi&oacute;n</button>
                                <button id="btnRegistro" class="btn btn-default" data-toggle="modal" data-target="#formRegistroLogin" style="border-radius: 0;">Registrarse</button>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.USUARIO!=null}">
                            <button class="btn btn-default" style="border-radius: 0;">Mi canal</button>
                        </c:when>                            
                    </c:choose>
                </div>
            </div>   
        </header>