<%-- 
    Document   : configuracionCuenta
    Created on : 22-nov-2017, 8:54:35
    Author     : practica_2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="cabecera.jsp"/>
<div class="container-fluid" style="margin-top: 1%; margin: 0; padding: 0;">
    <div class="col-md-2"></div>
    <div class="col-sm-12 col-md-10" style="margin: 0; padding: 0;">
        <div class="panel panel-danger" style="border-radius: 0; margin: 0; padding: 0; border: 0;">
            <div class="panel-heading" style="padding-left: 5%; background-color: #d94442; border-radius: 0;">
                <h1 style="color: #111;">Configuraci&oacute;n</h1>
            </div>
            <div class="panel-body" style="background-color: #f2dede;">
                <h3 style="padding-left: 7%;">Configuraci&oacute;n de cuenta</h3>         
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
                            <dt></dt><dd><button id="btnGuardarCambios" class="btn btn-danger" disabled="true">Guardar cambios</button></dd><br/>                                
                        </dl>
                    </form>                                    
                </div>                    
                <p style="border-bottom: 1px solid #c0abab; padding: 0; margin-left: 5%; margin-right: 10%; margin-bottom: 3%;"></p>
                <h3 style="padding-left: 7%;">Configuraci&oacute;n de canal</h3>
                <div class="container-fluid" style="padding-left: 10%;"><br/><br/>

                    <dl class="dl-horizontal">
                        <form id="formConfCanal" class="form-inline">
                            <dt>T&iacute;tulo: </dt><dd>
                                <input type="text" id="textConfCanal" class="form-control" value="${sessionScope.USUARIO.canal.titulo}" size="45" maxlength="45" placeholder="Introduzca título del canal." disabled="true" required pattern="[a-zA-Z0-9]*"/>
                                <span id="errorTituloConfCanal" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                <button id="btnEditarTitulo" class="btn btn-default" style="margin-left: 1%;">Editar</button>                                
                                <span id="mensajeErrorTituloConf" class="text-danger" style="margin-left: 3%;"></span>
                            </dd><br/><br/>
                            <dt>Descripci&oacute;n: </dt>
                            <dd>
                                <textarea class="form-control" rows="3" cols="47" id="desModCanal" name="desModCanal" style="resize: none;" disabled="true" placeholder="Introduzca una descripción del canal.">${sessionScope.USUARIO.canal.descripcion}</textarea>
                                    <span class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <button id="editarDescripcion" class="btn btn-default" style="margin-left: 1%;">Editar</button>
                                </dd><br/><br/>
                                <dt></dt><dd><button id="btnGuardarCambiosCanal" class="btn btn-danger" disabled="true">Guardar cambios</button></dd><br/><br/><br/>
                            </form>
                            <form id="imgAvatar" class="form-inline" method="POST" action="" enctype="multipart/form-data">
                                <dt>Avatar: </dt>
                                <dd>
                                    <div class="col-sm-4" style="width: 150px; height: 150px; background-color: white; padding: 0.5%; border: solid 2px #d94442;">
                                        <img class="img-responsive" type="image" src="
                                        <c:choose>
                                            <c:when test="${sessionScope.USUARIO.getCanal().getImgUsuario() == null}">
                                                ${sessionScope.path}/img/logotipo_min.png
                                            </c:when>
                                            <c:otherwise>
                                                ${sessionScope.USUARIO.getCanal().getImgUsuario().getImagen()}
                                            </c:otherwise>
                                        </c:choose>" style="height: 100%; width: auto; margin: auto;" />
                                </div>
                                <span class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                <input type="file" id="btnSubirImagen" name="btnSubirImagen" class="form-control" style="margin-left: 1%;"/>
                            </dd><br/><br/>
                        </form>
                    </dl>
                </div><br/>
            </div>
        </div>
    </div>
</div>