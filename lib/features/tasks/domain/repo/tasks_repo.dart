import 'package:dartz/dartz.dart';

import '../../../../error_handling/failures.dart';

abstract class TasksRepo<Type> {
  Future<Either<Failures, Unit?>?> createTask(Type type);
  Future<Either<Failures, List<Type>?>?> getTasks(String searchField,String searchValue);
  Future<Either<Failures, Unit?>?> updateTask(Type type);
  Future<Either<Failures, Unit?>?> deleteTask(Type type);
}
