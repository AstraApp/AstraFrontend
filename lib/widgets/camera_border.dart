import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 400,
        child: Column(
          children: [
            Row(children: [
              Container(width: 50,height: 5, color: Colors.white,),
              Expanded(child: Container(),),
              Container(width: 50,height: 5, color: Colors.white,),
            ],),
            Row(children: [
              Container(width: 5,height: 50, color: Colors.white,),
              Expanded(child: Container(),),
              Container(width: 5,height: 50, color: Colors.white,),
            ],),
            Expanded(child: Container(),),
            Row(children: [
              Container(width: 5,height: 50, color: Colors.white,),
              Expanded(child: Container(),),
              Container(width: 5,height: 50, color: Colors.white,),
            ],),
            Row(children: [
              Container(width: 50,height: 5, color: Colors.white,),
              Expanded(child: Container(),),
              Container(width: 50,height: 5, color: Colors.white,),
            ],),
          ],
        ),
        margin: EdgeInsets.all(50),
        width: 300,
      ),
    );
  }
}
