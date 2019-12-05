import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import './courses_model.dart';
import './course_assignments_model.dart';
import './calendar_assignment_model.dart';

class CourseCard extends StatelessWidget {
  final CanvasCourse course;
  final Future<List<CalendarAssignment>> assignments;

  final Map<String, Color> courseColor = {
    "Hållut": Colors.green,
    "ProSam åk3": Colors.pink,
    "ProSam åk1/åk2": Colors.pink,
    "ADK": Colors.blue,
    "Operativsystem": Colors.blueGrey,
    "Flervarren": Colors.blue
  };

  final locale = "sv_SE";
  DateFormat timeFormat;

  CourseCard(this.course, this.assignments) {
    initializeDateFormatting(locale).then((_) {
      timeFormat = DateFormat.MEd(locale).add_Hm();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            color: courseColor[course.name] ?? Colors.blueGrey,
            child: ListTile(
            title: Text(course.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),),
            subtitle: Text(course.courseCode, style: TextStyle(fontWeight: FontWeight.w200, color: Colors.white)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          )),
          FutureBuilder<List<CalendarAssignment>>(
              future: assignments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, id) {
                          CalendarAssignment assignment = snapshot.data[id];
                          if (assignment.allDayDate != null && assignment.allDayDate.isAfter(DateTime.now())) {
                            var divider;
                            if (id < snapshot.data.length-1) {
                              divider = new Divider(indent: 10, endIndent: 10, height: 1,);
                            } else {
                              divider = new Container();
                            }
                            return Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.assignment),
                                  title: Text(assignment.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  subtitle: assignment.assignment.dueAt != null ? Text(timeFormat.format(assignment.assignment.dueAt)) : "",
//                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                              divider,
                              ]);
                          } else {
                            return Container();
                          }
                        }
                      ),
                    ]);
                } else if (snapshot.hasError) {
                  return Text(snapshot.toString());
                }

                // By default, show a loading spinner.
                return Container();
              })
        ]),
    );
  }
}
