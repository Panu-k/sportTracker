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

  getUserData() async {
    var response = await http.get(Uri.http('10.0.2.2:3002', 'users'));
    var jsondata = jsonDecode(response.body);

    print(jsondata.toString());
    List<User> users = [];

    for (var u in jsondata) {
      User user = User(u["idUsers"], u["Name"], u["Email"], u["UserName"]);
      users.add(user);
    }
    print(users[0].name);

    return users;
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
                                  onPressed: () {
                                    getUserData();
                                    //Navigator.push(
                                    //  context,
                                    // MaterialPageRoute(
                                    //    builder: (context) =>
                                    //       const MyHomePage(
                                    //          title: "Flutter Demo")));
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
