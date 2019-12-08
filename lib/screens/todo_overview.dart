import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/models/upcoming_events_model.dart';
import 'package:flutter_tutorial/data/models/upcoming_events_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../todo_db_item.dart';
import '../data/database.dart';

class TodoOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoOverviewState();
  }
}

class _TodoOverviewState extends State<TodoOverview> {
  String token =
      "8779~KzUQiD6KASsiotpodfWzwBu1xCI8nCbkNgUgRslXKQl5sI7o4IKQQFSVbGiPZc1E";
  Future<List<UpcomingEvent>> _upcoming;

  Map<String, String> courseFromCode = {
    "course_16720": "Hållut",
    "course_12404": "ADK"
  };

  final locale = "sv_SE";
  DateFormat timeFormat;

  @override
  void initState() {
    print("initializing state");
    super.initState();
    _upcoming = getUpcomingEvents();
    initializeDateFormatting(locale).then((_) {
      timeFormat = DateFormat.MMMEd(locale).add_Hm();
    });
  }

  Future<List<UpcomingEvent>> getUpcomingEvents() async {
    String url =
        "https://kth.instructure.com/api/v1/users/self/upcoming_events";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return upcomingEventsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building todo overview");
    return FutureBuilder<List<UpcomingEvent>>(
      future: _upcoming,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView.builder(
//                padding: EdgeInsets.only(top: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (context, id) {
                  UpcomingEvent item = snapshot.data[id];
                  bool assignment = item.assignment != null;
                  int itemId = assignment ? item.assignment.id : item.id;
                  Future<bool> hidden = DBProvider.db.getTodo(itemId).then((res) {
                    if (res != null) {
                      print("HIDDEN");
                      return true;
                    }
                    return false;
                  });
                  return FutureBuilder<bool>(
                    future: hidden,
                    builder: (ctx, snap) {
                      if (snap.hasData) {
                        if (!snap.data) return Column(
                          children: <Widget>[
                            Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(itemId.toString()),
                              onDismissed: (direction) {
                                // Remove the item from the data source.
                                setState(() {
                                  snapshot.data.removeAt(id);
                                });
                                DBProvider.db.hideTodoItem(Todo.fromMap(
                                    {"id": itemId, "title": item.title}));
                                // Show a snackbar. This snackbar could also contain "Undo" actions.
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                    Text("tog bort element från listan")));
                              },
                              background: Container(
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text("Dölj",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                              child: Container(
                                color: Colors.white,

                                child: ListTile(
                                isThreeLine: true,
                                leading: Icon(assignment
                                    ? Icons.assignment
                                    : Icons.event),
                                trailing: DaysLeft(item.startAt),
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(courseFromCode[item.contextCode]),
                                    Text(timeFormat
                                        .format(item.startAt.toLocal())),
                                  ],
                                ),
                              ),
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                              height: 1,
                            ),
                          ],
                        ); else return Container();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget DaysLeft(DateTime date) {
  int diffDays = date.difference(DateTime.now()).inDays + 1;
  int diffHours = date.difference(DateTime.now()).inHours + 1;
  int diffMinutes = date.difference(DateTime.now()).inMinutes + 1;
  Color color;
  if (diffDays <= 1) {
    color = Colors.red;
  } else if (diffDays < 4) {
    color = Colors.orange;
  } else {
    color = Colors.green;
  }
  return Text(
      diffHours <= 1
          ? diffMinutes.toString() + "m"
          : diffDays <= 1
              ? diffHours.toString() + 'h'
              : diffDays.toString() + "d",
      style:
          TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w400));
}
