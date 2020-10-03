import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/widgets/custom_button.dart';
import 'package:astra_app/pages/home.dart';


class Launch extends StatefulWidget {
  final List<CameraDescription> camera;

  const Launch({Key key, this.camera}) : super(key: key);
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  CameraController controller;

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
            alignment: Alignment.bottomCenter,
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: new Container(
                    padding: EdgeInsets.all(16),
                    child: CustomButton(
                      text: 'Launch',
                      callback: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Home()));
                      },
                      color: Colors.white,
                    ))))
      ],
    );
  }
}
