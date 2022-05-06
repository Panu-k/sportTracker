import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/pages/profile_page.dart';

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
                onPressed: () {
                  _logout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Text('Profile')),
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
