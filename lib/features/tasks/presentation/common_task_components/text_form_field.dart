import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_task2/features/tasks/presentation/bloc/tasks_cubit.dart';

import '../../../../constatns/colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    this.onTap,
    this.icon,
    this.readOnly = false,
    required this.cubit,
    required this.hintText,
    required this.controller,
    required this.validateErrorMessage,
  }) : super(key: key);
  Widget? icon;
  bool readOnly;
  final TextEditingController controller;
  final String hintText;
  final TasksCubit cubit;
  VoidCallback? onTap;
  final String validateErrorMessage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validateErrorMessage;
          }
        },
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(
          suffixIcon: icon,
          fillColor: AppColors.textFieldFill,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
          contentPadding: const EdgeInsetsDirectional.all(15),
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldFill),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldFill),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
