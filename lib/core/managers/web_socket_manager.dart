import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final class WebSocketManager {
  static final WebSocketManager instance = WebSocketManager();

  IO.Socket get socket => IO.io("http://localhost:3001",
      IO.OptionBuilder().setTransports(['websocket']).build());
  initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success");
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint("Websocket disconnected"));
    socket.dispose();
  }

  closeEvent(String channel) {
    socket.off(channel);
  }

  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }
}
