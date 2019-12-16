import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/data/models/models.dart';

typedef OnSaveCallback = Function(Todo todo);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;
  final CupertinoTabController controller;

  AddEditScreen({this.isEditing, this.onSave, this.todo, this.controller});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  List<CanvasCourse> _courseList;
  CanvasCourse _course;
  static DateTime _now = DateTime.now();
  DateTime _firstDate = DateTime(_now.year, _now.month, _now.day, _now.hour);
  DateTime _selectedDate = DateTime.now();
  String _type;
  String _title;

  @override
  void initState() {
    super.initState();
    _courseList =
        (BlocProvider.of<TodosBloc>(context).state as TodosLoaded).courseList;
    _course = _courseList.first;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Lägg till'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            // fillOverscroll: true,
              // BEGINNING OF NEW CONTENT
              child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CupertinoSegmentedControl(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      borderColor: Colors.blueGrey,
                      selectedColor: Colors.blueGrey,
                      children: {
                        "event": Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Text('Händelse',
                                style: TextStyle(fontSize: 18))),
                        "assignment": Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child:
                                Text('Uppgift', style: TextStyle(fontSize: 18)))
                      },
                      groupValue: _type,
                      onValueChanged: (type) {
                        setState(() {
                          _type = type;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  // width: 300,
                  child: CupertinoTextField(
                    style: TextStyle(fontSize: 20),

                    // padding: EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    onChanged: (title) {
                      setState(() {
                        _title = title;
                      });
                    },
                    prefix: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Titel',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )),
                    prefixMode: OverlayVisibilityMode.notEditing,
                  ),
                ),
                Container(
                  height: 140,
                  child: CupertinoPicker(
                    useMagnifier: false,
                    diameterRatio: 2,
                    backgroundColor: Colors.white,
                    itemExtent: 40,
                    children: _courseList
                        .map((course) => DropdownMenuItem(
                            key: Key(course.id.toString()),
                            value: course,
                            child: Center(child: Text(course.name))))
                        .toList(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        print(_courseList[index].toMap());
                        _course = _courseList[index];
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 170,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    use24hFormat: true,
                    initialDateTime: _firstDate,
                    minimumDate: _firstDate,
                    maximumDate: _firstDate.add(Duration(days: 100)),
                    onDateTimeChanged: (deadline) {
                      setState(() {
                        _selectedDate = deadline;
                      });
                      print(deadline);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text(
                        'Avbryt',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoButton(
                      child: Text(
                        'Spara',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Todo todo = Todo(
                            id: Random().nextInt(1000000),
                            startAt: _selectedDate,
                            title: _title,
                            active: true,
                            courseId: _course.id,
                            type: _type);
                        print(todo.toMap());
                        // TODO: figure out why FilteredTodosBloc doesn't update automatically after AddTodo event
                        widget.onSave(todo);
                        BlocProvider.of<FilteredTodosBloc>(context).add(
                            UpdateTodos((BlocProvider.of<TodosBloc>(context)
                                    .state as TodosLoaded)
                                .todoList));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
