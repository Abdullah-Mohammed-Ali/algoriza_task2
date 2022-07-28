import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_task2/constatns/String/tasks_tables_headers.dart';
import 'package:to_do_task2/features/tasks/data/data_source/tasks_data_source.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/get_tasks_use_case.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/update_task_use_case.dart';

import 'constatns/String/paths.dart';
import 'core/data/notification_helper.dart';
import 'features/tasks/data/repo_impl/tasks_repo_impl.dart';
import 'features/tasks/domain/use_case/create_task_use_case.dart';
import 'features/tasks/domain/use_case/delete_task_use_case.dart';
import 'features/tasks/domain/use_case/notification_use_cases.dart';
import 'features/tasks/presentation/bloc/tasks_cubit.dart';

var sl = GetIt.instance;
Future<void> init() async {
  // tasks bloc...
  sl.registerFactory(() => TasksCubit(sl(), sl(), sl(), sl()));

  // Use cases for
  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<TasksRepoImpl>(() => TasksRepoImpl(sl()));

  // Data Base

  var database = await openDatabase(Paths.dataBasePath, version: 1,
      onCreate: (db, version) async {
    await db.execute(
        "Create TABLE $taskTableName (${TasksTableHeader.id} INTEGER PRIMARY KEY , ${TasksTableHeader.title} STRING ,${TasksTableHeader.startTime} STRING,${TasksTableHeader.endTime} STRING ,${TasksTableHeader.date} STRING,"
        "${TasksTableHeader.repeat} STRING,${TasksTableHeader.reminder} STRING, ${TasksTableHeader.color} STRING, ${TasksTableHeader.completed} INTEGER, ${TasksTableHeader.favorite} INTEGER)");
  }, onOpen: (db) {
    print('open database');
  });
  //data source
  sl.registerLazySingleton(() => TasksDataSource(database));

  sl.registerLazySingleton(() => ScheduledNotificationUseCase(sl()));
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final notification = NotificationHelper(notificationsPlugin);
  await notification.initNotifications();

  sl.registerLazySingleton<NotificationHelper>(() => notification);
}
