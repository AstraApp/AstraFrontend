import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/widgets/custom_button.dart';
import 'package:astra_app/pages/home.dart';
import 'package:location/location.dart';
import 'package:sensors/sensors.dart';
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
  CameraController controller;
  final Location location = Location();
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
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
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();

    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        CameraPreview(controller),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 500,
            margin: EdgeInsets.all(50),
            width: 300,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: Text(
                'Gyroscopic Data: ${gyroscope.toString()}',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: new Container(
                    padding: EdgeInsets.all(16),
                    child: CustomButton(
                      text: 'Launch',
                      callback: () async {
                        LocationData _location = await location.getLocation();
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

                        final String baseUrl = "https://60df6daab796.ngrok.io";
                        final Dio dio = new Dio();
                        var response;
                        try{
                          response = await dio.get("$baseUrl/?x=$x&y=$y&z=$z");
                          print(response.data);
                        } on DioError catch (e){
                          print(e);
                        }
                        SatelliteInfo satelliteInfo = satelliteInfoFromJson(response.data.toString());


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
                    ))))
      ],
    );
  }
}
