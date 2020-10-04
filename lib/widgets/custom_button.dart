import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final Color color;

  const CustomButton({Key key, this.callback, this.text, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: StadiumBorder(),
      minWidth: 150,
      height: 60,
      child: RaisedButton(
        color: color,
        elevation: 6,
        child: Text(text, style: TextStyle(
            fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        onPressed: callback,
      ),
    );
  }
}