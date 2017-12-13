<%-- 
    Document   : index
    Created on : 07-nov-2017, 22:32:43
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="categorias" class="es.albarregas.beans.Categoria" scope="page"/>
<jsp:useBean id="directos" class="es.albarregas.beans.Directo" scope="page"/>
<c:set var="todasCategorias" scope="page" value="${pageScope.categorias.getCategorias()}"/>
<jsp:include page="cabecera.jsp"/>

<!-- AÑADE EL PANEL IZQUIERDO EN CASO DE QUE EL USUARIO HAYA INICIADO SESIÓN -->
<c:choose>
    <c:when test="${sessionScope.USUARIO != null}">
        <div class="col-xs-2" style="margin: 0; padding: 0; height: 100%; border-right: 1px solid white;">
            <jsp:include page="panelIzquierdo.jsp"/>
        </div>
        <div class="col-xs-10" style="margin: 0; padding: 0; height: 100%;">
        </c:when>
        <c:otherwise>
            <div style="margin: 0; padding: 0; height: 100%;">
            </c:otherwise>
        </c:choose>
        <!-- PARTE DEL TÍTULO DEL ÍNDICE -->
        <div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
            <div class="panel-heading" style="padding-left: 5%; background-color: #d94442; border-radius: 0;">
                <h2 style="color: #111;">Actualmente en directo</h2>
            </div>
            <!-- LISTA DE LAS DISTINTAS CATEGORÍAS -->
            <div class="panel-body" style="background-color: #f2dede; height: 100%;">
                <ul class="nav nav-tabs nav-justified">
                    <c:forEach var="c" items="${todasCategorias}" varStatus="i">
                        <li class="nav-item <c:if test="${i.first}">active</c:if>">
                            <a class="nav-link text-center" data-toggle="tab" href="#categoria${c.idCategoria}"><h4>${c.nombre}</h4></a>
                        </li>
                    </c:forEach>
                </ul>
                <div class="tab-content" style="background-color: white; border-radius: 4px; border: 1px solid #ddd; border-top: 0; height: 90%;">
                    <c:forEach var="c" items="${todasCategorias}" varStatus="i">
                        <div id="categoria${c.idCategoria}" class="tab-pane fade in <c:if test="${i.first}">active</c:if>" style="margin: 3%; margin-top: 0;">
                            <h3 style="margin-top: 0; padding-top: 2%; padding-bottom: 3%;">Directos de ${c.nombre}</h3>
                            <c:if test="${pageScope.directos.getDirectosCategoria(c.idCategoria).isEmpty()}">
                                <h4>No hay directos de esta categor&iacute;a en este momento.</h4>
                            </c:if>
                            <c:forEach var="d" items="${pageScope.directos.getDirectosCategoria(c.idCategoria)}">
                                <c:if test="${d.usuario.idUsuario != sessionScope.USUARIO.idUsuario}">
                                    <div class="row col-xs-3" style="margin-bottom: 1%;">
                                        <div class="col-xs-4"></div>
                                        <div class="col-xs-4">
                                            <a href="${sessionScope.path}/ControlPeticion?peticion=canal&idUsuario=${d.usuario.idUsuario}">
                                                <div style="height: 100px; width: 100px; padding: 1%; background-color: white; margin: auto; border: 2px solid #d94442;">
                                                    <img class="img-responsive" src="<c:choose>
                                                             <c:when test="${d.usuario.getCanal().getImgUsuario() == null}">
                                                                 ${sessionScope.path}/img/logotipo_min.png
                                                             </c:when>
                                                             <c:otherwise>
                                                                 ${sessionScope.path}/img/${d.usuario.getCanal().getImgUsuario().getImagen()}
                                                             </c:otherwise>
                                                         </c:choose>" style="height: 100%; width: auto; margin: auto; padding: 0; border: 1px solid white;">
                                                </div>
                                                <h4 class="text-center">${d.usuario.nombre}</h4>
                                            </a>
                                        </div>
                                        <div class="col-xs-4"></div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>