import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/pages/password_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(children: [
            ElevatedButton(
                onPressed: () async {
                  final show = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordPage()));
                  if (show) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return const AlertDialog(
                            title: Text("Succesful"),
                          );
                        });
                  }
                },
                child: Text('Change Password')),
            ElevatedButton(
                onPressed: () {
                  _logout();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text('Logout'))
          ]),
        ),
      ),
    );
  }

  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
