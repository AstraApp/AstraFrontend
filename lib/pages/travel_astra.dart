import 'package:astra_app/widgets/country_travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:astra_app/pages/launch.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/main.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TravelAstra extends StatelessWidget {
  final List<CameraDescription> camera;

  const TravelAstra({Key key, this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => new WebviewScaffold(
          url: "http://www.stuffin.space/",
          appBar: new AppBar(
            title: new Text("Explore"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(
                  builder: (BuildContext context) => Launch(camera: camera,)
                )
                );
              },
            ),
          ),
        ),
      },
    );
  }
}
