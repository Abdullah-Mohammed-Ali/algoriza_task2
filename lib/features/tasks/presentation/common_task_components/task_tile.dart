import 'package:flutter/material.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';

import '../../../../constatns/colors.dart';
import '../../domain/entity/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
    required this.cubit,
  }) : super(key: key);
  final TaskEntity task;
  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    Color taskColor =
        AppColors.getColorForTask(task.color) ?? AppColors.taskYellow;
    return Container(
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            Checkbox(
              value: task.isCompleted,
              fillColor: MaterialStateProperty.all(taskColor),
              onChanged: (value) async {
                task.isCompleted = value!;
                await cubit.updatetask(task);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: taskColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                task.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.textSelected),
              ),
            )
          ],
        ));
  }
}
