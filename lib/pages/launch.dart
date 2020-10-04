import 'dart:io';
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

    return Stack(
      alignment: Alignment.center,
      children: [
        CameraPreview(controller),
        CameraBorder(),
        !loading ? Align(
            alignment: Alignment.bottomCenter,
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: new Container(
                    padding: EdgeInsets.all(16),
                    child: CustomButton(
                      text: 'Launch',
                      callback: () async {
                        setState(() {
                          loading = true;
                        });
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
                        // For Video Purposes
                        z = z * -1;

                        final String baseUrl = "https://60df6daab796.ngrok.io";
                        final Dio dio = new Dio();
                        var response;

                        try {
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
                    )))) : CircularProgressIndicator()
      ],
    );
  }
}
