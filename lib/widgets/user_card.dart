import 'package:flutter/material.dart';

import '../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final CanvasUser user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(user.name),
          )
        ],
      ),
    );
  }
}