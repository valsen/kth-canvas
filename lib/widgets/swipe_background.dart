import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/models/models.dart';

Widget swipeBackground(VisibilityFilter activeFilter) {
    return Container(
      color: activeFilter == VisibilityFilter.active ? Colors.purple : Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
                activeFilter == VisibilityFilter.active ? "Markera inaktiv" : "Markera aktiv",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }