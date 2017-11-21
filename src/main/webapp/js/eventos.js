/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    if (document.getElementById("btnEntrar") !== null) {
        document.getElementById("btnEntrar").onclick = eventoClickEntrar;
    }
    if (document.getElementById("btnRegistro") !== null) {
        document.getElementById("btnRegistro").onclick = eventoClickRegistro;
    }
    if (document.getElementById("btnIniciarSesion") !== null) {
        document.getElementById("btnIniciarSesion").onclick = eventoClickLogin;
    }
    if (document.getElementById("usuarioRegistro") !== null) {
        document.getElementById("usuarioRegistro").onblur = eventoPerdidaFocoUsuarioRegistro;
    }
    if (document.getElementById("emailRegistro") !== null) {
        document.getElementById("emailRegistro").onblur = eventoPerdidaFocoEmailRegistro;
    }
    if (document.getElementById("passwordRegistro") !== null) {
        document.getElementById("passwordRegistro").onblur = eventoPerdidaFocoPasswordRegistro;
    }
    if (document.getElementById("passwordRepetida") !== null) {
        document.getElementById("passwordRepetida").onblur = eventoPerdidaFocoRepetidaRegistro;
    }
    if(document.getElementById("formLogin") !== null) {
        document.getElementById("formLogin").onsubmit = function(){ return false; };
    }
};

function eventoClickRegistro() {
    document.getElementById("inicioSesion").className = "tab-pane fade";
    document.getElementById("registro").className = "tab-pane fade in active";
    document.getElementById("CabInicioSesion").className = "";
    document.getElementById("CabRegistro").className = "active";
}

function eventoClickEntrar() {
    document.getElementById("inicioSesion").className = "tab-pane fade in active";
    document.getElementById("registro").className = "tab-pane fade";
    document.getElementById("CabInicioSesion").className = "active";
    document.getElementById("CabRegistro").className = "";
}

function eventoClickLogin() {
    var nombreUsuario = document.getElementById("usuarioLogin").value;
    var passwordLogin = document.getElementById("passwordLogin").value;
    if(nombreUsuario.length >= 3 && passwordLogin.length >= 3 && /[a-zA-Z0-9]*/.test(nombreUsuario) && /[a-zA-Z0-9]*/.test(passwordLogin)){
        $.ajax({
            url: "RegistroLogin",
            type: "POST",
            data: {"peticion": "Entrar", "usuarioLogin": nombreUsuario, "passwordLogin": passwordLogin},
            success: function (respuesta) {
                if (respuesta === "notok") {
                    document.getElementById("errorLogin").innerHTML = "Nombre de usuario o contraseña incorrectos";
                }else{
                    document.getElementById("errorLogin").innerHTML = "";
                    location.reload(true);
                }
            }
        });
    }
}

function eventoPerdidaFocoUsuarioRegistro() {
    var nombreUsuario = document.getElementById("usuarioRegistro").value;
    if (nombreUsuario.length >= 3) {
        $.ajax({
            url: "RegistroLogin",
            type: "POST",
            data: {"peticion": "comprobarNombreRegistro", "nombre": nombreUsuario},
            success: function (respuesta) {
                if (respuesta === "ok") {
                    document.getElementById("errorNombreRegistro").className = "glyphicon glyphicon-ok text-success col-sm-1";
                    document.getElementById("errorNombreRegistro").style = "visibility: visible";
                    document.getElementById("errorRegistro").innerHTML = "";
                    document.getElementById("btnRegistrarse").disabled = false;
                } else {
                    document.getElementById("errorNombreRegistro").className = "glyphicon glyphicon-remove text-danger col-sm-1";
                    document.getElementById("errorNombreRegistro").style = "visibility: visible";
                    document.getElementById("errorRegistro").innerHTML = "Ese nombre está en uso, elija otro nombre.";
                    document.getElementById("btnRegistrarse").disabled = true;
                }
            }
        });
    } else {
        document.getElementById("errorNombreRegistro").style = "visibility: hidden";
    }
}

function eventoPerdidaFocoEmailRegistro() {
    var email = document.getElementById("emailRegistro").value;
    if (email.length >= 8 && /[a-zA-Z0-9_.]+@[a-zA-Z0-9]+[.][a-zA-Z]{1,5}/.test(email)) {
        $.ajax({
            url: "RegistroLogin",
            type: "POST",
            data: {"peticion": "comprobarEmailRegistro", "email": email},
            success: function (respuesta) {
                if (respuesta === "ok") {
                    document.getElementById("errorEmailRegistro").className = "glyphicon glyphicon-ok text-success col-sm-1";
                    document.getElementById("errorEmailRegistro").style = "visibility: visible";
                    document.getElementById("errorRegistro").innerHTML = "";
                    document.getElementById("btnRegistrarse").disabled = false;
                } else {
                    document.getElementById("errorEmailRegistro").className = "glyphicon glyphicon-remove text-danger col-sm-1";
                    document.getElementById("errorEmailRegistro").style = "visibility: visible";
                    document.getElementById("errorRegistro").innerHTML = "Ese email está en uso, utilice otro email.";
                    document.getElementById("btnRegistrarse").disabled = true;
                }
            }
        });
    } else {
        document.getElementById("errorEmailRegistro").style = "visibility: hidden";
    }
}

function eventoPerdidaFocoPasswordRegistro() {
    var password = document.getElementById("passwordRegistro").value;
    if (password.length >= 3) {
        document.getElementById("passwordRepetida").disabled = false;
    } else {
        document.getElementById("passwordRepetida").value = "";
        document.getElementById("passwordRepetida").disabled = true;
    }
}

function eventoPerdidaFocoRepetidaRegistro() {
    var password = document.getElementById("passwordRegistro").value;
    var repetida = document.getElementById("passwordRepetida").value;
    if (password === repetida) {
        document.getElementById("errorPasswordRegistro").className = "glyphicon glyphicon-ok text-success col-sm-1";
        document.getElementById("errorPasswordRegistro").style = "visibility: visible";
        document.getElementById("errorRegistro").innerHTML = "";
        document.getElementById("btnRegistrarse").disabled = false;
    } else {
        document.getElementById("errorPasswordRegistro").className = "glyphicon glyphicon-remove text-danger col-sm-1";
        document.getElementById("errorPasswordRegistro").style = "visibility: visible";
        document.getElementById("errorRegistro").innerHTML = "Las contraseñas no coinciden.";
        document.getElementById("btnRegistrarse").disabled = true;
    }
}