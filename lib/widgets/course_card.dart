import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../data/models/courses_model.dart';
import '../data/models/calendar_assignment_model.dart';
import '../data/database.dart';
import '../data/models/calendar_assignment_db_model.dart';

class CourseCard extends StatefulWidget {
  final CanvasCourse course;
  final Future<List<CalendarAssignment>> assignmentsFuture;

  CourseCard({Key key, this.course, this.assignmentsFuture}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseCardState();
  }
}

class _CourseCardState extends State<CourseCard> {
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

  _CourseCardState() {
    initializeDateFormatting(locale).then((_) {
      timeFormat = DateFormat.MEd(locale).add_Hm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // course info
          CourseHeader(),
          // list of assignments
          FutureBuilder<List<CalendarAssignment>>(
              future: widget.assignmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, id) {
                          CalendarAssignment assignment = snapshot.data[id];
                          if (assignment.assignment.dueAt?.isAfter(DateTime.now()) &&
                              !assignment.assignment.userSubmitted) {
                            var divider;
                            if (id < snapshot.data.length - 1) {
                              divider = new Divider(
                                indent: 10,
                                endIndent: 10,
                                height: 1,
                              );
                            } else {
                              divider = new Container();
                            }
                            Future<bool> hidden = DBProvider.db
                                .getAssignment(assignment.id)
                                .then((res) {
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
                                  if (!snap.data) {
                                    return Column(children: [
                                      DismissableCourse(snapshot, id),
                                      divider,
                                    ]);
                                  } else
                                    return Container();
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        })
                  ]);
                } else if (snapshot.hasError) {
                  return Text(snapshot.toString());
                }
                // By default, show a loading spinner.
                return Container();
              }),
        ],
      ),
    );
  }

  Widget CourseHeader() {
    return
      Container(
        color: courseColor[widget.course.name] ?? Colors.blueGrey,
        child: ListTile(
          title: Text(
            widget.course.name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
          subtitle: Text(widget.course.courseCode,
              style: TextStyle(
                  fontWeight: FontWeight.w200, color: Colors.white)),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ),
      );
  }

  Widget DismissableCourse(snapshot, id) {
    CalendarAssignment assignment = snapshot.data[id];
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(
          assignment.id.toString(),
      ),
      onDismissed: (direction) {
        setState(() {
          snapshot.data.removeAt(id);
        });
        DBProvider.db.insertAssignment(
            DBAssignment.fromMap(
                {"id": assignment.id}));
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "tog bort element från listan")));
      },
      background: SwipeBackground(),
      child: ListTile(
        leading: Icon(Icons.assignment),
        title: Text(
          assignment.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: assignment.assignment.dueAt != null
            ? Text(timeFormat.format(assignment.assignment.dueAt.toLocal()))
            : "",
      ),
    );
  }

  Widget SwipeBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin:
            EdgeInsets.only(right: 20),
            child: Text("Dölj",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.w500,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
