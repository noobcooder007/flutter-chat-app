import 'package:chat_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/pages/UsersPage.dart';
import 'package:chat_app/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(child: Text('Waiting'));
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticated = await authService.isLoggedIn();

    if (authenticated) {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => UsersPage(), transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(), transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
