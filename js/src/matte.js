// Genie WebChannels functions
Matte.WebSockets = {}
Matte.load_channels = function(vue_instance) {
  var socket = new WebSocket('ws://' + Matte.Settings.server_host + ':' + Matte.Settings.websockets_port);
  Matte.WebSockets.socket = socket;
  Matte.WebSockets.sendMessageTo = sendMessageTo;
  Matte.vue_instance = vue_instance;

  window.addEventListener('beforeunload', function (event) {
    Matte.vue_instance.matte_notconnected_overlay = true;
    if (Matte.WebSockets.socket.readyState === 1) {
      Matte.WebSockets.socket.close();
    }
  });

  socket.addEventListener('open', function(event) {
    Matte.set_ready(Matte.vue_instance);
  });

  socket.addEventListener('message', function(event) {
    try {
      if (event.data.startsWith('{') && event.data.endsWith('}')) {
        response = JSON.parse(event.data)
        Matte.vue_instance.update_model(response)
      } else {
        console.log(event.data);
      }
    } catch (ex) {
      console.log(ex);
    }
  });

  socket.addEventListener('error', function(event) {
    console.log(event.data)
  });

  socket.addEventListener('close', function(event) {
    console.log("Server closed WebSocket connection");
    Matte.vue_instance.matte_notconnected_overlay = true;
  });

  function sendMessageTo(channel, message, payload = {}) {
    if (socket.readyState === 1) {
      socket.send(JSON.stringify({
        'channel': channel,
        'message': message,
        'payload': payload
      }));
    }
  }
};

// Matte.jl functions
Matte.set_ready = function(vue_instance) {
  if (document.readyState === "complete" || document.readyState === "interactive") {
    vue_instance.on_connected()
  } else {
    setTimeout(set_ready, 1000, vue_instance);
  }
}

Matte.request_update = function(id, inputs) {
  Matte.WebSockets.sendMessageTo('matte', 'api', {
      'id': id,
      'input': inputs,
      'session_id': window.session_id
  });
}
