/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var emailAntiguo;
var passwordAntiguo;

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
    if (document.getElementById("menuCerrarSesion") !== null) {
        document.getElementById("menuCerrarSesion").onclick = eventoCerrarSesion;
    }
    if (document.getElementById("editarEmail") !== null) {
        document.getElementById("editarEmail").onclick = eventoClickEditarEmail;
    }
    if (document.getElementById("editarPassword") !== null) {
        document.getElementById("editarPassword").onclick = eventoClickEditarPassword;
    }
    if (document.getElementById("editarDescripcion") !== null) {
        document.getElementById("editarDescripcion").onclick = eventoClickEditarDescripcion;
    }
    if (document.getElementById("btnGuardarCambios") !== null) {
        document.getElementById("btnGuardarCambios").onclick = eventoClickGuardarCambios;
    }
    if (document.getElementById("btnGuardarCambiosCanal") !== null) {
        document.getElementById("btnGuardarCambiosCanal").onclick = eventoClickGuardarCambiosCanal;
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
    if (document.getElementById("desModCanal") !== null) {
        descripcionAntiguo = document.getElementById("desModCanal").value;
        document.getElementById("desModCanal").onblur = eventoPerdidaFocoDescripcionCanal;
    }
    if (document.getElementById("emailConfCuenta") !== null) {
        emailAntiguo = document.getElementById("emailConfCuenta").value;
        document.getElementById("emailConfCuenta").onblur = eventoPerdidaFocoEmailConfCuenta;
    }
    if (document.getElementById("passwordConfCuenta") !== null) {
        passwordAntiguo = document.getElementById("passwordConfCuenta").value;
        document.getElementById("passwordConfCuenta").onblur = eventoPerdidaFocoPasswordConfCuenta;
    }
    if (document.getElementById("repetidaConfCuenta") !== null) {
        document.getElementById("repetidaConfCuenta").onblur = eventoPerdidaFocoRepetidaConfCuenta;
    }
    if (document.getElementById("formLogin") !== null) {
        document.getElementById("formLogin").onsubmit = function () {
            return false;
        };
    }
    if (document.getElementById("formConfCuenta") !== null) {
        document.getElementById("formConfCuenta").onsubmit = function () {
            return false;
        };
    }
    if (document.getElementById("formConfCanal") !== null) {
        document.getElementById("formConfCanal").onsubmit = function () {
            return false;
        };
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
    if (nombreUsuario.length >= 3 && passwordLogin.length >= 3 && /[a-zA-Z0-9]*/.test(nombreUsuario) && /[a-zA-Z0-9]*/.test(passwordLogin)) {
        $.ajax({
            url: "ControlUsuario",
            type: "POST",
            data: {"peticion": "Entrar", "usuarioLogin": nombreUsuario, "passwordLogin": passwordLogin},
            success: function (respuesta) {
                if (respuesta === "notok") {
                    document.getElementById("errorLogin").innerHTML = "Nombre de usuario o contraseña incorrectos";
                } else {
                    document.getElementById("errorLogin").innerHTML = "";
                    location.reload(true);
                }
            }
        });
    }
}

function eventoClickGuardarCambios() {
    var email = document.getElementById("emailConfCuenta").value;
    var password = document.getElementById("passwordConfCuenta").value;
    var datos = null;
    if (email !== emailAntiguo && password !== passwordAntiguo) {
        datos = {"peticion": "modificarDatosCuenta", "email": email, "password": password};
    } else if (email !== emailAntiguo) {
        datos = {"peticion": "modificarDatosCuenta", "email": email, "password": ""};
    } else if (password !== passwordAntiguo) {
        datos = {"peticion": "modificarDatosCuenta", "email": "", "password": password};
    }
    if (datos !== null) {
        $.ajax({
            url: "ControlUsuario",
            type: "POST",
            data: datos,
            success: function (respuesta) {
                if (respuesta === "ok") {
                    alert("Los datos se han actualizado satisfactoriamente");
                } else {
                    alert("Ha ocurrido un error y no se han podido actualizar los datos");
                }
                location.reload(true);
            }
        });
    }
}

function eventoClickGuardarCambiosCanal() {
    var descripcion = document.getElementById("desModCanal").value;
    var datos = null;
    if (descripcion !== descripcionAntiguo) {
        datos = {"peticion": "modificarDatosCanal", "descripcion": descripcion};
    }
    if (datos !== null) {
        $.ajax({
            url: "ControlUsuario",
            type: "POST",
            data: datos,
            success: function (respuesta) {
                if (respuesta === "ok") {
                    alert("Los datos se han actualizado satisfactoriamente");
                } else {
                    alert("Ha ocurrido un error y no se han podido actualizar los datos");
                }
                location.reload(true);
            }
        });
    }
}

function eventoClickEditarDescripcion() {
    document.getElementById("desModCanal").disabled = false;
}

function eventoClickEditarEmail() {
    document.getElementById("emailConfCuenta").disabled = false;
    document.getElementById("errorEmailConfCuenta").style = "visibility: hidden";
    document.getElementById("mensajeErrorEmailConf").innerHTML = "";
}

function eventoClickEditarPassword() {
    document.getElementById("repetidaBloque").style = "display: inline";
    document.getElementById("repetidaConfCuenta").value = "";
    document.getElementById("passwordConfCuenta").disabled = false;
    document.getElementById("errorPasswordConfCuenta").style = "visibility: hidden";
    document.getElementById("mensajeErrorPasswordConf").innerHTML = "";
}

function eventoCerrarSesion() {
    $.ajax({
        url: "ControlUsuario",
        type: "POST",
        data: {"peticion": "cerrarSesion"},
        success: function(respuesta){
            if(respuesta === "ok"){
                location.href = "index.jsp";
            }
        }
    });    
}

function eventoPerdidaFocoDescripcionCanal() {
    var descripcion = document.getElementById("desModCanal").value;
    if(descripcion === descripcionAntiguo){
        document.getElementById("desModCanal").disabled = true;
    } else {
        document.getElementById("btnGuardarCambiosCanal").disabled = false;
    }
}

function eventoPerdidaFocoEmailConfCuenta() {
    var email = document.getElementById("emailConfCuenta").value;
    if (email === emailAntiguo) {
        document.getElementById("emailConfCuenta").disabled = true;
        document.getElementById("errorEmailConfCuenta").style = "visibility: hidden";
        if (document.getElementById("errorPasswordConfCuenta").className === "glyphicon glyphicon-ok text-success") {
            document.getElementById("btnGuardarCambios").disabled = false;
        } else {
            document.getElementById("btnGuardarCambios").disabled = true;
        }
    } else if (email.length >= 8 && /[a-zA-Z0-9_.]+@[a-zA-Z0-9]+[.][a-zA-Z]{1,5}/.test(email)) {
        $.ajax({
            url: "ControlUsuario",
            type: "POST",
            data: {"peticion": "comprobarEmailRegistro", "email": email},
            success: function (respuesta) {
                if (respuesta === "ok") {
                    document.getElementById("errorEmailConfCuenta").className = "glyphicon glyphicon-ok text-success";
                    document.getElementById("errorEmailConfCuenta").style = "visibility: visible";
                    document.getElementById("mensajeErrorEmailConf").innerHTML = "";
                    document.getElementById("btnGuardarCambios").disabled = false;
                } else {
                    document.getElementById("errorEmailConfCuenta").className = "glyphicon glyphicon-remove text-danger col-sm-1";
                    document.getElementById("errorEmailConfCuenta").style = "visibility: visible";
                    document.getElementById("mensajeErrorEmailConf").innerHTML = "Ese email está en uso, utilice otro email.";
                    document.getElementById("btnGuardarCambios").disabled = true;
                }
            }
        });
    } else {
        document.getElementById("emailConfCuenta").value = emailAntiguo;
        document.getElementById("emailConfCuenta").disabled = true;
        document.getElementById("errorEmailConfCuenta").className = "glyphicon glyphicon-remove text-danger";
        document.getElementById("errorEmailConfCuenta").style = "visibility: visible";
        document.getElementById("mensajeErrorEmailConf").innerHTML = "El email no es válido, introduzca un email con un formato correcto.";
        document.getElementById("btnGuardarCambios").disabled = true;
    }
}

function eventoPerdidaFocoPasswordConfCuenta() {
    var password = document.getElementById("passwordConfCuenta").value;
    if (password === passwordAntiguo) {
        document.getElementById("repetidaBloque").style = "display: none";
        document.getElementById("passwordConfCuenta").disabled = true;
        if (document.getElementById("errorEmailConfCuenta").className === "glyphicon glyphicon-ok text-success") {
            document.getElementById("btnGuardarCambios").disabled = false;
        } else {
            document.getElementById("btnGuardarCambios").disabled = true;
        }
    } else if (!(password.length >= 3 && /[a-zA-Z0-9]*/.test(password))) {
        document.getElementById("repetidaBloque").style = "display: none";
        document.getElementById("passwordConfCuenta").disabled = true;
        document.getElementById("passwordConfCuenta").value = passwordAntiguo;
        document.getElementById("errorPasswordConfCuenta").className = "glyphicon glyphicon-remove text-danger";
        document.getElementById("errorPasswordConfCuenta").style = "visibility: visible";
        document.getElementById("mensajeErrorPasswordConf").innerHTML = "La contraseña no es válida, introduzca una contraseña con un formato correcto.";
        document.getElementById("btnGuardarCambios").disabled = true;
    }
}

function eventoPerdidaFocoRepetidaConfCuenta() {
    var password = document.getElementById("passwordConfCuenta").value;
    var repetida = document.getElementById("repetidaConfCuenta").value;
    if (password === repetida) {
        document.getElementById("errorPasswordConfCuenta").className = "glyphicon glyphicon-ok text-success";
        document.getElementById("errorPasswordConfCuenta").style = "visibility: visible";
        document.getElementById("mensajeErrorPasswordConf").innerHTML = "";
        document.getElementById("btnGuardarCambios").disabled = false;
    } else {
        document.getElementById("errorPasswordConfCuenta").className = "glyphicon glyphicon-remove text-danger";
        document.getElementById("errorPasswordConfCuenta").style = "visibility: visible";
        document.getElementById("mensajeErrorPasswordConf").innerHTML = "Las contraseñas no coinciden.";
        document.getElementById("repetidaConfCuenta").value = "";
        document.getElementById("repetidaBloque").style = "display: none";
        document.getElementById("btnGuardarCambios").disabled = true;
    }
}

function eventoPerdidaFocoUsuarioRegistro() {
    var nombreUsuario = document.getElementById("usuarioRegistro").value;
    if (nombreUsuario.length >= 3) {
        $.ajax({
            url: "ControlUsuario",
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
            url: "ControlUsuario",
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