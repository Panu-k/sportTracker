import 'package:flutter/material.dart';

import 'package:sport_tracker/models/records.dart';

class RecordPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final Records record;

  RecordPage(this.record);

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
                            ElevatedButton(
                                onPressed: () {
                                  
                                },
                                child: Text(record.time)),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
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
}
