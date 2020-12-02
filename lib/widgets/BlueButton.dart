import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BlueButton({Key key, @required this.onPressed, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Center(
          child: Text(this.text,
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ),
      ),
    );
  }
}
