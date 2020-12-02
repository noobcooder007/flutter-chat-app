import 'package:chat_app/pages/ChatPage.dart';
import 'package:chat_app/pages/LoadingPage.dart';
import 'package:chat_app/pages/LoginPage.dart';
import 'package:chat_app/pages/RegisterPage.dart';
import 'package:chat_app/pages/UsersPage.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'USERS': (_) => UsersPage(),
  'CHAT': (_) => ChatPage(),
  'LOGIN': (_) => LoginPage(),
  'REGISTER': (_) => RegisterPage(),
  'LOADING': (_) => LoadingPage()
};