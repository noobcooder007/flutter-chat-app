import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.placeHolder,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 20.0),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5.0)
          ]),
      child: TextField(
        controller: this.textEditingController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        textCapitalization: this.textCapitalization,
        obscureText: this.obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeHolder),
      ),
    );
  }
}
