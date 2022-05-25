// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/pages/new_sport.dart';
import 'package:sport_tracker/utils/utils.dart';
import 'package:time_range_picker/time_range_picker.dart';

class NewRecordPage extends StatefulWidget {
  const NewRecordPage(this.listSports);

  final List<String> listSports;
  @override
  State<NewRecordPage> createState() => _NewRecordPageState();
}

class _NewRecordPageState extends State<NewRecordPage> {
  final formKey = GlobalKey<FormState>();

  final prefs = SharedPreferences.getInstance();

  final _infoController = TextEditingController();
  final _distanceController = TextEditingController();
  static const double height = 20;

  DateTime? _date = null;

  String? _sport = null;
  String? _time = null;
  List<DropdownMenuItem<String>>? Sports = [];

  getList() {
    Sports = [];
    for (var u in widget.listSports) {
      Sports!.add(DropdownMenuItem(
        child: Text(u),
        value: u,
      ));
    }
  }

  void dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _sport = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return WillPopScope(
        onWillPop: () async {
          bool will = await Utils.leavePage(context);
          return will;
        },
        child: Scaffold(
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
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.lightGreen,
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 48, 48, 48)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButton(
                                          items: Sports,
                                          onChanged: dropDownCallBack,
                                          hint: _sport == null
                                              ? Text("Select Sport")
                                              : Text(_sport!),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            bool? plus = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewSport()));
                                            if (plus == true) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text('Add new Sport'))
                                    ]),
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
                                          _time =
                                              Utils.Time_Calculator(timeRange);
                                        },
                                        child: Text("Used time")),
                                  ],
                                ),
                                TextFormField(
                                  controller: _distanceController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: "Distance"),
                                ),
                                TextFormField(
                                  controller: _infoController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  decoration:
                                      const InputDecoration(labelText: "Info"),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      bool pop = await _newRecord();
                                      if (pop) {
                                        Navigator.of(context).pop();
                                      } else {
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return AlertDialog(
                                                title: Text(
                                                    'Fill all necessary fields, please'),
                                              );
                                            });
                                      }
                                    },
                                    child: Text("Save record"))
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }

  _newRecord() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params;
    var time, date, sport, distance, text = null;
    try {
      if (_sport != null && _date != null) {
        var user = prefs.getInt("idUser");
        sport = _sport;
        var sportid = prefs.getInt(sport).toString();
        var da = _date.toString().split(' ');
        date = da.removeAt(0);
        params = {
          'idSports': sportid,
          'Date': date,
          'idUsers': user.toString()
        };
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
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
