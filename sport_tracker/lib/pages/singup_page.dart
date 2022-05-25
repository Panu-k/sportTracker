import 'package:flutter/material.dart';
import 'package:sport_tracker/utils/utils.dart';
import 'package:http/http.dart' as http;

class SingupPage extends StatelessWidget {
  SingupPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _emailController = TextEditingController();

  Color borcol = Color.fromARGB(255, 48, 48, 48);
  Color col = Color.fromARGB(255, 79, 224, 188);
  double radius = 25;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool will = await Utils.leavePage(context);
          return will;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Sing up"),
            ),
            body: Stack(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SingleChildScrollView(
                      child: Form(
                          key: formKey,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: col,
                                          border: Border.all(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _nameController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Name",
                                              labelText: "Name"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: col,
                                          border: Border.all(color: borcol),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Username",
                                              labelText: "Username"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: col,
                                          border: Border.all(color: borcol),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Password",
                                              labelText: "Password"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: col,
                                          border: Border.all(color: borcol),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _password2Controller,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              hintText: "Confirm Password",
                                              labelText: "Confirm Password"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: col,
                                          border: Border.all(color: borcol),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Email",
                                              labelText: "Email"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        var res = await _NewUser();
                                        if (res == "Succesful") {
                                          Navigator.pop(context);
                                        } else if (res
                                            .toString()
                                            .contains("Duplicate")) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const AlertDialog(
                                                  title: Text("Username"),
                                                  content: Text(
                                                      'Username is all ready used'),
                                                );
                                              });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const AlertDialog(
                                                  title:
                                                      Text("Fill all fields"),
                                                );
                                              });
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
            )));
  }

  _NewUser() async {
    if (_passwordController.text == _password2Controller.text &&
        _passwordController.text.isNotEmpty) {
      Map<String, dynamic> params;
      var name, username, email, passwd = null;
      if (_nameController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty) {
        name = _nameController.text;
        username = _usernameController.text;
        email = _emailController.text;
        passwd = _passwordController.text;
        params = {
          'name': name,
          'passwd': passwd,
          'email': email,
          'username': username
        };

        var url = Uri.parse('http://10.0.2.2:3002/users');
        var response = await http.post(
          url,
          body: params,
        );
        return response.body;
      }
    }
  }
}
