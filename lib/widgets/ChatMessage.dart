import 'package:chat_app/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {Key key,
      @required this.text,
      @required this.uid,
      @required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uid == authService.user.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin:
              EdgeInsets.only(right: 8.0, left: 30.0, top: 4.0, bottom: 4.0),
          child: Text(this.text, style: TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
              color: Color(0xFF4D9EF6),
              borderRadius: BorderRadius.circular(16.0)),
        ));
  }

  Widget _notMyMessage() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin:
              EdgeInsets.only(left: 8.0, right: 30.0, top: 4.0, bottom: 4.0),
          child: Text(this.text, style: TextStyle(color: Colors.black)),
          decoration: BoxDecoration(
              color: Color(0xFFE4E5E8),
              borderRadius: BorderRadius.circular(16.0)),
        ));
  }
}
