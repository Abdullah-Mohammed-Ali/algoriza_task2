import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_task2/features/tasks/presentation/common_task_components/task_tile.dart';

import '/dependency_container.dart' as di;
import '../../bloc/tasks_cubit.dart';

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()..getTasks(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          print(cubit.allTasks.length);
          return ListView.separated(
            itemCount: cubit.allTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: cubit.allTasks[index],
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
