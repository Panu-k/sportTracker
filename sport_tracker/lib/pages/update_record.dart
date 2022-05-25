// ignore_for_file: avoid_init_to_null, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/models/records.dart';
import 'package:sport_tracker/pages/new_sport.dart';
import 'package:sport_tracker/utils/utils.dart';

class RecordPage extends StatefulWidget {
  RecordPage(this.records, this.listSports, {Key? key}) : super(key: key);

  Records records;
  List<String> listSports;
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final formKey = GlobalKey<FormState>();

  final prefs = SharedPreferences.getInstance();

  final _infoController = TextEditingController();
  final _distanceController = TextEditingController();
  final _timeController = TextEditingController();
  static const double height = 20;

  DateTime? _date;
  DateTime dateTime = DateTime.now();

  String? _sport = null;
  String? _datetime = null;
  List<DropdownMenuItem<String>>? Sports = [];

  getList() {
    //Do dropdownitemlist
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

  void Startter() {
    _date = DateTime.parse(widget.records.date);
    dateTime = DateTime.parse(widget.records.date);
    _datetime = widget.records.date;
    _sport = widget.records.Sport;
    _timeController.text = widget.records.time;
    _infoController.text = widget.records.infotext.toString();
    _distanceController.text = widget.records.distance.toString();
  }

  @override
  Widget build(BuildContext context) {
    Startter();
    return WillPopScope(
      onWillPop: () async {
        bool will = await Utils.leavePage(context);
        return will;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("New Record"),
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
                                              color: const Color.fromARGB(
                                                  255, 48, 48, 48)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DropdownButton(
                                        items: Sports,
                                        onChanged: dropDownCallBack,
                                        hint: _sport == null
                                            ? const Text("Select Sport")
                                            : Text(_sport!),
                                      ),
                                    ),
                                    const SizedBox(
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
                                        child: const Text('Add new Sport'))
                                  ]),
                              const SizedBox(
                                height: height,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        _date = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                dateTime, //Show this DateTime first
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime.now());
                                      },
                                      child: const Text("Date")),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(_datetime!)
                                ],
                              ),
                              TextFormField(
                                controller: _timeController,
                                keyboardType: TextInputType.text,
                                decoration:
                                    const InputDecoration(labelText: "Time"),
                              ),
                              const SizedBox(
                                height: height,
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
                                    FocusScope.of(context)
                                        .unfocus(); //Unfocus so keyboard close
                                    bool pop = await _updateRecord();
                                    if (pop) {
                                      Navigator.of(context).pop();
                                    } else {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              Navigator.of(context).pop(true);
                                            });
                                            return const AlertDialog(
                                              title: Text(
                                                  'Fill all necessary fields, please'),
                                            );
                                          });
                                    }
                                  },
                                  child: const Text("Save record"))
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ],
          )),
    );
  }

  _updateRecord() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params;
    var _time, date, sport, distance, text = null;
    try {
      if (_sport != null && _date != null) {
        var user = prefs.getInt("idUser");
        sport = _sport;
        var sportid = prefs.getInt(sport).toString();
        var da = _date.toString().split(' ');
        date = da.removeAt(0);

        var _record = widget.records.idRecords;
        params = {
          'idRecords': _record.toString(),
          'idSports': sportid,
          'Date': date,
          'idUsers': user.toString()
        };
        if (_timeController.text.isNotEmpty) {
          _time = _timeController.text;
          params.addAll(<String, dynamic>{'Time': _time});
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
        var response = await http.put(
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
