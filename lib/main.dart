import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_task2/constatns/colors.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:to_do_task2/routing/app_routing.dart';
import 'package:to_do_task2/routing/routes_names.dart';

import '/dependency_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()..getTasks(),
      child: ScreenUtilInit(
          designSize: const Size(360, 750),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'To-do',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: AppColors.main,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.light),
                ),
              ),
              onGenerateRoute: AppRouting.onGenerateRoute,
              initialRoute: AppRoutesNames.boardScreen,
            );
          }),
    );
  }
}
