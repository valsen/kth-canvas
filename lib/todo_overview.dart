import 'package:flutter/material.dart';
import 'package:flutter_tutorial/upcoming_events_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class TodoOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoOverviewState();
  }
}

class _TodoOverviewState extends State<TodoOverview> {
  String token = "8779~KzUQiD6KASsiotpodfWzwBu1xCI8nCbkNgUgRslXKQl5sI7o4IKQQFSVbGiPZc1E";
  Future<List<UpcomingEvent>> _upcoming;

  Map<String, String> courseFromCode = {
    "course_16720": "Hållut",
    "course_12404": "ADK"
  };

  final locale = "sv_SE";
  DateFormat timeFormat;

  @override
  void initState() {
    super.initState();
    _upcoming = getUpcomingEvents();
    initializeDateFormatting(locale).then((_) {
      timeFormat = DateFormat.MMMEd(locale).add_Hm();
    });
  }

  Future<List<UpcomingEvent>> getUpcomingEvents() async {
    String url = "https://kth.instructure.com/api/v1/users/self/upcoming_events";
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
    return FutureBuilder<List<UpcomingEvent>>(
      future: _upcoming,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (context, id) {
                  UpcomingEvent event = snapshot.data[id];
                  bool assignment = event.assignment != null;
                  return Column(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(assignment ? Icons.assignment : Icons.event),
                            trailing: DaysLeft(event.startAt),
                            title: Text(event.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(courseFromCode[event.contextCode]),
                                  Text(timeFormat.format(event.startAt)),
                                ])),
                        Divider(thickness: 0.5,)]);
                },
              ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(
            child: CircularProgressIndicator());
      },
    );;
  }
}

Widget DaysLeft(DateTime date) {
  int diffDays = date.difference(DateTime.now()).inDays;
  int diffHours = date.difference(DateTime.now()).inHours;
  int diffMinutes = date.difference(DateTime.now()).inMinutes;
  Color color;
  if (diffDays == 0) {
    color = Colors.red;
  } else if (diffDays <= 3) {
    color = Colors.orange;
  } else {
    color = Colors.green;
  }
  return Text(
      diffHours < 1 ? diffMinutes.toString() + "m" :
      diffDays < 1 ? diffHours.toString() + 'h' :
      diffDays.toString() + "d",
      style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w400));
}

