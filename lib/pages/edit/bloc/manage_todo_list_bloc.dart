import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repositories/local_db_repo.dart';
import 'package:todo_app/pages/home/bloc/todo_list_model.dart';

//abstract
abstract class ManageTodoListState {}

abstract class ManageTodoListEvent {}

//state
class InitManageTodoList extends ManageTodoListState {}

class LoadingManageTodoList extends ManageTodoListState {}

class LoadedManageTodoList extends ManageTodoListState {}

class SucceesInsertTodoList extends ManageTodoListState {}

class SucceesUpdateTodoList extends ManageTodoListState {}

class SucceesDeleteTodoList extends ManageTodoListState {}

class ErrorInsertTodoList extends ManageTodoListState {
  final String? msg;

  ErrorInsertTodoList({this.msg});
}

class ErrorDeleteTodoList extends ManageTodoListState {
  final String? msg;

  ErrorDeleteTodoList({this.msg});
}

class ErrorUpdateTodoList extends ManageTodoListState {
  final String? msg;

  ErrorUpdateTodoList({this.msg});
}

//event
class InsertTodoList extends ManageTodoListEvent {
  final TodoListModel todoModel;
  InsertTodoList({required this.todoModel});
}

class UpdateTodoList extends ManageTodoListEvent {
  final TodoListModel todoModel;
  UpdateTodoList({required this.todoModel});
}

class DeleteTodoList extends ManageTodoListEvent {
  final TodoListModel todoModel;
  DeleteTodoList({required this.todoModel});
}

//bloc
class ManageTodoListBloc
    extends Bloc<ManageTodoListEvent, ManageTodoListState> {
  //Constructor
  ManageTodoListBloc(ManageTodoListState initialState) : super(initialState) {
    on<InsertTodoList>(_onInsertTodoList);
    on<UpdateTodoList>(_onUpdateTodoList);
    on<DeleteTodoList>(_onDeleteTodoList);
  }

  _onInsertTodoList(
      InsertTodoList event, Emitter<ManageTodoListState> emit) async {
    try {
      //Insert data to local db
      await LocalDBRepo().insertTodoList(todoModel: event.todoModel);
      emit(SucceesInsertTodoList());
    } catch (e) {
      emit(ErrorInsertTodoList());
    }
    emit(InitManageTodoList());
  }

  _onUpdateTodoList(
      UpdateTodoList event, Emitter<ManageTodoListState> emit) async {
    try {
      //Update data to local db
      await LocalDBRepo().updateList(model: event.todoModel);
      emit(SucceesUpdateTodoList());
    } catch (e) {
      emit(ErrorUpdateTodoList());
    }
    emit(InitManageTodoList());
  }

  _onDeleteTodoList(
      DeleteTodoList event, Emitter<ManageTodoListState> emit) async {
    try {
      //Update data to local db
      await LocalDBRepo().deleteTodo(model: event.todoModel);
      emit(SucceesDeleteTodoList());
    } catch (e) {
      emit(ErrorDeleteTodoList());
    }
    emit(InitManageTodoList());
  }
}
