import 'package:flutter/material.dart';
import 'package:to_do_task2/constatns/String/create_labels_hints_texts.dart';

class AppColors {
  static const main = Colors.white;
  static const textSelected = Colors.black;
  static const textUnSelected = Colors.grey;
  static const taskButton = Color(0xff0cc514);
  static const divider = Colors.grey;
  static const appBarIcons = Colors.black;
  static const textFieldFill = Color(0xffF8F8F8);
  static const taskBlue = Colors.blue;
  static const taskRed = Colors.red;
  static const taskOrange = Colors.orange;
  static const taskYellow = Colors.amberAccent;

  static const Map<String, Color> taskColors = {
    LabelsHintsTexts.taskBlue: taskBlue,
    LabelsHintsTexts.taskRed: taskRed,
    LabelsHintsTexts.taskOrange: taskOrange,
    LabelsHintsTexts.taskYellow: taskYellow,
  };

  static Color? getColorForTask(String color) {
    return taskColors[color];
  }

  static List<bool> isColorChecked = [false, false, false, false];
  static List<bool> colorCheckedClearList = [false, false, false, false];
}
