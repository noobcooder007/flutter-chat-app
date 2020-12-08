import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/SocketService.dart';
import 'package:chat_app/services/ChatService.dart';
import 'package:chat_app/services/AuthServices.dart';

import 'package:chat_app/models/MessagesReponse.dart';
import 'package:chat_app/widgets/ChatMessage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  List<ChatMessage> _messages = [];
  bool _typing = false;

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.socketService.socket.on('message-private', _listenMessages);
    _loadHistorial(this.chatService.userTo.uid);
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    this.socketService.socket.off('message-private');
    super.dispose();
  }

  void _listenMessages(dynamic payload) {
    ChatMessage message = ChatMessage(
        text: payload['msg'],
        uid: payload['uid'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void _loadHistorial(String userID) async {
    List<Message> chat = await this.chatService.getChat(userID);
    final historyChat = chat.map((m) => ChatMessage(text: m.msg, uid: m.from, animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300))..forward()));
    setState(() {
      _messages.insertAll(0, historyChat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
                child: Text(chatService.userTo.name.substring(0, 2),
                    style: TextStyle(fontSize: 12.0)),
                backgroundColor: Colors.blue[100],
                maxRadius: 14),
            SizedBox(height: 3.0),
            Text(chatService.userTo.name,
                style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (_, index) => _messages[index],
                    reverse: true)),
            SizedBox(height: 1.0),
            Container(
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
        child: Row(
          children: [
            Flexible(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _handleSubmit,
                onChanged: (String value) => setState(() {
                  value.trim().length > 0 ? _typing = true : _typing = false;
                }),
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            )),
            Container(
                child: Platform.isIOS
                    ? CupertinoButton(
                        child: Text('Send'),
                        onPressed: _typing
                            ? () => _handleSubmit(_textEditingController.text)
                            : null)
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(25)),
                          child: IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: IconButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: Icon(Icons.send, size: 25.0),
                              onPressed: _typing
                                  ? () =>
                                      _handleSubmit(_textEditingController.text)
                                  : null,
                            ),
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) {
      return;
    }
    _textEditingController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
        text: text,
        uid: authService.user.uid,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));
    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _typing = false;
    });
    this.socketService.socket.emit('message-private', {
      'from': this.authService.user.uid,
      'to': this.chatService.userTo.uid,
      'msg': text
    });
  }
}
