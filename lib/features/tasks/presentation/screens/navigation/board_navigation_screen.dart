import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task2/constatns/colors.dart';

import '../../../../../core/common_components/app_bar.dart';
import '../../../../../routing/routes_names.dart';
import '../../bloc/tasks_cubit.dart';
import '../../common_task_components/task_button.dart';

class BoardNavigationScreen extends StatefulWidget {
  BoardNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BoardNavigationScreen> createState() => _BoardNavigationScreenState();
}

class _BoardNavigationScreenState extends State<BoardNavigationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        var tasksCubit = TasksCubit.get(context);
        return DefaultScaffold(
          tabBarExists: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
            child: tasksCubit.screens[tasksCubit.tabBarIndex],
          ),
          actionButton: ElevatedTaskButton(
            title: 'Create Task',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesNames.createTaskScreen);
            },
          ),
          title: 'Board',
          tickerProvider: this,
          cubit: tasksCubit,
        );
      },
    );
  }
}

class DefaultScaffold extends StatelessWidget {
  DefaultScaffold({
    Key? key,
    required this.body,
    required this.actionButton,
    required this.title,
    this.tabBarExists = false,
    this.tickerProvider,
    this.height = 80,
    this.width = 20,
    required this.cubit,
  }) : super(key: key);
  final Widget body;
  bool tabBarExists;
  double height;
  double width;
  final TasksCubit cubit;
  final Widget actionButton;
  final String title;
  TickerProvider? tickerProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: generalAppBar(
        tabBarExists: tabBarExists,
        tickerProvider: tickerProvider,
        context: context,
        title: title,
        height: height,
        width: width,
        cubit: cubit,
      ),
      body: body,
      floatingActionButton: actionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
