import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryWidget extends StatelessWidget {
  final String name;
  final List<int> coords;

  const CountryWidget({Key key, this.name, this.coords}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      onTap: () {
      },
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Colors.black)
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              // Icons.room,
              Icons.link,
              size: 30,
              color: Colors.green,
            ),
            SizedBox(
              width: 5,
            ),
            Text('More Info', style: TextStyle(
                fontSize: 20
            ),),
          ],
        ),
      ),
    );
  }
}
