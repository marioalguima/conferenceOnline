<%-- 
    Document   : index
    Created on : 07-nov-2017, 22:32:43
    Author     : Mario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="categorias" class="es.albarregas.beans.Categoria" scope="page"/>
<c:set var="todasCategorias" scope="page" value="${pageScope.categorias.getCategorias()}"/>
<jsp:include page="cabecera.jsp"/>

<c:choose>
    <c:when test="${sessionScope.USUARIO != null}">
        <!-- PANEL IZQUIERDO CASO DE USUARIO ANÓNIMO Y DE USUARIO REGISTRADO -->
        <div class="col-xs-2" style="margin: 0; padding: 0; height: 100%; border-right: 1px solid white;">
            <jsp:include page="panelIzquierdo.jsp"/>
        </div>
        <div class="col-xs-10" style="margin: 0; padding: 0; height: 100%;">
        </c:when>
        <c:otherwise>
            <div style="margin: 0; padding: 0; height: 100%;">
            </c:otherwise>
        </c:choose>
        <!-- PARTE DEL CANAL -->
        <div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
            <div class="panel-heading row" style="margin: 0; padding-left: 3%; background-color: #d94442; border-radius: 0;">
                <!-- IMAGEN DE LA CABECERA -->
                <div class="col-xs-1">
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
                        <h2 class="col-xs-9" style="color: #111;">Canal de ${sessionScope.USUARIO.nombre}</h2>
                    </c:when>
                    <c:when test="${requestScope.CANAL != null}">  
                        <h2 class="col-xs-9" style="color: #111;">Canal de ${requestScope.CANAL.nombre}</h2>
                    </c:when>
                </c:choose>
                <!-- PARTE DEL BOTÓN PARA SUSCRIBIRSE O CANCELAR LA SUSCRIPCIÓN EN CASO DE USUARIO REGISTRADO VISITANDO CANAL AJENO -->
                <c:if test="${sessionScope.USUARIO != null && requestScope.CANAL != null && sessionScope.USUARIO.nombre != requestScope.CANAL.nombre && sessionScope.USUARIO.tipo != 'a'}">
                    <h4 class="col-xs-2 text-right" style="padding-right: 3%; margin: 0; margin-top: 2%; color: #ffffff;">
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
            <div class="panel-body" style="background-color: #f2dede; height: 100%; overflow-y: scroll;">
                <div class="row" style='padding-right: 2%;'>
                    <c:choose>
                        <c:when test="${requestScope.CANAL == null}">
                            <h3 style="margin-left: 3%; margin-top: 1%; margin-bottom: 1.5%;">${sessionScope.USUARIO.canal.titulo}</h3>
                        </c:when>
                        <c:when test="${requestScope.CANAL != null}">  
                            <h3 style="margin-left: 3%; margin-top: 1%; margin-bottom: 1.5%;">${requestScope.CANAL.canal.titulo}</h3>
                        </c:when>
                    </c:choose>
                    <div class="col-xs-8" style="padding-left: 5%; padding-bottom: 5%;">
                        <div id="vid-box" style="background-color: black; width: 640px; height: 480px;"><!-- Stream goes here --></div>

                        <c:choose>
                            <c:when test="${requestScope.CANAL == null}">                                
                                <form class="form-inline" name="streamForm" id="stream" action="#" onsubmit="return stream(this);">
                                    <input type="hidden" name="streamname" id="streamname" value="${sessionScope.USUARIO.nombre}" />
                                    <input type="hidden" name="streamIdUsuario" id="streamIdUsuario" value="${sessionScope.USUARIO.idUsuario}" /><br/>
                                    <label for="categoriaElegida">Elija una categor&iacute;a para el directo: </label><br/>
                                    <select id="categoriaElegida" name="categoriaElegida" class="form-control">
                                        <option value="-1" selected>Elija una categor&iacute;a</option>
                                        <c:forEach var="c" items="${todasCategorias}">
                                            <option value="${c.idCategoria}">${c.nombre}</option>
                                        </c:forEach> 
                                    </select>
                                    <div id="stream-info" style="visibility: hidden; padding-right: 10%;"><h4>Espectadores <span class="glyphicon glyphicon-user"></span> <span id="here-now">0</span></h4></div>
                                    <input id="iniciarDirecto" class="btn btn-default" type="submit" name="stream_submit" value="Iniciar directo"> 
                                </form><br/>
                                <div id="inStream">
                                    <button class="btn btn-default" id="end" onclick="end()" style="visibility: hidden;">Finalizar directo</button> <br>
                                </div><br/>                     
                                <c:if test="${!sessionScope.USUARIO.canal.descripcion.isEmpty()}">
                                    <div class="panel panel-default" style="width: 640px; border-radius: 0;">                                        
                                        <div class="panel-body">
                                            <h4>Descripci&oacute;n del canal:</h4>
                                            <p>${sessionScope.USUARIO.canal.descripcion}</p>
                                        </div>
                                    </div>
                                </c:if>
                            </c:when>
                            <c:when test="${requestScope.CANAL != null}">
                                <form name="watchForm" id="watch" onsubmit="return watch(this);">
                                    <input id="canalAVer" type="hidden" name="number" value="${requestScope.CANAL.nombre}"/>   
                                    <input id="idUsuarioVer" type="hidden" name="idUsuarioVer" value="${requestScope.CANAL.idUsuario}"/>
                                    <div id="stream-info" style="visibility: hidden; padding-right: 10%;"><h4>Espectadores <span class="glyphicon glyphicon-user"></span> <span id="here-now">0</span></h4></div>
                                </form><br/>
                                <c:if test="${!requestScope.CANAL.canal.descripcion.isEmpty()}">
                                    <div class="panel panel-default" style="width: 640px; border-radius: 0;">                                        
                                        <div class="panel-body">
                                            <h4>Descripci&oacute;n del canal:</h4>                                        
                                            <p>${requestScope.CANAL.canal.descripcion}</p>
                                        </div>
                                    </div>
                                </c:if>
                            </c:when>
                        </c:choose>
                    </div>
                    <!-- PARTE DEL CHAT -->
                    <div class="col-xs-4" style="background-color: white; border: 2px solid #d94442; height: 100%; padding-top: 1%;">

                        <div id="chatHistory" style="height: 500px; overflow-y: scroll;">
                        </div>

                        <div class="row" style="padding: 2%; border-top: solid 1px #ccc;">
                            <div class="col-xs-10" style="padding: 0;">
                                <input class="form-control" type="text" id="message" placeholder="Enviar un mensaje" <c:if test="${sessionScope.USUARIO.tipo != 'n'}">disabled</c:if> style="border-radius: 4px 0 0 4px;">
                                <input type="hidden" id="nombreUsuario" value="${sessionScope.USUARIO.nombre}"/>
                                <c:choose>
                                    <c:when test="${requestScope.CANAL == null}">
                                        <input type="hidden" id="canal" value="${sessionScope.USUARIO.nombre}"/>
                                    </c:when>
                                    <c:when test="${requestScope.CANAL != null}">
                                        <input type="hidden" id="canal" value="${requestScope.CANAL.nombre}"/>
                                    </c:when>
                                </c:choose>
                            </div>
                            <button id="sendButton" class="btn btn-default col-xs-2" <c:if test="${sessionScope.USUARIO.tipo != 'n'}">disabled</c:if> style="border-radius: 0 4px 4px 0; border-left: 0;">Enviar</button>
                            </div>
                        </div>
                    </div>
                <script type="text/javascript" src="${sessionScope.path}/js/chat.js"></script>
                <script type="text/javascript" src="${sessionScope.path}/js/directo.js"></script>
            </div>
        </div>
    </div>
