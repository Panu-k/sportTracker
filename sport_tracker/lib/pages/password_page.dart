import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_tracker/utils/utils.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final _oldpasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

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
              title: Text("Change Password"),
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
                                          border: Border.all(color: borcol),
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _oldpasswordController,
                                          obscureText: true,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter old password",
                                              labelText: "Old password"),
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
                                          obscureText: true,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter New Password",
                                              labelText: "New Password"),
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
                                              hintText:
                                                  "Enter new password again",
                                              labelText: "Confirm password"),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        var res = await _changePassword();
                                        if (res == "Succesful") {
                                          Navigator.pop(context, true);
                                        } else if (res == "Wrong") {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(
                                                      'Old password was wrong'),
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
                                      child: Text("Change"))
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

  _changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params;
    var passwd = prefs.getString("Pass");
    if (_oldpasswordController.text == passwd) {
      if (_passwordController.text != null &&
          _oldpasswordController.text != null &&
          _passwordController.text == _password2Controller.text) {
        var user = prefs.getInt("idUser");
        var pass = _passwordController.text;
        params = {'passwd': pass, 'idUsers': user.toString()};

        var url = Uri.parse('http://10.0.2.2:3002/users');
        var response = await http.put(
          url,
          body: params,
        );
        if (response.body == "Succesful") {
          prefs.setString('Pass', pass);
        }
        return response.body;
      }
    } else {
      String wrong = "Wrong";
      return wrong;
    }
  }
}
