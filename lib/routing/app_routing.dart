import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:to_do_task2/routing/routes_names.dart';

import '/dependency_container.dart' as di;
import '../features/tasks/presentation/screens/create_task_screen.dart';
import '../features/tasks/presentation/screens/navigation/board_navigation_screen.dart';

class AppRouting {
  static Route? onGenerateRoute(RouteSettings settings) {
    TasksCubit cubit = di.sl<TasksCubit>();
    switch (settings.name) {
      case AppRoutesNames.boardScreen:
        return fadeInPageBuilder(BlocProvider(
          create: (context) => cubit,
          child: BoardNavigationScreen(),
        ));
      case AppRoutesNames.createTaskScreen:
        return fadeInPageBuilder(BlocProvider(
          create: (context) => cubit,
          child: CreateTaskScreen(),
        ));
    }
  }

  static PageRouteBuilder fadeInPageBuilder(
    page, {
    durationMili = 750,
  }) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
        transitionsBuilder: (_, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: durationMili));
  }
}
