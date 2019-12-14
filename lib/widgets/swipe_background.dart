import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget swipeBackground() {
    return Container(
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text("Markera inaktiv",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }