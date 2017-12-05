<%-- 
    Document   : administracion
    Created on : 29-nov-2017, 12:35:47
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="categorias" class="es.albarregas.beans.Categoria" scope="page"/>
<jsp:useBean id="usuarios" class="es.albarregas.beans.Usuario" scope="page"/>
<c:set var="todasCategorias" scope="page" value="${categorias.getCategorias()}"/>
<c:set var="todosUsuarios" scope="page" value="${usuarios.getUsuarios()}"/>
<jsp:include page="cabecera.jsp"/>
<c:choose>
    <c:when test="${sessionScope.USUARIO.tipo == 'a'}">
    <!-- SI SE ACCEDE MEDIANTE EL LOGUE DE UN USUARIO ADMINISTRADOR -->
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
                        <h2 style="color: #111;">Administraci&oacute;n</h2>
                    </div>
                    <div class="panel-body" style="background-color: #f2dede; height: 100%;">
                        <ul class="nav nav-tabs nav-justified">
                            <li class="nav-item active">
                                <a class="nav-link text-center" data-toggle="tab" href="#usuarios"><h4>Usuarios</h4></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-center" data-toggle="tab" href="#categorias"><h4>Categor&iacute;as</h4></a>
                            </li>
                        </ul>
                        <div class="tab-content" style="background-color: white; border-radius: 4px; border: 1px solid #ddd; border-top: 0; height: 90%;">
                            <!-- PARTE DE ADMINISTRACION DE USUARIOS -->
                            <div id="usuarios" class="tab-pane fade in active" style="margin: 3%; margin-top: 0;">
                                <h3 style="margin-top: 0; padding-top: 2%;">Usuarios</h3>
                                <table id="tablaUsuariosAdmin" class="table table-responsive" style="margin-top: 5%;">
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Email</th>
                                        <th>Bloqueado</th>
                                    </tr>
                                    <c:forEach var="u" items="${todosUsuarios}">
                                        <tr>
                                            <td>${u.nombre}</td>
                                            <td>${u.email}</td>
                                            <td><input type="checkbox" value="${u.idUsuario}" onchange="checkBloquearUsuario(this);" data-toggle="toggle" data-on="Sí" data-off="No" data-size="mini" <c:if test="${u.tipo == 'b'}">checked="checked"</c:if> /></td>
                                            </tr>
                                    </c:forEach>
                                </table><br/>
                                <button value="-1" onclick="checkBloquearUsuario(this);" class="btn btn-default">Bloquear todos</button>
                                <button value="-2" onclick="checkBloquearUsuario(this);" class="btn btn-default">Desbloquear todos</button>
                            </div>
                            <!-- PARTE DE ADMINISTRACION DE CATEGORIAS -->
                            <div id="categorias" class="tab-pane fade in" style="margin: 3%; margin-top: 0;">
                                <h3 style="margin-top: 0; padding-top: 2%;">Categor&iacute;as</h3>
                                <div id="tablaCategoriasAdmin" class="col-xs-6" style="margin-top: 3%; padding-right: 3%;">
                                    <c:forEach var="c" items="${todasCategorias}" varStatus="i">
                                        <div id="categoriaLista${i.count-1}" class="row" style="border-bottom: 1px solid #111; border-right: 1px solid #111; margin: 0; padding: 0;">                                
                                            <h4 class="col-xs-9">${c.nombre}</h4>
                                            <label class="col-xs-2" style="margin-top: 2%;">Eliminar</label><input class="col-xs-1" value="${c.idCategoria}" type="checkbox" class="form-control" style="margin-top: 2.5%;"/>
                                        </div>
                                    </c:forEach>
                                    <br/><br/>
                                    <button id="borrarCategorias" class="btn btn-default">Borrar seleccionados</button> 
                                </div>
                                <div class="col-xs-6" style="margin-top: 3%; padding-left: 3%;">  
                                    <dl>
                                        <dt>Nueva categor&iacute;a:</dt><br/>
                                        <dd>
                                            <input type="text" id="categoriaIntroducir" class="form-control" maxlength="15" placeholder="Introduzca la categoría." />
                                        </dd><br/><br/>
                                        <dd><button class="btn btn-default" id="anadirCategoria">Guardar categor&iacute;a</button></dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </c:when>
        <c:otherwise>
        <!-- SI SE ACCEDE DE CUALQUIER OTRA MANERA --><br/><br/><br/>
            <h1 class="text-center">Aqu&iacute; no hay naaada de naaaada.</h1><br/><br/><br/>
            <p class="text-center"><a href="index.jsp" class="btn btn-default">Volver a inicio</a></p>
        </c:otherwise>
    </c:choose>