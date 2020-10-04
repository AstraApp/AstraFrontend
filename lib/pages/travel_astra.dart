import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:astra_app/pages/launch.dart';
import 'package:camera/camera.dart';

class TravelAstra extends StatelessWidget {
  final List<CameraDescription> camera;

  const TravelAstra({Key key, this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => Launch(camera: camera,)));
              }),
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Text('Hello')
        )
      )
    );
  }
}
