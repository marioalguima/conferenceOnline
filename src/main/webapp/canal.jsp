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
                <div class="row">
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
                                <form name="streamForm" id="stream" action="#" onsubmit="return stream(this);">
                                    <input type="hidden" name="streamname" id="streamname" value="${sessionScope.USUARIO.nombre}" />
                                    <div id="stream-info" style="visibility: hidden; padding-right: 10%;"><h4>Espectadores <span class="glyphicon glyphicon-user"></span> <span id="here-now">0</span></h4></div>
                                    <input id="iniciarDirecto" class="btn btn-default" type="submit" name="stream_submit" value="Iniciar directo"> 
                                </form><br/>
                                <div id="inStream">
                                    <button class="btn btn-default" id="end" onclick="end()" style="visibility: hidden;">Finalizar directo</button> <br>
                                </div><br/>                                
                                <c:if test="${!sessionScope.USUARIO.canal.descripcion.isEmpty()}">
                                    <h4>Descripci&oacute;n del canal:</h4>
                                    <p>${sessionScope.USUARIO.canal.descripcion}</p>
                                </c:if>
                            </c:when>
                            <c:when test="${requestScope.CANAL != null}">
                                <form name="watchForm" id="watch" onsubmit="return watch(this);">
                                    <input id="canalAVer" type="hidden" name="number" value="${requestScope.CANAL.nombre}"/>                                    
                                    <div id="stream-info" style="visibility: hidden; padding-right: 10%;"><h4>Espectadores <span class="glyphicon glyphicon-user"></span> <span id="here-now">0</span></h4></div>
                                </form><br/><br/>
                                <c:if test="${!requestScope.CANAL.canal.descripcion.isEmpty()}">
                                    <h4>Descripci&oacute;n del canal:</h4>
                                    <p>${requestScope.CANAL.canal.descripcion}</p>
                                </c:if>
                            </c:when>
                        </c:choose>

                    </div>
                </div>
                <script type="text/javascript">

                    var video_out = document.getElementById("vid-box");
                    var embed_code = document.getElementById("embed-code");
                    var here_now = document.getElementById('here-now');
                    var stream_info = document.getElementById('stream-info');
                    var end_stream = document.getElementById('end');

                    var streamName;

                    function stream(form) {
                        streamName = form.streamname.value || Math.floor(Math.random() * 100) + '';
                        var phone = window.phone = PHONE({
                            number: streamName, // listen on username line else random
                            publish_key: 'pub-c-561a7378-fa06-4c50-a331-5c0056d0163c', // Your Pub Key
                            subscribe_key: 'sub-c-17b7db8a-3915-11e4-9868-02ee2ddab7fe', // Your Sub Key
                            oneway: true,
                            broadcast: true,
                            ssl: (('https:' == document.location.protocol) ? true : false)
                        });
                        var ctrl = window.ctrl = CONTROLLER(phone);
                        ctrl.ready(function () {
                            form.streamname.style.background = "#55ff5b";
                            form.streamname.value = phone.number();
                            ctrl.addLocalStream(video_out);
                            ctrl.stream();
                            video_out.style = "background-color: black; width: 640px; height: 480px;";
                            video_out.className = "embed-responsive-item";
                            stream_info.style.visibility = "visible";
                            end_stream.style.visibility = "visible";
                            document.getElementById("iniciarDirecto").style.display = "none";
                        });
                        ctrl.receive(function (session) {
                            session.ended(function (session) {
                                console.log(session)
                            });
                        });
                        ctrl.streamPresence(function (m) {
                            here_now.innerHTML = m.occupancy;
                        });
                        return false;
                    }

                    function watch(form) {
                        var num = form.number.value;
                        var phone = window.phone = PHONE({
                            number: "Viewer" + Math.floor(Math.random() * 100), // listen on username line else random
                            publish_key: 'pub-c-561a7378-fa06-4c50-a331-5c0056d0163c', // Your Pub Key
                            subscribe_key: 'sub-c-17b7db8a-3915-11e4-9868-02ee2ddab7fe', // Your Sub Key
                            oneway: true,
                            ssl: (('https:' == document.location.protocol) ? true : false)
                        });
                        var ctrl = window.ctrl = CONTROLLER(phone);
                        ctrl.ready(function () {
                            ctrl.isStreaming(num, function (isOn) {
                                if (isOn)
                                    ctrl.joinStream(num);
                                else
                                    alert("El usuario no está en directo en este momento.");
                            });
                        });
                        ctrl.receive(function (session) {
                            session.connected(function (session) {
                                video_out.appendChild(session.video);
                                video_out.style = "background-color: black; width: 640px; height: 480px;";
                                video_out.className = "embed-responsive-item";
                                video_out.lastChild.setAttribute("controls", "true");
                                stream_info.style.visibility = "visible";
                            });
                        });
                        ctrl.streamPresence(function (m) {
                            here_now.innerHTML = m.occupancy;
                        });
                        return false;
                    }
                    function end() {
                        if (!window.phone) {
                            return;
                        }
                        ctrl.hangup();
                        video_out.innerHTML = "";
                        location.reload();
                    }
                </script>
            </div>
        </div>
    </div>
