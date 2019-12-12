import 'dart:async';
import 'package:bloc/bloc.dart';
import './tab.dart';

import 'package:flutter_tutorial/data/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.courses;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
