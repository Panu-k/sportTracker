import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/utils/utils.dart';

class NewSport extends StatelessWidget {
  NewSport({Key? key}) : super(key: key);

  final _sportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool will = await Utils.leavePage(context);
        return will;
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text('Add new sport'),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'Add new Sport to sport list',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  controller: _sportController,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_sportController.text.isEmpty) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Fill all fields, please'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        );
                      });
                } else {
                  var res = await _newSport(context);
                  if (res == "Added") {
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop(false);
                  }
                }
              },
              child: Text('New Sport'),
            ),
          ]),
        ),
      ),
    ));
  }

  _newSport(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var sport = _sportController.text;
    var list = prefs.getInt(sport);
    if (list == null) {
      var params = {'Sport': sport};
      var url = Uri.parse('http://10.0.2.2:3002/sports');
      var response = await http.post(
        url,
        body: params,
      );
      return response.body;
    }
  }
}
