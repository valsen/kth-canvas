import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_tutorial/bloc/todo/todo_bloc.dart';

import './filtered_todos.dart';
import '../todo/todo.dart';
import '../../data/models/visibility_filter.dart';
import '../../todo_db_item.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateTodos((todosBloc.state as TodosLoaded).todoList));
      }
    });
  }

  @override
  FilteredTodosState get initialState {
    return todosBloc.state is TodosLoaded
        ? FilteredTodosLoaded(
          _mapTodosToFilteredTodos(
            (todosBloc.state as TodosLoaded).todoList,
            VisibilityFilter.active,
            ),
            VisibilityFilter.active
          )
        : FilteredTodosLoading();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(
    FilteredTodosEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapUpdateTodosToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(UpdateFilter event) async* {
    if (todosBloc.state is TodosLoaded) {
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoaded).todoList,
          event.filter
        ),
        event.filter
      );
    }
  }

  List<Todo> _mapTodosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.inactive) {
        return !todo.active;
      } else {
        return todo.active;
      }
    }).toList();
  }

  Stream<FilteredTodosState> _mapUpdateTodosToState(UpdateTodos event) async* {
    final visibilityFilter = state is FilteredTodosLoaded
      ? (state as FilteredTodosLoaded).activeFilter
      : VisibilityFilter.active; //should be all!
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoaded).todoList,
          visibilityFilter,
        ),
        visibilityFilter,
    );
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
