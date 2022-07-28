import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/dependency_container.dart' as di;
import '../../bloc/tasks_cubit.dart';
import '../../common_task_components/task_tile.dart';

class UncompletedTaskScreen extends StatelessWidget {
  const UncompletedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()..getCompletedTasks(0),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          print(cubit.uncompletedTasks.length);
          return ListView.separated(
            itemCount: cubit.uncompletedTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: cubit.uncompletedTasks[index],
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
