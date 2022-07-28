import 'package:dartz/dartz.dart';
import 'package:to_do_task2/error_handling/failures.dart';
import 'package:to_do_task2/features/tasks/data/data_source/tasks_data_source.dart';
import 'package:to_do_task2/features/tasks/data/model/task_model.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';

import '../../domain/repo/tasks_repo.dart';

class TasksRepoImpl extends TasksRepo<TaskEntity> {
  final TasksDataSource _dataSource;

  TasksRepoImpl(this._dataSource);
  @override
  Future<Either<Failures, Unit?>?> createTask(TaskEntity task) async {
    TaskModel taskModel = TaskModel(
      reminder: task.reminder,
      repeat: task.repeat,
      title: task.title,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      isFav: task.isFav,
      isCompleted: task.isCompleted,
      color: task.color,
      id: task.id,
    );
    try {
      Unit? result = await _dataSource.createTask(taskModel);

      print('repo');

      return Right<Failures, Unit?>(result);
    } catch (e) {
      print('repo error');

      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Unit>?> deleteTask(task) async {
    TaskModel taskModel = TaskModel(
      reminder: task.reminder,
      repeat: task.repeat,
      title: task.title,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      isFav: task.isFav,
      isCompleted: task.isCompleted,
      color: task.color,
      id: task.id,
    );
    try {
      var result = await _dataSource.deleteTask(taskModel);

      if (result is Unit) {
        return Right<Failures, Unit>(result);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<TaskEntity>?>?> getTasks(
      String searchField, dynamic searchValue) async {
    try {
      print(searchValue);
      print(searchField);
      return await _dataSource.getTasks(searchField, searchValue).then((value) {
        List<TaskEntity>? result = value;
        Right<Failures, List<TaskEntity>?> rightResult = Right(result);
        return rightResult;
      });
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, Unit?>?> updateTask(task) async {
    TaskModel taskModel = TaskModel(
      reminder: task.reminder,
      repeat: task.repeat,
      title: task.title,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      isFav: task.isFav,
      isCompleted: task.isCompleted,
      color: task.color,
      id: task.id,
    );
    try {
      Unit? result = await _dataSource.updateTask(taskModel);

      return Right<Failures, Unit?>(result);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
