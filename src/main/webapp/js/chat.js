(function () {
    var publish_key = 'pub-c-39594782-c4b0-4fb3-80fe-74e262353bf6';
    var subscribe_key = 'sub-c-7ae61028-e9dd-11e3-92e7-02ee2ddab7fe';
    channel = document.getElementById("canal").value;
    var username = document.getElementById("nombreUsuario").value;
    pubnub = PUBNUB.init({
        publish_key: publish_key,
        subscribe_key: subscribe_key,
        uuid: username,
        ssl: (('https:' == document.location.protocol) ? true : false)
    });

    pubnub.subscribe({
        channel: channel,
        callback: function (message) {
            var mensaje = message.split(":", 2);
            if (mensaje[1].trim().length > 0) {
                $('#chatHistory')[0].innerHTML = "<p><b>" + mensaje[0] + ":</b>" + mensaje[1] + '</p>' + $('#chatHistory')[0].innerHTML;
            }
        }
    });

    pubnub.bind('click', pubnub.$('sendButton'), function (e) {
        pubnub.publish({
            channel: channel,
            message: pubnub.get_uuid() + ' : ' + $('#message').val()
        });
        $('#message').val('');
    });
})();