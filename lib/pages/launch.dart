import 'dart:io';
import 'package:astra_app/pages/travel_astra.dart';
import 'package:astra_app/widgets/camera_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/widgets/custom_button.dart';
import 'package:astra_app/pages/home.dart';
import 'package:location/location.dart';
import 'package:astra_app/classes/satellite_info.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:async';

class Launch extends StatefulWidget {
  final List<CameraDescription> camera;

  const Launch({Key key, this.camera}) : super(key: key);

  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  bool loading = false;
  CameraController controller;
  final Location location = Location();

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        CameraPreview(controller),
        CameraBorder(),
        !loading
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                           IconButton(
                                  icon: Icon(
                                    Icons.airplanemode_active,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TravelAstra(camera: widget.camera,)));
                                  }),

                            CustomButton(
                              text: 'Launch',
                              callback: () async {
                                setState(() {
                                  loading = true;
                                });
                                LocationData _location =
                                    await location.getLocation();
                                print(
                                    'lat: ${_location.latitude}, long: ${_location.longitude}');
                                int x = _location.latitude.toInt();
                                int y = _location.longitude.toInt();
                                int z;
                                if (y.abs() < 180 && y.abs() > 90) {
                                  z = -1;
                                } else {
                                  z = 1;
                                }
                                // For Video Purposes
                                z = z * -1;

                                final String baseUrl = "https://5d36db03952a.ngrok.io";
                                final Dio dio = new Dio();
                                var response;

                                try {
                                  response =
                                  await dio.get("$baseUrl/?x=$x&y=$y&z=$z");
                                  print(response.data);
                                } on DioError catch (e) {
                                  print(e);
                                }

                                SatelliteInfo satelliteInfo =
                                    satelliteInfoFromJson(
                                        response.data.toString());
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => Home(
                                              camera: widget.camera,
                                              satelliteInfo: satelliteInfo,
                                            )));
                              },
                              color: Colors.white,
                            ),
                            IconButton(
                              icon: Icon(Icons.info, color: Colors.white,),
                              onPressed: (){
                                showDialog(context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Astra lives up to what it always wanted to be.\nThe pinnacle of the Cosmos.\nThe radiant beam to the eyes. '),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text("Our goal was to create an app that allows anyone to immediately gather information about numerous satellites orbiting our planet each day simply through their camera."),
                                              Text('\nAll done in a click of a button.\n', style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),),
                                              Text("Our app not only lets you track satellites with just a camera but truly emphasizes the fact of human connection and interaction. With that being said, Astra offers a share feature to share satellite watch events a user will be attending with their friends and helps others connect from all around the world by allowing users to find out which satellites are present in another country. If that's not enough, Astra offers a full-scale 3D model of the earth along with thousands of satellites orbiting around it, with full details for each model. We started out with the lofty goal of data collection and ended with a true emphasis on connecting humans together with each other, from any part of the world. This is not just an app, it represents all of us. This is Astra."),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    }
                                );
                              },
                            ),
                          ],
                        ))))
            : CircularProgressIndicator()
      ],
    ));
  }
}
