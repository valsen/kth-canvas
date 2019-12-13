import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_tutorial/data/models/models.dart';

typedef OnSaveCallback = Function(Todo todo);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddEditScreen({this.isEditing, this.onSave, this.todo});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  List<CanvasCourse> _courseList;
  CanvasCourse _course;
  DateTime _firstDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String _type;
  String _title;

  @override
  Widget build(BuildContext context) {
    _courseList = (BlocProvider.of<TodosBloc>(context).state as TodosLoaded).courseList;
    _course = _courseList[0];
    return Scaffold(
      appBar: AppBar(
        title: Text('Lägg till'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Form(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextField(
                    onChanged: (title) {
                      setState(() {
                        _title = title;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Titel",
                    ),
                  ),
                  
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: "event",
                            groupValue: _type,
                            onChanged: (type) {
                              setState(() {
                                _type = type;
                              });
                            },
                          ),
                          Text('Händelse'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: "assignment",
                            groupValue: _type,
                            onChanged: (type) {
                              setState(() {
                                _type = type;
                              });
                            },
                          ),
                          Text('Uppgift'),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    child: CupertinoPicker(

                      useMagnifier: false,
                      diameterRatio: 2,
                      backgroundColor: Colors.white,//Theme.of(context).canvasColor,
                      itemExtent: 40,
                      children: _courseList
                          .map((course) => DropdownMenuItem(
                              key: Key(course.id.toString()),
                              value: course,
                              child: Center(child: Text(course.name))))
                          .toList(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _course = (BlocProvider.of<TodosBloc>(context).state as TodosLoaded)
                          .courseList[index];
                        });
                      },
                    ),
                    
                  ),
                  Container(
                    height: 170,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,//Theme.of(context).canvasColor,
                    use24hFormat: true,

                    initialDateTime: _firstDate,
                    maximumDate: _firstDate.add(Duration(days: 100)),
                    // selectedDate: _selectedDate,
                    onDateTimeChanged: (deadline) {
                      setState(() {
                        _selectedDate = deadline;
                      });
                      print(deadline);
                    },
                  ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                'Spara',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Todo todo = Todo(
                  id: Random().nextInt(1000000),
                  startAt: _selectedDate,
                  title: _title,
                  active: true,
                  courseId: _course.id,
                  type: _type
                );
                // print(todo.toMap());
                widget.onSave(todo);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}