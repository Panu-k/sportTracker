import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';
import 'package:sport_tracker/models/records.dart';

class RecordPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final Records record;

  RecordPage(this.record);
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const gray = Color.fromARGB(255, 70, 70, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(record.Sport),
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
                              initialValue: record.Sport,
                              decoration:
                                  const InputDecoration(labelText: "Sport"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: record.date,
                              decoration:
                                  const InputDecoration(labelText: "Date"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TimeRange(
                              fromTitle: Text(
                                'From',
                                style: TextStyle(fontSize: 18, color: gray),
                              ),
                              toTitle: Text(
                                'To',
                                style: TextStyle(fontSize: 18, color: gray),
                              ),
                              titlePadding: 20,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87),
                              activeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              borderColor: dark,
                              backgroundColor: Colors.transparent,
                              activeBackgroundColor: orange,
                              firstTime: TimeOfDay(hour: 01, minute: 30),
                              lastTime: TimeOfDay(hour: 24, minute: 00),
                              timeStep: 10,
                              timeBlock: 10,
                              onRangeCompleted: (range) => print(range),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              initialValue: record.infotext,
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

  //https://medium.flutterdevs.com/date-and-time-picker-in-flutter-72141e7531c

}
