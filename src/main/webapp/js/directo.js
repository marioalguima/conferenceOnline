
var video_out = document.getElementById("vid-box");
var embed_code = document.getElementById("embed-code");
var here_now = document.getElementById('here-now');
var stream_info = document.getElementById('stream-info');
var end_stream = document.getElementById('end');

var streamName;

function stream(form) {
    if (document.getElementById("categoriaElegida").value !== null && document.getElementById("categoriaElegida").value !== "-1") {
        $.ajax({
            url: "ControlPeticion",
            type: "POST",
            data: {"peticion": "iniciarDirecto", "usuario": document.getElementById("streamIdUsuario").value, "categoria": document.getElementById("categoriaElegida").value},
            success: function (respuesta) {
                if (respuesta === "ok") {
                    alert("Directo iniciado");
                }
            }
        });
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
    } else {
        alert("Debe elegir una categoría");
    }
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
            if (isOn) {
                ctrl.joinStream(num);
            } else {
                $.ajax({
                    url: "ControlPeticion",
                    type: "POST",
                    data: {"peticion": "finalizarDirecto", "usuario": document.getElementById("idUsuarioVer").value}
                });
                alert("El usuario no está en directo en este momento.");
            }
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
    $.ajax({
        url: "ControlPeticion",
        type: "POST",
        data: {"peticion": "finalizarDirecto", "usuario": document.getElementById("streamIdUsuario").value},
        success: function (respuesta) {
            if (respuesta === "ok") {
                alert("Directo finalizado.");
            }
        }
    });
    if (!window.phone) {
        return;
    }
    ctrl.hangup();
    video_out.innerHTML = "";
    location.reload();
}
         