import 'package:chat_app/services/AuthServices.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/Environment.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;

  void connect() async {

    final token = await AuthService.getToken();
    this._socket = IO.io(Environment.apiSocket, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      "extraHeaders": {
        'x-token': token
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}