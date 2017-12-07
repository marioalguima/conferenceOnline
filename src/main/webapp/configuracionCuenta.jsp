<%-- 
    Document   : configuracionCuenta
    Created on : 22-nov-2017, 8:54:35
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="cabecera.jsp"/>

<!-- INCLUSIÓN DEL PANEL IZQUIERDO -->
<div class="col-xs-2" style="margin: 0; padding: 0; height: 110%; border-right: 1px solid white;">
    <jsp:include page="panelIzquierdo.jsp"/>
</div>
<!-- RESTO DEL PANEL -->
<div class="col-xs-10" style="margin: 0; padding: 0; height: 110%;">
    <div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
        <!-- TÍTULO DE LA PÁGINA -->
        <div class="panel-heading" style="padding-left: 5%; background-color: #d94442; border-radius: 0;">
            <h2 style="color: #111;">Configuraci&oacute;n</h2>
        </div>
        <div class="panel-body" style="background-color: #f2dede; height: 100%; padding-top: 5%;">
            <!-- PARTE DE CONFIGURACIÓN DE LA CUENTA -->
            <div class="col-xs-6">
                <h3 style="padding-left: 1%; margin-bottom: 3%;">Configuraci&oacute;n de cuenta</h3>         
                <div style="padding-left: 2%;"><br/><br/>
                    <form id="formConfCuenta" class="form-inline">
                        <dl>
                            <dt>Nombre: </dt>
                            <dd>${sessionScope.USUARIO.nombre}</dd><br/><br/>
                            <dt>Email: </dt>
                            <dd>
                                <input type="email" id="emailConfCuenta" class="form-control" value="${sessionScope.USUARIO.email}" maxlength="45" placeholder="Introduzca email" disabled="true" required pattern="[a-zA-Z0-9_.]+@[a-zA-Z0-9]+[.][a-zA-Z]{1,5}"/>
                                <span id="errorEmailConfCuenta" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                <button id="editarEmail" class="btn btn-default" style="margin-left: 1%;">Editar</button>                                
                                <span id="mensajeErrorEmailConf" class="text-danger" style="margin-left: 3%;"></span>
                            </dd><br/><br/>
                            <dt>Contrase&ntilde;a: </dt>
                            <dd>
                                <input type="password" id="passwordConfCuenta" class="form-control" value="${sessionScope.USUARIO.password}" maxlength="45" placeholder="Introduzca contraseña" disabled="true" required />
                                <span id="errorPasswordConfCuenta" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                <button id="editarPassword" class="btn btn-default" style="margin-left: 1%;">Editar</button>
                                <span id="mensajeErrorPasswordConf" class="text-danger" style="margin-left: 3%;"></span>
                            </dd><br/>
                            <div id="repetidaBloque" style="display: none;">
                                <dt>Repetir contrase&ntilde;a: </dt>
                                <dd>
                                    <input type="password" id="repetidaConfCuenta" class="form-control" value="" maxlength="45" placeholder="Introduzca contraseña" pattern="[a-zA-Z0-9]*" />
                                </dd>
                            </div><br/><br/>
                            <dt></dt><dd><button id="btnGuardarCambios" class="btn btn-danger" disabled="true">Guardar cambios</button></dd><br/>                                
                        </dl>
                    </form>                                    
                </div>
            </div>
            <!-- PARTE DE CONFIGURACIÓN DEL CANAL SÓLO EN CASO DE USUARIO REGISTRADO -->
            <c:if test="${!sessionScope.USUARIO.tipo.equals('a')}">
                <div class="col-xs-6" style="border-left: 1px solid black;">
                    <h3 style="padding-left: 1%; margin-bottom: 3%;">Configuraci&oacute;n de canal</h3>
                    <div class="" style="padding-left: 2%;"><br/><br/>

                        <dl>
                            <form id="formConfCanal" class="form-inline">
                                <dt>T&iacute;tulo: </dt><dd>
                                    <input type="text" id="TituloConfCanal" class="form-control" value="${sessionScope.USUARIO.canal.titulo}" maxlength="45" placeholder="Introduzca título del canal." disabled="true" required pattern="[a-zA-Z0-9 ]*"/>
                                    <span id="errorTituloConfCanal" class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <button id="btnEditarTitulo" class="btn btn-default" style="margin-left: 1%;">Editar</button>
                                </dd><br/><br/>
                                <dt>Descripci&oacute;n: </dt>
                                <dd>
                                    <textarea class="form-control" rows="3" id="desModCanal" name="desModCanal" style="resize: none;" disabled="true" placeholder="Introduzca una descripción del canal.">${sessionScope.USUARIO.canal.descripcion}</textarea>
                                    <span class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <button id="editarDescripcion" class="btn btn-default" style="margin-left: 1%;">Editar</button>
                                </dd><br/><br/>
                                <dt></dt><dd><button id="btnGuardarCambiosCanal" class="btn btn-danger" disabled="true">Guardar cambios</button></dd><br/><br/><br/>
                            </form>
                            <!-- PARTE DE SUBIDA DE IMAGEN DE AVATAR -->
                            <form id="formSubirImagen" class="form-inline" enctype="multipart/form-data">
                                <dt>Avatar: </dt>
                                <dd>
                                    <div class="col-sm-4" style="width: 130px; height: 130px; background-color: white; padding: 0.5%; border: solid 2px #d94442;">
                                        <img class="img-responsive" type="image" src="
                                             <c:choose>
                                                 <c:when test="${sessionScope.USUARIO.getCanal().getImgUsuario() == null}">
                                                     ${sessionScope.path}/img/logotipo_min.png
                                                 </c:when>
                                                 <c:otherwise>
                                                     ${sessionScope.path}/img/${sessionScope.USUARIO.getCanal().getImgUsuario().getImagen()}
                                                 </c:otherwise>
                                             </c:choose>" style="height: 100%; width: auto; margin: auto;" />
                                    </div>
                                    <span class="glyphicon glyphicon-remove text-danger" style="visibility: hidden;"></span>
                                    <div>
                                        <input type="file" id="btnAgregarImagen" name="btnAgregarImagen" class="form-control" style="margin-left: 1%;" accept="image/png, imagen/jpg, image/jpeg, image/gif"/><br/><br/>
                                        <button id="btnGuardarImagen" value="GuardarImagen" class="btn btn-danger" onclick="return false;" style="margin-left: 1%; visibility: hidden;">Guardar Imagen</button>
                                    </div>
                                </dd>
                            </form>
                        </dl>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>