// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repositories/local_db_repo.dart';
import 'package:todo_app/pages/home/bloc/todo_list_model.dart';

//abstract
abstract class TodoListState {
  final List<TodoListModel>? listTodo;
  TodoListState({this.listTodo});
}

abstract class TodoListEvent {}

//state
class InitTodoList extends TodoListState {}

class LoadingTodoList extends TodoListState {}

class LoadedTodoList extends TodoListState {
  final List<TodoListModel> listTodo;
  LoadedTodoList({required this.listTodo});
}

class SuccessChangeTodoList extends TodoListState {}

class ErrorChangeTodoList extends TodoListState {}

class EmptyTodoList extends TodoListState {}

class ErrorTodoList extends TodoListState {
  final String? msg;

  ErrorTodoList({this.msg});
}

//event
class FetchTodoList extends TodoListEvent {}

class ChangeStatus extends TodoListEvent {
  final TodoListModel model;
  final int status;
  ChangeStatus({required this.model, required this.status});
}

//bloc
class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  //Constructor
  TodoListBloc(TodoListState initialState) : super(initialState) {
    on<FetchTodoList>(_onFetchTodoList);
    on<ChangeStatus>(_onChangeStatus);
  }

  _onFetchTodoList(FetchTodoList event, Emitter<TodoListState> emit) async {
    emit(LoadingTodoList());
    try {
      //Checking if has data
      final hasData = await LocalDBRepo().todoHasData();
      if (hasData) {
        //fetch local db data
        final result = await LocalDBRepo().fetchTodoList();
        emit(LoadedTodoList(listTodo: result));
      } else {
        emit(EmptyTodoList());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorTodoList());
    }
  }

  _onChangeStatus(ChangeStatus event, Emitter<TodoListState> emit) async {
    var data = state.listTodo;
    try {
      //Change status local db data
      int index = data!.indexOf(event.model);
      await LocalDBRepo()
          .updateStatusList(id: data[index].id!, status: event.status);
      data[index] = data[index].copyWith(status: event.status);
      emit(SuccessChangeTodoList());
    } catch (e) {
      emit(ErrorChangeTodoList());
    }
    emit(LoadedTodoList(listTodo: data!));
  }
}
