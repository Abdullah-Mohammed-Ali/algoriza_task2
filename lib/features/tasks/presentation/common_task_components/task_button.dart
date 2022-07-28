import 'package:flutter/material.dart';

import '../../../../constatns/colors.dart';

class ElevatedTaskButton extends StatelessWidget {
  const ElevatedTaskButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.taskButton)),
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    );
  }
}
