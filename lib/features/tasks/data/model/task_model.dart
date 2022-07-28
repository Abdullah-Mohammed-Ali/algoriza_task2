import 'package:to_do_task2/constatns/String/tasks_tables_headers.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';

import '../../../../core/functions/bool_int_converter.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {super.id,
      required super.isFav,
      required super.color,
      required super.reminder,
      required super.repeat,
      required super.title,
      required super.date,
      required super.startTime,
      required super.endTime,
      required super.isCompleted});

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
        reminder: map[TasksTableHeader.reminder],
        repeat: map[TasksTableHeader.repeat],
        title: map[TasksTableHeader.title],
        date: map[TasksTableHeader.date],
        startTime: map[TasksTableHeader.startTime],
        endTime: map[TasksTableHeader.endTime],
        isFav: intToBool(map[TasksTableHeader.favorite]),
        isCompleted: intToBool(map[TasksTableHeader.completed]),
        id: map[TasksTableHeader.id],
        color: map[TasksTableHeader.color]);
  }

  Map<String, dynamic> toMap() {
    return {
      TasksTableHeader.title: title,
      TasksTableHeader.date: date,
      TasksTableHeader.startTime: startTime,
      TasksTableHeader.endTime: endTime,
      TasksTableHeader.repeat: repeat,
      TasksTableHeader.reminder: reminder,
      TasksTableHeader.color: color,
      TasksTableHeader.completed: boolToIntConverter(isCompleted),
      TasksTableHeader.favorite: boolToIntConverter(isFav),
    };
  }
}
