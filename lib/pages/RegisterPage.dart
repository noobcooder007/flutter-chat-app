import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/helpers/ShowAlert.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/Labels.dart';
import 'package:chat_app/widgets/Logo.dart';
import 'package:chat_app/widgets/CustomInput.dart';
import 'package:chat_app/widgets/BlueButton.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(text: 'SignUp'),
                _Form(),
                Labels(text: 'I have an account', navigationText: 'Login now', route: 'LOGIN'),
                Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Terms and conditions of use',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.person_outline,
              placeHolder: 'Name',
              keyboardType: TextInputType.name,
              textEditingController: nameCtrl,
              textCapitalization: TextCapitalization.words),
          CustomInput(
              icon: Icons.email_outlined,
              placeHolder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textEditingController: emailCtrl),
          CustomInput(
              icon: Icons.lock_outlined,
              placeHolder: 'Password',
              keyboardType: TextInputType.text,
              textEditingController: passCtrl,
              obscureText: true),
          BlueButton(text: 'Signup', onPressed: authService.authenticating
                  ? null
                  : () async {
                    FocusScope.of(context).unfocus();
                      final loginOk = await authService.register(
                          nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());
                          loginOk == true ? Navigator.pushReplacementNamed(context, 'USERS') : showAlert(context, 'Register incorrect', loginOk);
                    }),
        ],
      ),
    );
  }
}
