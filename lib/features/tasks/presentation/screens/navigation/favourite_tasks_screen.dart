import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/dependency_container.dart' as di;
import '../../../../../constatns/String/tasks_tables_headers.dart';
import '../../bloc/tasks_cubit.dart';
import '../../common_task_components/task_tile.dart';

class FavouriteTasksScreen extends StatelessWidget {
  const FavouriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>()
        ..getTasks(field: TasksTableHeader.favorite, value: 1),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          print(cubit.favTasks.length);
          return ListView.separated(
            itemCount: cubit.favTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: cubit.favTasks[index],
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
