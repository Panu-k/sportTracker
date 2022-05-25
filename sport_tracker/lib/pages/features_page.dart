import 'package:flutter/material.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Features"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
            childAspectRatio: 4,
            crossAxisCount: 2,
            children: const [
              Center(
                child: Text(
                  "Feature",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Center(child: Text("Works", style: TextStyle(fontSize: 24))),
              Center(child: Text("Sign up")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Sign in")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(
                child: Text(
                  "Change password",
                ),
              ),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Logout")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Splash screen")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("List of Records")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Add new Record")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Modify Record")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Delete Record")),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(child: Text("Icon for Record")),
              Center(child: Checkbox(value: false, onChanged: null)),
              Center(child: Text("Picture for Record")),
              Center(child: Checkbox(value: false, onChanged: null)),
              Center(
                child: Text(
                  "Several pages\n in software",
                  maxLines: 2,
                ),
              ),
              Center(child: Checkbox(value: true, onChanged: null)),
              Center(
                  child: Text(
                "Modify personal \n data in settings",
                maxLines: 2,
              )),
              Center(child: Checkbox(value: false, onChanged: null)),
              Center(child: Text("Load sports from server")),
              Center(child: Checkbox(value: true, onChanged: null)),
            ]),
      ),
    );
  }
}
