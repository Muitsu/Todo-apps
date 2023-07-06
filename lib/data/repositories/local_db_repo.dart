import 'package:todo_app/data/local_db/tables/db_fields.dart';
import 'package:todo_app/pages/home/bloc/todo_list_model.dart';
import '../local_db/db_manager.dart';

//Class for collection of sql query
class LocalDBRepo {
  DBManager instance = DBManager.instance;
  Future<bool> todoHasData() async {
    final db = await instance.database;
    final data = await db.rawQuery('SELECT * FROM ${TodoFields.tableName}');

    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> insertTodoList({required TodoListModel todoModel}) async {
    final db = await instance.database;
    await db.insert(TodoFields.tableName, todoModel.toJson());
  }

  Future<List<TodoListModel>> fetchTodoList() async {
    final db = await instance.database;
    final data = await db.rawQuery(
        'SELECT * FROM ${TodoFields.tableName} ORDER BY ${TodoFields.id} ASC');

    if (data.isNotEmpty) {
      return data.map((json) => TodoListModel.fromJson(json)).toList();
    } else {
      throw Exception('ID not found');
      // return null;
    }
  }

  Future<void> updateList({required TodoListModel model}) async {
    final db = await instance.database;
    await db.rawUpdate(
        'UPDATE ${TodoFields.tableName} SET ${TodoFields.title} = ?, ${TodoFields.startDate} = ?, ${TodoFields.endDate} = ?  WHERE ${TodoFields.id} = ?',
        [model.title, model.startDate, model.endDate, model.id]);
  }

  Future<void> updateStatusList({
    required int id,
    required int status,
  }) async {
    final db = await instance.database;
    await db.rawUpdate(
        'UPDATE ${TodoFields.tableName} SET ${TodoFields.status} = ?  WHERE ${TodoFields.id} = ?',
        [status, id]);
  }

  Future<void> deleteTodo({required TodoListModel model}) async {
    final db = await instance.database;
    await db.rawDelete(
        'DELETE FROM ${TodoFields.tableName} WHERE ${TodoFields.id} = ${model.id}');
  }
}
