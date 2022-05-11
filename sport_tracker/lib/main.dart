import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/pages/about_page.dart';
import 'package:sport_tracker/pages/list_page.dart';
import 'package:sport_tracker/pages/login_page.dart';
import 'package:sport_tracker/pages/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getInt("idUser");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loginpage(),
    );
  }
}

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            child: TabBar(tabs: [
              Tab(
                icon: const Icon(Icons.assignment),
              ),
              Tab(child: Icon(Icons.settings)),
              const Tab(child: Icon(Icons.info)),
            ]),
          ),
        ),
        body: TabBarView(children: <Widget>[
          const ListPage(),
          SettingsPage(),
          AboutPage(),
        ]),
      ),
    );
  }
}
