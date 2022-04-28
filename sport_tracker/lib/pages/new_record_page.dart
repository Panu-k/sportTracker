// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';
import 'package:sport_tracker/models/records.dart';

class NewRecordPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  NewRecordPage();
  static const double height = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Record"),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: "Sport"),
                            ),
                            SizedBox(
                              height: height,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: "Date"),
                            ),
                            SizedBox(
                              height: height,
                            ),
                            TimeRange(
                              fromTitle: Text(
                                'From',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 70, 70, 70)),
                              ),
                              toTitle: Text(
                                'To',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 70, 70, 70)),
                              ),
                              titlePadding: 20,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                              activeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              borderColor: Color(0xFF333A47),
                              backgroundColor: Colors.transparent,
                              activeBackgroundColor: Color(0xFFFE9A75),
                              firstTime: TimeOfDay(hour: 01, minute: 30),
                              lastTime: TimeOfDay(hour: 24, minute: 00),
                              timeStep: 10,
                              timeBlock: 10,
                              onRangeCompleted: (range) => print(range),
                            ),
                            SizedBox(
                              height: height,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration:
                                  const InputDecoration(labelText: "Info"),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ));
  }
}
