import 'dart:io';

import 'package:chat_app/widgets/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> _messages = [];
  bool _typing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
                child: Text('Te', style: TextStyle(fontSize: 12.0)),
                backgroundColor: Colors.blue[100],
                maxRadius: 14),
            SizedBox(height: 3.0),
            Text('Melissa Flores',
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
        uid: '123',
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));
    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _typing = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
