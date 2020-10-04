import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/pages/launch.dart';
import 'package:astra_app/classes/satellite_info.dart';
import 'package:url_launcher/url_launcher.dart';

List<CameraDescription> cameras;

class Home extends StatefulWidget {
  final List<CameraDescription> camera;
  final SatelliteInfo satelliteInfo;

  const Home({Key key, this.camera, this.satelliteInfo}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _launchURL (String name) async {
    String url = 'https://hpde.io/SMWG/Observatory/$name';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.camera),
          onPressed: (){
            Navigator.pop(context);
            Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Launch(camera: widget.camera)));
          },

        ),
        title: Text('Astra'),
      ),
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
      ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
           begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.blue,
              Colors.white10
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(50, 30),
                      bottomRight: Radius.elliptical(50, 30)),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        widget.satelliteInfo.image),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.satelliteInfo.name,
                        style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.satelliteInfo.resourceName,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.satelliteInfo.description),
                      Divider(thickness: 2,),
                      Text('${widget.satelliteInfo.name} is traveling above you at ${widget.satelliteInfo.velocity}!', style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),),
                      Divider(thickness: 2,),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            onTap: () {
                              _launchURL(widget.satelliteInfo.name);
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
                          ),
                          Expanded(child: Container(),),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      )
    );
  }
}
