import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> getTime(context) async {
  String? result = '';
  await showTimePicker(context: context, initialTime: TimeOfDay.now())
      .then((value) => result = value?.format(context));
  return result;
}

Future<String?> getDate(context) async {
  String? result = '';
  await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2050))
      .then((value) => result = formatter.format(value!));
  return result;
}

DateFormat formatter = DateFormat('yyyy-MM-dd');
DateFormat timeFormatter = DateFormat.jm();
