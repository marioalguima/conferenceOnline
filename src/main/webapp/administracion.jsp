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
                        <table class="table table-striped" style="margin-top: 5%;">
                            <tr>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Bloquear</th>
                            </tr>
                        <c:forEach var="u" items="${todosUsuarios}">
                            <tr>                                
                                <td>${u.nombre}</td>
                                <td>${u.email}</td>
                                <td><input class="col-xs-1" type="checkbox" class="form-control"/></td>
                            </tr>
                        </c:forEach>
                        </table><br/>
                        <button id="borrarCategorias" class="btn btn-default">Borrar</button>
                    </div>
                    <!-- PARTE DE ADMINISTRACION DE CATEGORIAS -->
                    <div id="categorias" class="tab-pane fade in" style="margin: 3%; margin-top: 0;">
                        <h3 style="margin-top: 0; padding-top: 2%;">Categor&iacute;as</h3>
                        <div class="col-xs-6" style="margin-top: 3%; padding-right: 3%;">
                        <c:forEach var="c" items="${todasCategorias}">
                            <div class="row" style="border-bottom: 1px solid #111; border-right: 1px solid #111; margin: 0; padding: 0;">                                
                                <h4 class="col-xs-9">${c.nombre}</h4>
                                <label class="col-xs-2" style="margin-top: 2%;">Eliminar</label><input class="col-xs-1" type="checkbox" class="form-control" style="margin-top: 2.5%;"/>
                            </div>
                        </c:forEach>
                            <br/><br/>
                            <button id="borrarCategorias" class="btn btn-default">Borrar seleccionados</button> 
                        </div>
                        <div class="col-xs-6" style="margin-top: 5%;">                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>