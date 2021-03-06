<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html style="height: 100%;">
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
        <link href="${sessionScope.path}/css/bootstrap-toggle.min.css" rel="stylesheet" type="text/css">
        <script src="${sessionScope.path}/js/bootstrap-toggle.min.js"></script>
        <!-- SCRIPT DEL DIRECTO -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdn.pubnub.com/pubnub-3.7.14.min.js"></script>
        <script src="https://cdn.pubnub.com/webrtc/webrtc.js"></script>
        <script src="https://cdn.pubnub.com/webrtc/rtc-controller.js"></script>
    </head>
    <body class="container-fluid" style="padding-left: 0; padding-right: 0; width: 100%; height: 100%;">

        <!-- MODAL DE REGISTRO Y LOGIN DE USUARIOS -->
        <c:if test="${sessionScope.USUARIO==null}">
            <div class="modal fade" id="formRegistroLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 5%;">
                <div class="modal-dialog">                                    
                    <div class="modal-content">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin: 2%;" >
                            <span aria-hidden="true" class="glyphicon glyphicon-remove"></span>
                        </button>
                        <div class="modal-header">
                            <ul class="nav nav-tabs nav-justified">
                                <li id="CabInicioSesion" class="active"><a href="#inicioSesion" data-toggle="tab"><b>Iniciar sesi&oacute;n</b></a></li>
                                <li id="CabRegistro"><a href="#registro" data-toggle="tab"><b>Registrarse</b></a></li>
                            </ul>
                            <div class="modal-body tab-content">

                                <!-- PARTE INICIO DE SESION -->
                                <div id="inicioSesion" class="tab-pane fade in active">
                                    <form id="formLogin" class="form-horizontal">
                                        <fieldset class="container-fluid">
                                            <legend>Iniciar Sesi&oacute;n</legend>
                                            <h4 id="errorLogin" class="text-danger"></h4>
                                            <div class="form-group">
                                                <label class="col-sm-12" for="usuarioLogin">Usuario</label>
                                                <div class="col-sm-11">
                                                    <input type="text" class="form-control" id="usuarioLogin" name="usuarioLogin" maxlength="15" minlength="3" placeholder="Introduzca su nombre de usuario (sólo caracteres alfanuméricos)" pattern="[a-zA-Z0-9]*" required/>
                                                </div>
                                                <span id="errorUsuarioLogin" class="col-sm-1" style="visibility: hidden;"></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-12" for="passwordLogin">Contrase&ntilde;a</label>
                                                <div class="col-sm-11">
                                                    <input type="password" class="form-control" id="passwordLogin" name="passwordLogin" maxlength="15" minlength="3" placeholder="Introduzca su contraseña (sólo caracteres alfanuméricos)" pattern="[a-zA-Z0-9]*" required/>
                                                </div>
                                                <span id="errorPasswordLogin" class="col-sm-1" style="visibility: hidden;"></span>
                                            </div><br/>
                                            <button class="btn btn-default" id="btnIniciarSesion" value="Entrar">Iniciar sesi&oacute;n</button>
                                        </fieldset>
                                    </form>
                                </div>

                                <!-- PARTE REGISTRO DE USUARIO -->
                                <div id="registro" class="tab-pane fade">
                                    <form action="${sessionScope.path}/ControlUsuario" method="post" class="form-horizontal">
                                        <fieldset class="container-fluid">
                                            <legend>Formulario de Registro</legend>
                                            <h4 id="errorRegistro" class="text-danger"></h4>
                                            <div class="form-group">
                                                <label class="col-sm-12" for="usuarioRegistro">Nombre de usuario</label>
                                                <div class="col-sm-11">
                                                    <input type="text" class="form-control" id="usuarioRegistro" name="usuarioRegistro" maxlength="15" minlength="3" placeholder="Introduzca su nombre de usuario (sólo caracteres alfanuméricos)" pattern="[a-zA-Z0-9]*" required/>
                                                </div>
                                                <span id="errorNombreRegistro" class="col-sm-1" style="visibility: hidden;"></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-12" for="emailRegistro">Email</label>
                                                <div class="col-sm-11">
                                                    <input type="email" class="form-control" id="emailRegistro" name="emailRegistro" maxlength="45" placeholder="Introduzca su email" required pattern="[a-zA-Z0-9_.]+@[a-zA-Z0-9]+[.][a-zA-Z]{1,5}"/>
                                                </div>
                                                <span id="errorEmailRegistro" class="col-sm-1" style="visibility: hidden;"></span>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-12" for="passwordRegistro">Contrase&ntilde;a</label>
                                                <div class="col-sm-11">
                                                    <input type="password" class="form-control" id="passwordRegistro" name="passwordRegistro" maxlength="15" minlength="3" placeholder="Introduzca su contraseña (sólo caracteres alfanuméricos)" pattern="[a-zA-Z0-9]*" required/>
                                                </div>
                                                <span id="errorPasswordRegistro" class="col-sm-1" style="visibility: hidden;"></span>
                                            </div>                    
                                            <div class="form-group">
                                                <label class="col-sm-12" for="passwordRepetida">Repita la Contrase&ntilde;a</label>
                                                <div class="col-sm-11">
                                                    <input type="password" class="form-control" id="passwordRepetida" name="passwordRepetida" maxlength="15" minlength="3" placeholder="Repetir contraseña" disabled="true" required/>
                                                </div>
                                                <span class="col-sm-1"></span>
                                            </div><br/>
                                            <input type="submit" id="btnRegistrarse" class="btn btn-default" name="peticion" value="Registrarse"/>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </c:if>
        <!-- HEADER COMUN A TODAS LAS PÁGINAS -->
        <header class="page-header container-fluid row" style="padding-bottom: 1%; padding-top: 0.9%; margin: 0;">
            <!-- LOGOTIPO DE LA PÁGINA -->
            <div class="col-xs-3">
                <a href="${sessionScope.path}/index.jsp"><img src="${sessionScope.path}/img/logotipo.png" alt="Logotipo" title="Ir a Inicio" class="img-responsive" style="margin-left: 30%; max-width: 50%;"/></a>
            </div>
            <!-- BUSCADOR DE USUARIO POR NOMBRE -->
            <div class="col-xs-9" style="margin-top: 2%;">
                <div class="col-xs-7">
                    <form id="formBusqueda" method="post">
                        <div class="form-group" style="margin-right: 0; padding-right: 0;">
                            <input id="buscarUsuarios" type="text" class="form-control" name="nombre" placeholder="Buscar usuario" style="border-radius: 0;" autocomplete="off"/>
                            <input type="hidden" name="peticion" value="buscarUsuario"/>
                        </div>                        
                    </form>
                    <ul id="resultadoBusqueda" class="dropdown-menu" style="margin-left: 2%;">
                    </ul>
                </div>
                <!-- PARTE CON LOS BOTONES DE INICIO DE SESION Y REGISTRO O DESPLEGABLE EN CASO DE USUARIO REGISTRADO -->
                <div class="col-xs-5" style="padding-left: 15%;">
                    <c:choose>
                        <c:when test="${sessionScope.USUARIO==null}">
                            <div class="col-xs-12 btn-group">
                                <button id="btnEntrar" class="btn btn-default" data-toggle="modal" data-target="#formRegistroLogin" style="border-radius: 0;">Iniciar sesi&oacute;n</button>
                                <button id="btnRegistro" class="btn btn-default" data-toggle="modal" data-target="#formRegistroLogin" style="border-radius: 0;">Registrarse</button>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.USUARIO!=null}">
                            <div class="btn-group">
                                <button id="miCuenta" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="border-radius: 0;">
                                    Mi cuenta
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <c:if test="${!sessionScope.USUARIO.tipo.equals('a')}">
                                    <li><a href="${sessionScope.path}/canal.jsp">Mi canal</a></li>
                                    </c:if>                                    
                                    <li><a href="${sessionScope.path}/configuracionCuenta.jsp">Configurar datos de cuenta</a></li>
                                    <li class="divider"></li>
                                    <li><a href="index.jsp" onclick="return false;" id="menuCerrarSesion">Cerrar sesi&oacute;n</a></li>
                                </ul>
                            </div>
                        </c:when>                            
                    </c:choose>
                </div>
            </div>   
        </header>
        <div class="container-fluid" style="margin-top: 1%; margin: 0; padding: 0; height: 100%;">