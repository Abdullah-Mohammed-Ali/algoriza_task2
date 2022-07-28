import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_task2/constatns/String/tasks_tables_headers.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/presentation/screens/navigation/all_task_screen.dart';

import '../../domain/use_case/create_task_use_case.dart';
import '../../domain/use_case/delete_task_use_case.dart';
import '../../domain/use_case/get_tasks_use_case.dart';
import '../../domain/use_case/update_task_use_case.dart';
import '../screens/navigation/completed_tasks_screen.dart';
import '../screens/navigation/favourite_tasks_screen.dart';
import '../screens/navigation/uncompleted_task_screen.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._createTaskUseCase, this._updateTaskUseCase,
      this._deleteTaskUseCase, this._getTasksUseCase)
      : super(TasksInitial());

  int tabBarIndex = 0;
  static TasksCubit get(context) => BlocProvider.of(context);

  void changeTabBarScreen(index) {
    tabBarIndex = index;
    emit(TabBarChange());
  }

  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final GetTasksUseCase _getTasksUseCase;

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var repeatController = TextEditingController();
  var reminderController = TextEditingController();
  String taskColor = '';

  List<TaskEntity> allTasks = [];
  List<TaskEntity> completedTasks = [];
  List<TaskEntity> uncompletedTasks = [];
  List<TaskEntity> favTasks = [];

  List<Widget> screens = [
    AllTaskScreen(),
    CompletedTasksScreen(),
    UncompletedTaskScreen(),
    FavouriteTasksScreen()
  ];
  Future<Unit?> createTask(TaskEntity task) async {
    CreateParameters parameters = CreateParameters(task);
    print('click');
    var result = await _createTaskUseCase.call(parameters);
    result?.fold(
      (l) => print(l.msg),
      (r) => print('created'),
    );
  }

  Map<DateTime, List<TaskEntity>> groups = {};
  Future<Unit?> getTasks({String? field, dynamic value}) async {
    GetTasksParameters parameters;
    if (field == TasksTableHeader.favorite) {
      parameters = GetTasksParameters(TasksTableHeader.favorite, 1);
    } else {
      parameters = GetTasksParameters('', '');
    }
    print('click');
    var result = await _getTasksUseCase.call(parameters);
    print(result);
    result?.fold(
      (l) {
        print(l.msg);

        emit(TaskCreateFail(l.msg));
      },
      (r) {
        print('got it');
        if (field == TasksTableHeader.favorite) {
          favTasks = r ?? [];
        } else {
          allTasks = r ?? [];
        }
        print(r);
        emit(TaskCreateSuccess());
      },
    );
  }

  Future<Unit?> getCompletedTasks(int value) async {
    late GetTasksParameters parameters;
    if (value == 0) {
      parameters = GetTasksParameters(TasksTableHeader.completed, 0);
    } else if (value == 1) {
      parameters = GetTasksParameters(TasksTableHeader.completed, 1);
    }
    var result = await _getTasksUseCase.call(parameters);
    print(result);
    result?.fold(
      (l) {
        print(l.msg);

        emit(TaskCreateFail(l.msg));
      },
      (r) {
        print('got it');
        if (value == 1) {
          completedTasks = r ?? [];
        } else if (value == 0) uncompletedTasks = r ?? [];

        print(r);
        emit(TaskCreateSuccess());
      },
    );
  }

  Future<Unit?> updatetask(TaskEntity task) async {
    UpdateParameters parameters = UpdateParameters(task);
    print('click');
    var result = await _updateTaskUseCase.call(parameters);
    result?.fold(
      (l) => print(l.msg),
      (r) => print('created'),
    );
    await getTasks();
  }

  Future<Unit?> deleteTask(TaskEntity task) async {
    DeleteParameters parameters = DeleteParameters(task);
    print('click');
    var result = await _deleteTaskUseCase.call(parameters);
    result?.fold(
      (l) => print(l.msg),
      (r) => print('Deleted'),
    );
    await getTasks();
  }
}
