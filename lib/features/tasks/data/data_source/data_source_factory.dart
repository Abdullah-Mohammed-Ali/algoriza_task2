import 'package:dartz/dartz.dart';

abstract class DataSource<Type> {
  Future<Unit?> createTask(Type model);
  Future<List<Type>?> getTasks(String searchContent, String searchValue);
  Future<Unit?> updateTask(Type model);
  Future<Unit?> deleteTask(Type model);
}
