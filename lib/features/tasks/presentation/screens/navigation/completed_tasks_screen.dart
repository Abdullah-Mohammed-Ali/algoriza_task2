import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/dependency_container.dart' as di;
import '../../bloc/tasks_cubit.dart';
import '../../common_task_components/task_tile.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()..getCompletedTasks(1),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          print(cubit.completedTasks.length);
          return ListView.separated(
            itemCount: cubit.completedTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: cubit.completedTasks[index],
                cubit: cubit,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15.h,
              );
            },
          );
        },
      ),
    );
  }
}
