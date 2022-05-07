import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_tracker/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.moon_stars))
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [Text('')],
          )
        ],
      ),
    );
  }
}
