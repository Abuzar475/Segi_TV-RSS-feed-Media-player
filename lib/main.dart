import 'package:flutter/material.dart';
import 'package:segi_tv/detailed_screen.dart';
import 'package:segi_tv/news_feed.dart';
import 'dart:async';
import 'color.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RSSDemo(),
          ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          brightness: Brightness.dark),
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/segitv-home-480.png'),
                    fit: BoxFit.fill,
                  ),

                ],
              ),
             ],
          ),
        ),
      ),
    );
  }
}
