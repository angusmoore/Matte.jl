var Settings = require('./config.js');

var Matte = {};

Matte.WebSockets = {}
Matte.load_channels = function(vue_instance) {
  var socket = new WebSocket('ws://' + Settings.server_host + ':' + Settings.websockets_port);
  Matte.WebSockets.socket = socket;
  Matte.WebSockets.sendMessageTo = sendMessageTo;
  Matte.vue_instance = vue_instance;

  window.addEventListener('beforeunload', function () {
    Matte.vue_instance.matte_notconnected_overlay = true;
    if (Matte.WebSockets.socket.readyState === 1) {
      Matte.WebSockets.socket.close();
    }
  });

  socket.addEventListener('open', function() {
    Matte.set_ready(Matte.vue_instance);
  });

  socket.addEventListener('message', function(event) {
    try {
      if (event.data.startsWith('{') && event.data.endsWith('}')) {
        Matte.vue_instance.update_model(JSON.parse(event.data));
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

  socket.addEventListener('close', function() {
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
    setTimeout(Matte.set_ready, 1000, vue_instance);
  }
}

Matte.request_update = function(id, inputs) {
  Matte.WebSockets.sendMessageTo(Settings.channel, Settings.message, {
      'id': id,
      'input': inputs,
      'session_id': Matte.vue_instance.session_id
  });
}

export var MatteMod = Matte;
