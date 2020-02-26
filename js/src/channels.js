// This file is a modified version of the one from Genie.jl (https://github.com/GenieFramework/Genie.jl)
// Copyright (c) 2016-2019 Adrian Salceanu and Genie.jl Contributors

window.Genie = {};
Genie.Settings = {
  "webchannels_autosubscribe":true,
  "server_host":"127.0.0.1",
  "webchannels_subscribe_channel":"subscribe",
  "server_port":8000,
  "webchannels_default_route":"__",
  "webchannels_unsubscribe_channel":"unsubscribe","websockets_port":8001
}

// Genie WebChannels functions
Genie.WebChannels = {};
Genie.WebChannels.load_channels = function() {
  var socket = new WebSocket('ws://' + window.Genie.Settings.server_host + ':' + window.Genie.Settings.websockets_port);
  var channels = Genie.WebChannels;

  channels.channel = socket;
  channels.sendMessageTo = sendMessageTo;

  channels.messageHandlers = [];
  channels.errorHandlers = [];
  channels.openHandlers = [];
  channels.closeHandlers = [];

  socket.addEventListener('open', function(event) {
    for (var i = 0; i < channels.openHandlers.length; i++) {
      var f = channels.openHandlers[i];
      if (typeof f === 'function') {
        f(event);
      }
    }
  });

  socket.addEventListener('message', function(event) {
    for (var i = 0; i < channels.messageHandlers.length; i++) {
      var f = channels.messageHandlers[i];
      if (typeof f === 'function') {
        f(event);
      }
    }
  });

  socket.addEventListener('error', function(event) {
    for (var i = 0; i < channels.errorHandlers.length; i++) {
      var f = channels.errorHandlers[i];
      if (typeof f === 'function') {
        f(event);
      }
    }
  });

  socket.addEventListener('close', function(event) {
    for (var i = 0; i < channels.closeHandlers.length; i++) {
      var f = channels.closeHandlers[i];
      if (typeof f === 'function') {
        f(event);
      }
    }
  });

  // A message maps to a channel route so that channel + message = /action/controller
  // The payload is the data made exposed in the Channel Controller
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

function subscribe() {
  if (document.readyState === "complete" || document.readyState === "interactive") {
    Genie.WebChannels.sendMessageTo(window.Genie.Settings.webchannels_default_route, window.Genie.Settings.webchannels_subscribe_channel);
    g.on_connected()
  } else {
    console.log("Queuing subscription");
    setTimeout(subscribe, 1000);
  }
};

function unsubscribe() {
  Genie.WebChannels.sendMessageTo(window.Genie.Settings.webchannels_default_route, window.Genie.Settings.webchannels_unsubscribe_channel);
  g.matte_notconnected_overlay = true;
};

// Matte.jl functions
Matte = {};
Matte.request_update = function(id, inputs) {
  Genie.WebChannels.sendMessageTo('matte', 'api', {
      'id': id,
      'input': inputs,
      'session_id': window.session_id
  });
}

// Run code on load
Matte.open_channel = function() {
  window.addEventListener('beforeunload', function (event) {
    if (Genie.WebChannels.channel.readyState === 1) {
      Genie.WebChannels.channel.close();
    }
  });

  Genie.WebChannels.load_channels();

  Genie.WebChannels.messageHandlers.push(function(event){
    try {
      if (event.data.startsWith('{') && event.data.endsWith('}')) {
        response = JSON.parse(event.data)
        g.update_model(response)
      } else {
        console.log(event.data);
      }
    } catch (ex) {
      console.log(ex);
    }
  });

  Genie.WebChannels.errorHandlers.push(function(event) {
    console.log(event.data)
  });

  Genie.WebChannels.closeHandlers.push(function(event) {
    console.log("Server closed WebSocket connection");
    g.matte_notconnected_overlay = true;
  });

  Genie.WebChannels.openHandlers.push(function(event) {
    subscribe();
  });

  window.onbeforeunload = function() {
    unsubscribe();
  };
}
