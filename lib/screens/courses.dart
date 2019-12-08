import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/database.dart';

import './courses_overview.dart';

class CoursesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 50, 0.1),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Kurser"),
      ),
      body: CoursesOverview(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
                child: Row(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 100,
                      )
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Victor Josephson',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w300)),
                        Text('vals@kth.se',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w300))
                      ]),
                ]),
                decoration: BoxDecoration(color: Colors.blue),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              height: 50,
              child: InkWell(
                onTap: () => DBProvider.db.resetDatabase(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Visa alla',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          color: Colors.black87
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}