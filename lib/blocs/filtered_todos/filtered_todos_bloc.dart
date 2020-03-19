import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_tutorial/blocs/blocs.dart';
import 'package:flutter_tutorial/data/models/models.dart';


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
            VisibilityFilter.active)
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

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (todosBloc.state is TodosLoaded) {
      yield FilteredTodosLoaded(
          _mapTodosToFilteredTodos(
              (todosBloc.state as TodosLoaded).todoList, event.filter),
          event.filter);
    }
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    final List<Todo> filtered = todos.where((todo) {
      if (todo.startAt.isAfter(DateTime.now())) {
        if (filter == VisibilityFilter.inactive) {
          return !todo.active;
        } else {
          return todo.active;
        }
      } else {
        return false;
      }
    }).toList();
    filtered.sort((a, b) => a.startAt.compareTo(b.startAt));
    return filtered;
  }

  Stream<FilteredTodosState> _mapUpdateTodosToState(UpdateTodos event) async* {
    final visibilityFilter = state is FilteredTodosLoaded
        ? (state as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.active;
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
