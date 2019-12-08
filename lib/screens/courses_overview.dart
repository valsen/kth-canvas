import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/models/calendar_assignment_model.dart';
import 'package:flutter_tutorial/widgets/course_card.dart';
import 'package:flutter_tutorial/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/models/courses_model.dart';

class CoursesOverview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CoursesOverviewState();
  }
}

class _CoursesOverviewState extends State<CoursesOverview> {
  String url = "https://kth.instructure.com/api/v1/users/self";
  String token = "8779~KzUQiD6KASsiotpodfWzwBu1xCI8nCbkNgUgRslXKQl5sI7o4IKQQFSVbGiPZc1E";
  Future<List<CanvasCourse>> _courses;
  Future<CanvasUser> _user;


  Future<CanvasUser> getUser() async{
    String url = "https://kth.instructure.com/api/v1/users/self";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return userFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }

  final locale = "sv_SE";
  DateFormat timeFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courses = getCourses();
//    _user = getUser();
  }

  Future<CanvasCourse> getCourse(int id) async {
    String url = "https://kth.instructure.com/api/v1/courses/" + id.toString();
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return CanvasCourse.fromJson(json.decode(res.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load course');
    }
  }

  Future<List<CanvasCourse>> getCourses() async {
    String url = "https://kth.instructure.com/api/v1/users/self/favorites/courses";
    var res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return canvasCoursesFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load courses');
    }
  }

  Future<List<CalendarAssignment>> getCalendarAssignments(id) async {
    Uri _url = Uri.https(
      'kth.instructure.com',
      '/api/v1/calendar_events',
      {
        'all_events': '1',
        'context_codes[]': 'course_$id',
        'type': 'assignment',
        'excludes[]': 'description',
        'per_page': '100',
      },
    );

    var res = await http.get(_url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (res.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return calendarAssignmentsFromJson(res.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load calendar assignments');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_courses == null) {
      return Center(child: CircularProgressIndicator());
    }
    return FutureBuilder<List<CanvasCourse>>(
      future: _courses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, id) {
                        CanvasCourse course = snapshot.data[id];
                        return CourseCard(
                            course: course,
                            assignmentsFuture: getCalendarAssignments(course.id),
                        );
                      },
                    ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(
              child: CircularProgressIndicator());
        },
    );
  }
}