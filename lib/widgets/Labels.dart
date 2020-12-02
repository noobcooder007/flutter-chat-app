import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String text;
  final String navigationText;

  const Labels({Key key, @required this.route, @required this.text, @required this.navigationText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.text,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(this.navigationText,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
