import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_task2/constatns/String/create_labels_hints_texts.dart';
import 'package:to_do_task2/constatns/String/errors_validate.dart';
import 'package:to_do_task2/constatns/String/reminder_repeating_map.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';
import 'package:to_do_task2/features/tasks/presentation/screens/navigation/board_navigation_screen.dart';

import '../../../../constatns/colors.dart';
import '../../../../core/functions/get_time_date.dart';
import '../../../../core/functions/reminder_repeating_get.dart';
import '../common_task_components/icons.dart';
import '../common_task_components/task_button.dart';
import '../common_task_components/text_form_field.dart';

class CreateTaskScreen extends StatefulWidget {
  CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        var cubit = TasksCubit.get(context);
        return DefaultScaffold(
          height: 60,
          width: 0,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    EditingTile(
                      content: AppTextField(
                        validateErrorMessage: emptyMsg,
                        hintText: LabelsHintsTexts.titleHint,
                        cubit: cubit,
                        controller: cubit.titleController,
                      ),
                      title: LabelsHintsTexts.title,
                    ),
                    EditingTile(
                      content: AppTextField(
                        validateErrorMessage: emptyMsg,
                        icon: kDropDownMenuIcon,
                        hintText: LabelsHintsTexts.dateHint,
                        cubit: cubit,
                        readOnly: true,
                        onTap: () async {
                          String? testDate = await getDate(context);
                          cubit.dateController.text = testDate ?? '';
                        },
                        controller: cubit.dateController,
                      ),
                      title: LabelsHintsTexts.date,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EditingTile(
                          width: 145.w,
                          content: AppTextField(
                            validateErrorMessage: emptyMsg,
                            icon: kTimeIcon,
                            hintText: LabelsHintsTexts.startTimeHint,
                            cubit: cubit,
                            readOnly: true,
                            onTap: () async {
                              String? test = await getTime(context);
                              cubit.startTimeController.text = test ?? '';
                              print(test);
                            },
                            controller: cubit.startTimeController,
                          ),
                          title: LabelsHintsTexts.startTime,
                        ),
                        EditingTile(
                          width: 145.w,
                          content: AppTextField(
                            validateErrorMessage: emptyMsg,
                            icon: kTimeIcon,
                            readOnly: true,
                            onTap: () async {
                              String? test = await getTime(context);
                              cubit.endTimeController.text = test ?? '';
                            },
                            hintText: LabelsHintsTexts.endTimeHint,
                            cubit: cubit,
                            controller: cubit.endTimeController,
                          ),
                          title: LabelsHintsTexts.endTime,
                        ),
                      ],
                    ),
                    EditingTile(
                      content: AppTextField(
                        icon: kDropDownMenuIcon,
                        readOnly: true,
                        onTap: () async {
                          String? reminder =
                              await buildShowDialog(context, remindList);
                          cubit.reminderController.text = reminder ?? '';
                        },
                        hintText: LabelsHintsTexts.reminderHint,
                        cubit: cubit,
                        controller: cubit.reminderController,
                        validateErrorMessage: emptyMsg,
                      ),
                      title: LabelsHintsTexts.reminder,
                    ),
                    EditingTile(
                      content: AppTextField(
                        validateErrorMessage: emptyMsg,
                        icon: kDropDownMenuIcon,
                        readOnly: true,
                        onTap: () async {
                          String? repeat =
                              await buildShowDialog(context, repeatList);
                          cubit.repeatController.text = repeat ?? '';
                        },
                        hintText: LabelsHintsTexts.repeatHint,
                        cubit: cubit,
                        controller: cubit.repeatController,
                      ),
                      title: LabelsHintsTexts.repeat,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 40.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppColors.taskColors.length,
                          itemExtent: 60,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                cubit.taskColor =
                                    AppColors.taskColors.keys.toList()[index];
                                setState(() {});
                                AppColors.isColorChecked
                                    .setAll(0, AppColors.colorCheckedClearList);
                                AppColors.isColorChecked[index] =
                                    !AppColors.isColorChecked[index];
                                print(cubit.taskColor);
                              },
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    AppColors.taskColors.values.toList()[index],
                                child: AppColors.isColorChecked[index]
                                    ? Icon(Icons.check)
                                    : null,
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
          actionButton: ElevatedTaskButton(
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  cubit.taskColor.isNotEmpty) {
                TaskEntity task = TaskEntity(
                    color: cubit.taskColor,
                    isCompleted: false,
                    isFav: false,
                    reminder: cubit.reminderController.text,
                    repeat: cubit.repeatController.text,
                    title: cubit.titleController.text,
                    date: cubit.dateController.text,
                    startTime: cubit.startTimeController.text,
                    endTime: cubit.endTimeController.text);
                await cubit.createTask(task);
              }
            },
            title: 'Create a Task',
          ),
          title: 'Add Task', cubit: cubit,
        );
      },
    );
  }
}

class EditingTile extends StatelessWidget {
  EditingTile({
    Key? key,
    this.width = double.maxFinite,
    required this.content,
    required this.title,
  }) : super(key: key);
  double width;
  final Widget content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
          height: 85.h,
          width: width.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14.h,
              ),
              content,
            ],
          )),
    );
  }
}
