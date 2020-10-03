import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:astra_app/pages/launch.dart';

List<CameraDescription> cameras;

class Home extends StatefulWidget {
  final List<CameraDescription> camera;

  const Home({Key key, this.camera}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                        'https://images.squarespace-cdn.com/content/v1/5b3bd5a9266c077a5bdfcafd/1579031116870-BD0UGULOLDUG0P182RDB/ke17ZwdGBToddI8pDm48kJanlAjKydPZDDRBEy8QTGN7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0hveExjbswnAj1UrRPScjfAi-WHBb3R4axoAEB7lfybbrcBqLQ3Qt4YGS4XJxXD2Ag/ELFIN-twin-probes-aurora.jpg'),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'FIREBIRD-3',
                        style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Released xx/xx/xxxx',
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
                      Text('Description Here\naoeigjaoijf oaejifoaeij foaeij foawejfo aiefojaef aeiuf aoeufh iuaehf iahefiaiefh aiehfi aehif aiehf iauehfi auefauehfiuaefhia ehif ahef '),
                      Divider(thickness: 2,),
                      Text('Velocity', style: TextStyle(
                        fontSize: 22
                      ),),
                      Text('Version', style: TextStyle(
                          fontSize: 22
                      ),),
                      // Row(
                      //   children: <Widget>[
                      //     // RatingStars(rating: 4.5),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Text(
                      //       '23 Ratings',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, fontSize: 15),
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Ink(
                      //       decoration: BoxDecoration(
                      //           color: Colors.lightBlueAccent,
                      //           borderRadius: BorderRadius.all(Radius.circular(100))
                      //       ),
                      //       child:  IconButton(
                      //         icon: Icon(Icons.add, color: Colors.black,),
                      //         onPressed: (){},
                      //       ),
                      //     )
                      //
                      //   ],
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
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
