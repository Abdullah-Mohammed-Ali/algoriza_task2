part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TaskCreateSuccess extends TasksState {}

class TabBarChange extends TasksState {}

class TaskCreateFail extends TasksState {
  final String msg;

  TaskCreateFail(this.msg);
}
