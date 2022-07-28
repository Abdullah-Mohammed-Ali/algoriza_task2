import 'package:flutter/material.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';

import '../../../../constatns/colors.dart';
import '../../domain/entity/task.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    Key? key,
    required this.task,
    required this.cubit,
  }) : super(key: key);
  final TaskEntity task;
  final TasksCubit cubit;
  late Offset tapDownDetails;

  @override
  Widget build(BuildContext context) {
    Color taskColor =
        AppColors.getColorForTask(task.color) ?? AppColors.taskYellow;
    return Container(
        height: 60,
        width: double.infinity,
        child: GestureDetector(
          onLongPress: () {
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    tapDownDetails.dx, tapDownDetails.dy, 0, 0),
                items: [
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () async {
                            await cubit.deleteTask(task);
                            Navigator.pop(context);
                          },
                          child: Text('Delete')))
                ]);
          },
          onTapDown: (details) {
            tapDownDetails = details.globalPosition;
          },
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
              ),
              IconButton(
                  onPressed: () async {
                    task.isFav = !task.isFav;
                    await cubit.updatetask(task);
                  },
                  icon: task.isFav
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border))
            ],
          ),
        ));
  }
}
