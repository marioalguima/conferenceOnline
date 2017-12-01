<%-- 
    Document   : index
    Created on : 07-nov-2017, 22:32:43
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="cabecera.jsp"/>

<c:choose>
    <c:when test="${sessionScope.USUARIO != null}">
        <!-- PANEL IZQUIERDO CASO DE USUARIO ANÓNIMO Y DE USUARIO REGISTRADO -->
        <div class="col-md-2" style="margin: 0; padding: 0; height: 100%; border-right: 1px solid white;">
            <jsp:include page="panelIzquierdo.jsp"/>
        </div>
        <div class="col-sm-12 col-md-10" style="margin: 0; padding: 0; height: 100%;">
        </c:when>
        <c:otherwise>
            <div style="margin: 0; padding: 0; height: 100%;">
            </c:otherwise>
        </c:choose>
        <!-- PARTE DEL CANAL -->
        <div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
            <div class="panel-heading row" style="margin: 0; padding-left: 3%; background-color: #d94442; border-radius: 0;">
                <!-- IMAGEN DE LA CABECERA -->
                <div class="col-md-1">
                    <div style="width: 62px; height: 62px; background-color: white; padding: 0; border: solid 1px #ffffff;">
                        <img class="img-responsive" type="image" src="
                             <c:choose>
                                 <c:when test="${requestScope.CANAL == null}">
                                     <c:choose>
                                         <c:when test="${sessionScope.USUARIO.getCanal().getImgUsuario() == null}">
                                             ${sessionScope.path}/img/logotipo_min.png
                                         </c:when>
                                         <c:otherwise>
                                             ${sessionScope.path}/img/${sessionScope.USUARIO.getCanal().getImgUsuario().getImagen()}
                                         </c:otherwise>
                                     </c:choose>
                                 </c:when>
                                 <c:when test="${requestScope.CANAL != null}">
                                     <c:choose>
                                         <c:when test="${requestScope.CANAL.getCanal().getImgUsuario() == null}">
                                             ${sessionScope.path}/img/logotipo_min.png
                                         </c:when>
                                         <c:otherwise>
                                             ${sessionScope.path}/img/${requestScope.CANAL.getCanal().getImgUsuario().getImagen()}
                                         </c:otherwise>
                                     </c:choose>
                                 </c:when>
                             </c:choose>" style="height: 100%; width: auto; margin: auto;" />
                    </div>
                </div>
                <!-- PARTE DEL NOMBRE DEL DUEÑO DEL CANAL -->
                <c:choose>
                    <c:when test="${requestScope.CANAL == null}">
                        <h2 class="col-md-9" style="color: #111;">Canal de ${sessionScope.USUARIO.nombre}</h2>
                    </c:when>
                    <c:when test="${requestScope.CANAL != null}">  
                        <h2 class="col-md-9" style="color: #111;">Canal de ${requestScope.CANAL.nombre}</h2>
                    </c:when>
                </c:choose>
                <!-- PARTE DEL BOTÓN PARA SUSCRIBIRSE O CANCELAR LA SUSCRIPCIÓN EN CASO DE USUARIO REGISTRADO VISITANDO CANAL AJENO -->
                <c:if test="${sessionScope.USUARIO != null && requestScope.CANAL != null && sessionScope.USUARIO.nombre != requestScope.CANAL.nombre}">
                    <h4 class="col-md-2 text-right" style="padding-right: 3%; margin: 0; margin-top: 2%; color: #ffffff;">
                        Suscrito:
                        <input id="cheqSuscrito" type="checkbox" data-toggle="toggle" data-on="Sí" data-off="No" data-size="mini"
                               <c:if test="${sessionScope.USUARIO.suscripciones != null && !sessionScope.USUARIO.suscripciones.isEmpty()}">
                                   <c:forEach var="u" items="${sessionScope.USUARIO.suscripciones}">
                                       <c:if test="${u.idUsuario == requestScope.CANAL.idUsuario}">
                                           checked
                                       </c:if>
                                   </c:forEach>
                               </c:if>
                               />
                        <input id="idUsuarioSeguir" type="hidden" name="idUsuarioSeguir" value="${requestScope.CANAL.idUsuario}"/>
                    </h4>    
                </c:if>
            </div>
            <!-- BODY DEL CANAL -->
            <div class="panel-body" style="background-color: #f2dede; height: 100%;">
                <c:choose>
                    <c:when test="${requestScope.CANAL == null}">
                        <h3 style="margin: 3%; margin-top: 1%;">${sessionScope.USUARIO.canal.titulo}</h3>
                    </c:when>
                    <c:when test="${requestScope.CANAL != null}">  
                        <h3 style="margin: 3%; margin-top: 1%;">${requestScope.CANAL.canal.titulo}</h3>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
