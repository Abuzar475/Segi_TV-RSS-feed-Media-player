import 'package:flutter/material.dart';
import 'package:segi_tv/color.dart';
import 'package:segi_tv/video_player.dart';

class DetailedScreen extends StatelessWidget {
  String url, thumbnail, category, title, description, content;

  DetailedScreen(this.url, this.title, this.description, this.thumbnail, this.content );
  @override
  Widget build(BuildContext context) {

 return Scaffold(
    body: Container(
      child: Column(children: [
           Image.network(this.thumbnail,
          //  fit: BoxFit.fill,
          height: 300,
        ),
        Column(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(this.title, style: TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text('',style: TextStyle(color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,),
                      ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(this.description, style: TextStyle(color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                        maxLines: 10,
                                overflow: TextOverflow.ellipsis,),

                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(children: [
                                    // ignore: deprecated_member_use
                                    RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: kPrimaryColor)),
      onPressed: () {
  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoApp(this.content),
          ));
      },
      color: kPrimaryColor,
      textColor: Colors.white,
      child: Text("Play Video".toUpperCase(),
        style: TextStyle(fontSize: 14)),
    ),
                                  ],),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ])
      // ]),
    )
    );
      
 
  }
}