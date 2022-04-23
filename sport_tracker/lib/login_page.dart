import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sport_tracker/main.dart';
import 'package:http/http.dart' as http;
import 'package:sport_tracker/user.dart';

// ignore: use_key_in_widget_constructors
class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();
  bool haveUser = false;

  getUserData() async {
    User user;
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      var name = _usernameController.text;
      var pass = _passwordController.text;
      try {
        var response = await http.get(Uri.http(
          '10.0.2.2:3002',
          'check',
          {'username': name, 'password': pass},
        ));
        var jsondata = jsonDecode(response.body);
        if (jsondata[0] != null) {
          print(jsondata.toString());
          haveUser = true;
          user = User(jsondata["idUsers"], jsondata["Name"], jsondata["Email"],
              jsondata["UserName"]);
          return true;
        }
      } catch (e) {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: Stack(
          children: <Widget>[
            Image.asset(
              "assets/backroundImage.jpg",
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
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
                                controller: _usernameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText: "Enter Username",
                                    labelText: "Username"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Enter Password",
                                    labelText: "Password"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await getUserData();
                                    print(haveUser);
                                    if (haveUser) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage(
                                                      title: "Flutter Demo")));
                                    }
                                  },
                                  child: Text("Sing in"))
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
