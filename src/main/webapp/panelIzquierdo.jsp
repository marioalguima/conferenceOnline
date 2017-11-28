<%-- 
    Document   : panelIzquierdo
    Created on : 24-nov-2017, 12:52:09
    Author     : Mario
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="panel panel-default" style="border-radius: 0; margin: 0; padding: 0; border: 0; height: 100%;">
    <div class="panel-heading" style="padding-left: 10%; background-color: #050505; border-radius: 0; ">
        <h2 style="color: #ffffff;">Bienvenido</h2>
    </div>
    <div class="panel-body" style="background-color: #909090; height: 100%; padding-left: 0; padding-right: 0;">
        <ul class="list-unstyled" style="margin-left: 8%;">
            <li><h4><span class="glyphicon glyphicon-home" style="margin-right: 3%;"></span><a href="${sessionScope.path}/index.jsp" style="color: #000;">Inicio</a></h4></li>
            <li><h4><span class="glyphicon glyphicon-film" style="margin-right: 3%;"></span><a href="${sessionScope.path}/canal.jsp" style="color: #000;">Mi canal</a></h4></li>
            <li><h4><span class="glyphicon glyphicon-user" style="margin-right: 3%;"></span><a href="${sessionScope.path}/configuracionCuenta.jsp" style="color: #000;">Configuraci&oacute;n</a></h4></li>
        </ul><br/>
        <div style="background-color: #050505; text-align: center;">
            <h4 style="color: #ffffff; padding-top: 3%; padding-bottom: 3%; border-bottom: 1px solid white; border-top: 1px solid white;">Gente a la que sigues</h4>
        </div><br/>
        <ul class="list-unstyled" style="margin-left: 5%; margin-right: 4%;">
            <c:choose>
                <c:when test="${sessionScope.USUARIO.suscripciones == null || sessionScope.USUARIO.suscripciones.isEmpty()}">
                    <li>A&uacute;n no sigues a nadie.</li>
                </c:when>
                <c:when test="${sessionScope.USUARIO.suscripciones != null && !sessionScope.USUARIO.suscripciones.isEmpty()}">
                    <c:forEach var="u" items="${sessionScope.USUARIO.suscripciones}">
                    <li class="row" style="background-color: #252525; padding: 2%; margin:0; margin-bottom: 2%; border: 1px solid white;">
                        <a href="${sessionScope.path}/ControlPeticion?peticion=canal&nombre=${u.nombre}">
                            <div class="col-xs-4" style="height: 35px; width: 35px; padding: 0; background-color: white;">
                            <img class="img-responsive" src="<c:choose>
                                             <c:when test="${u.getCanal().getImgUsuario() == null}">
                                                 ${sessionScope.path}/img/logotipo_min.png
                                             </c:when>
                                             <c:otherwise>
                                                 ${sessionScope.path}/img/${u.getCanal().getImgUsuario().getImagen()}
                                             </c:otherwise>
                                         </c:choose>" style="height: 100%; width: auto; margin: auto; padding: 0; border: 1px solid white;">
                            </div>
                            <h4 class="col-xs-8" style="color: #ffffff; margin: 0; padding: 0; margin-top: 4%; margin-left: 5%;">${u.nombre}</h4>
                        </a>
                    </li>
                    </c:forEach>
                </c:when>
            </c:choose>
        </ul>

    </div>
</div>