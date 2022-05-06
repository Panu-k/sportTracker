// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'package:sport_tracker/models/records.dart';
import 'package:sport_tracker/pages/list_page.dart';

class NewRecordPage extends StatefulWidget {
  const NewRecordPage();

  @override
  State<NewRecordPage> createState() => _NewRecordPageState();
}

class _NewRecordPageState extends State<NewRecordPage> {
  final formKey = GlobalKey<FormState>();

  final _sportController = TextEditingController();

  final _infoController = TextEditingController();
  final _distanceController = TextEditingController();

  static const double height = 20;

  DateTime? _dateTime = null;

  String? _time = null;

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
                      color: Colors.greenAccent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: _sportController,
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: "Sport"),
                            ),
                            SizedBox(
                              height: height,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      _dateTime = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now());
                                    },
                                    child: Text("Date")),
                                SizedBox(
                                  width: height,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeRange timeRange =
                                          await showTimeRangePicker(
                                              context: context);
                                      _Time_Calculator(timeRange);
                                    },
                                    child: Text("Used time")),
                              ],
                            ),
                            TextFormField(
                              controller: _distanceController,
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: "Distance"),
                            ),
                            TextFormField(
                              controller: _infoController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration:
                                  const InputDecoration(labelText: "Info"),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await _newRecord();

                                  //Navigator.of(context).pop();
                                },
                                child: Text("Save record"))
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ));
  }

  _Time_Calculator(TimeRange timeRange) {
    int startTime = timeRange.startTime.hour * 60 + timeRange.startTime.minute;
    int endTime = timeRange.endTime.hour * 60 + timeRange.endTime.minute;
    int min = endTime - startTime;
    double divine = min / 60;
    int hours = divine.round();
    int minutes = min % 60;
    if (hours > 0)
      _time = "$hours t, $minutes min";
    else {
      _time = "$minutes min";
    }
  }

  Future<bool> _leavePage() async {
    final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to leave without saving?'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'))
              ],
            ));

    return shouldPop ?? false;
  }

  _newRecord() async {
    final prefs = await SharedPreferences.getInstance();
    if (_sportController.text.isNotEmpty &&
        _infoController.text.isNotEmpty &&
        _time != null &&
        _dateTime != null) {
      var user = prefs.getInt("idUser");
      var time = _time;
      var date = _dateTime;
      var text = _infoController.text;
      var sport = _sportController.text;

      var sportid = prefs.getInt(sport);
      try {
        var response = await http.post(Uri.http(
          '10.0.2.2:3002',
          'records',
          {'idSports': '', 'password': 'pass'},
        ));
        return true;
      } catch (e) {
        return false;
      }
    }
  }
}
