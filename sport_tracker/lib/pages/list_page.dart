// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/models/records.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sport_tracker/pages/new_record_page.dart';
import 'package:sport_tracker/pages/update_record.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  List<String> listSports = [];

  _getSports() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.http('10.0.2.2:3002', 'sports'));
    var jsondata = jsonDecode(response.body);
    for (var u in jsondata) {
      await prefs.setString(u["idSports"].toString(), u["Sport"]);
      await prefs.setInt(u["Sport"], u["idSports"]);
      listSports.add(u['Sport']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Records"),
      ),
      body: FutureBuilder(
        future: _getRecords(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewRecordPage(listSports)));
                  }
                },
                child: const Icon(Icons.add),
              ),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                          context: context,
                          builder: (context) {
                            var sport = snapshot.data[index].Sport;
                            var date = snapshot.data[index].date;
                            return AlertDialog(
                              title: Text("Deleting"),
                              content: Text(
                                  "Are you sure you wanna delete this $sport $date"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Confirm Delete")),
                                OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text("Cancel"))
                              ],
                            );
                          });
                    },
                    onDismissed: (_) {
                      _deleteRecord(snapshot.data[index]);
                    },
                    child: ListTile(
                      title: Text(snapshot.data[index].Sport),
                      subtitle: Text(snapshot.data[index].date +
                          "     " +
                          snapshot.data[index].time),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordPage(
                                      snapshot.data[index],
                                      listSports,
                                    )));
                      },
                    ),
                    background: Container(
                      color: Colors.red,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewRecordPage(listSports)));
          }
        },
        tooltip: 'New Record',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _deleteRecord(Records re) async {
    var id = re.idRecords.toString();
    var response = await http.delete(Uri.http(
      '10.0.2.2:3002',
      'records',
      {'idRecord': id},
    ));
    String res = response.body;
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text(res),
          );
        });
  }

  Future<List<Records>> _getRecords() async {
    await _getSports();
    final SharedPreferences _prefs = await prefs;
    final int? id = _prefs.getInt('idUser');
    var user = id.toString();
    var response = await http.get(Uri.http(
      '10.0.2.2:3002',
      'records',
      {'idUsers': user},
    ));
    var jsondata = jsonDecode(response.body);
    List<Records> records = [];

    if (jsondata != null) {
      for (var u in jsondata) {
        var id = u["idSports"].toString();
        Records re = Records(u["idRecords"], _prefs.getString(id).toString(),
            u["Time"], u["Date"], u["Text"], u["Distance"]);
        records.add(re);
      }
    }
    return records;
  }
}
