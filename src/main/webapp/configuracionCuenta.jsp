<%-- 
    Document   : configuracionCuenta
    Created on : 22-nov-2017, 8:54:35
    Author     : practica_2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecera.jsp"/>
<div class="container-fluid" style="margin-top: 1%; margin: 0; padding: 0;">
    <div class="col-md-2"></div>
    <div class="col-sm-12 col-md-10" style="margin: 0; padding: 0;">
        <div class="panel panel-danger" style="border-radius: 0; margin: 0; padding: 0;">
            <div class="panel-heading" style="padding-left: 5%;">
                <h1>Configuraci&oacute;n</h1>
            </div>
            <div class="panel-body">
                <fieldset class="container-fluid">
                    <legend><h3 style="padding-left: 7%;">Configuraci&oacute;n de cuenta de usuario</h3></legend>              
                    <div class="container-fluid" style="padding-left: 10%;"><br/><br/>
                        <form id="formConfCuenta" class="form-inline">
                            <dl class="dl-horizontal">
                                <dt>Nombre: </dt>
                                <dd>${sessionScope.USUARIO.nombre}</dd><br/><br/>
                                <dt>Email: </dt>
                                <dd>
                                    <input type="email" id="emailConfCuenta" class="form-control" value="${sessionScope.USUARIO.email}" size="45" maxlength="45" placeholder="Introduzca email" disabled="true" required pattern="[a-zA-Z0-9_.]+@[a-zA-Z0-9]+[.][a-zA-Z]{1,5}"/>
                                    <span id="errorEmailConfCuenta" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <button id="editarEmail" class="btn btn-default" style="margin-left: 1%;">Editar</button>                                
                                    <span id="mensajeErrorEmailConf" class="text-danger" style="margin-left: 3%;"></span>
                                </dd><br/><br/>
                                <dt>Contrase&ntilde;a: </dt>
                                <dd>
                                    <input type="password" id="passwordConfCuenta" class="form-control" value="${sessionScope.USUARIO.password}" size="45" maxlength="45" placeholder="Introduzca contraseña" disabled="true" required />
                                    <span id="errorPasswordConfCuenta" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <button id="editarPassword" class="btn btn-default" style="margin-left: 1%;">Editar</button>
                                    <span id="mensajeErrorPasswordConf" class="text-danger" style="margin-left: 3%;"></span>
                                </dd><br/>
                                <div id="repetidaBloque" style="display: none;">
                                    <dt>Repetir contrase&ntilde;a: </dt>
                                    <dd>
                                        <input type="password" id="repetidaConfCuenta" class="form-control" value="" size="45" maxlength="45" placeholder="Introduzca contraseña" pattern="[a-zA-Z0-9]*" />
                                    </dd>
                                </div><br/><br/>
                                <dt></dt><dd><button id="btnGuardarCambios" class="btn btn-danger" disabled="true">Guardar cambios</button></dd>
                            </dl>
                        </form>
                    </div>
                </fieldset><br/><br/>
                <fieldset class="container-fluid">
                    <legend><h3 style="padding-left: 7%;">Configuraci&oacute;n de canal</h3></legend>
            </div>
        </div>
    </div>
</div>