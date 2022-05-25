// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sport_tracker/pages/features_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Stack(children: <Widget>[
        Image.asset(
          "assets/backroundImage.jpg",
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Sport Tracker",
                  style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              Text("version 1.0"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeaturesPage()));
                  },
                  child: Text("List of Features"))
            ],
          ),
        )),
      ]),
    );
  }
}
