import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_task2/constatns/String/tasks_tables_headers.dart';
import 'package:to_do_task2/error_handling/exceptions.dart';
import 'package:to_do_task2/features/tasks/data/data_source/data_source_factory.dart';

import '../model/task_model.dart';

class TasksDataSource extends DataSource<TaskModel> {
  final Database _database;

  TasksDataSource(this._database);
  @override
  Future<Unit?> createTask(model) async {
    try {
      await _database.transaction((txn) async {
        return await txn.insert(taskTableName, model.toMap());
      });
    } catch (e) {
      throw DataSourceException(e.toString());
    }
  }

  @override
  Future<Unit?> deleteTask(model) async {
    try {
      print(model.id);
      await _database.transaction((txn) async {
        return await txn.delete(
          taskTableName,
          where: '${TasksTableHeader.id} = ?',
          whereArgs: [model.id],
        );
      });
    } catch (e) {
      throw DataSourceException(e.toString());
    }
  }

  @override
  Future<List<TaskModel>?> getTasks(
      String searchField, dynamic searchValue) async {
    try {
      var fetchedData;
      if (searchValue == '' && searchField == '') {
        fetchedData = await _database.rawQuery('SELECT * FROM $taskTableName');
      } else {
        fetchedData = await _database.rawQuery(
            'SELECT * FROM tasks WHERE `$searchField` = $searchValue');
      }

      List<TaskModel> result = [];
      fetchedData.forEach((e) => result.add(TaskModel.fromMap(e)));
      return result;
    } catch (e) {
      print(e);
      throw DataSourceException(e.toString());
    }
  }

  @override
  Future<Unit?> updateTask(model) async {
    try {
      await _database.transaction((txn) async {
        return await txn.update(taskTableName, model.toMap(),
            where: '${TasksTableHeader.id} = ?', whereArgs: [model.id]);
      });
    } catch (e) {
      throw DataSourceException(e.toString());
    }
  }
}
