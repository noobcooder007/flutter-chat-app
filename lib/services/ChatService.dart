import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat_app/global/Environment.dart';

import 'package:chat_app/services/AuthServices.dart';

import 'package:chat_app/models/MessagesReponse.dart';
import 'package:chat_app/models/User.dart';

class ChatService with ChangeNotifier {
  User userTo;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http.get('${Environment.apiUrl}/messages/$userID',
    headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    final messageResp = messagesResponseFromJson(resp.body);
    return messageResp.messages;
  }
}