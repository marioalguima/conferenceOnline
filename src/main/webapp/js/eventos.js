/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function() {
    if(document.getElementById("btnEntrar")!==null){
        document.getElementById("btnEntrar").addEventListener("click",eventoClickEntrar,false);
    }
    if(document.getElementById("btnRegistro")!==null){
        document.getElementById("btnRegistro").addEventListener("click",eventoClickRegistro,false);
    }
};

function eventoClickRegistro () {
    document.getElementById("inicioSesion").className = "tab-pane fade";
    document.getElementById("registro").className = "tab-pane fade in active";
    document.getElementById("CabInicioSesion").className = "";
    document.getElementById("CabRegistro").className = "active";
}

function eventoClickEntrar () {
    document.getElementById("inicioSesion").className = "tab-pane fade in active";
    document.getElementById("registro").className = "tab-pane fade";
    document.getElementById("CabInicioSesion").className = "active";
    document.getElementById("CabRegistro").className = "";
}