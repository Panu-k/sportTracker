// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

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

  DateTime? _date = null;

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
                                      _date = await showDatePicker(
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

                                  Navigator.of(context).pop();
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
    Map<String, dynamic> params;
    var time, date, sport, distance, text = null;

    if (_sportController.text.isNotEmpty && _date != null) {
      var user = prefs.getInt("idUser");
      sport = _sportController.text;
      var sportid = prefs.getInt(sport).toString();
      var da = _date.toString().split(' ');
      date = da.removeAt(0);
      params = {'idSports': sportid, 'Date': date, 'idUsers': user.toString()};
      if (_time != null) {
        time = <String, dynamic>{'Time': _time};
        params.addAll(time);
      }

      if (_infoController.text.isNotEmpty) {
        text = _infoController.text;
        params.addAll(<String, dynamic>{'Text': text});
      }

      if (_distanceController.text.isNotEmpty) {
        distance = _distanceController.text;
        params.addAll(<String, dynamic>{'Dicstance': distance});
      }

      var url = Uri.parse('http://10.0.2.2:3002/records');
      var response = await http.post(
        url,
        body: params,
      );
      print(response.body);
    }
  }
}
