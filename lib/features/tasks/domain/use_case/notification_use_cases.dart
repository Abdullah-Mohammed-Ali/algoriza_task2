import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:to_do_task2/features/tasks/domain/entity/task.dart';
import 'package:to_do_task2/features/tasks/domain/use_case/use_case_general.dart';

import '../../../../core/data/notification_helper.dart';
import '../../../../core/functions/get_time_date.dart';
import '../../../../error_handling/failures.dart';

class ScheduledNotificationUseCase
    implements UseCase<Unit, NotificationParams> {
  final NotificationHelper _notification;

  ScheduledNotificationUseCase(this._notification);
  @override
  Future<Either<Failures, Unit>?> call(params) async {
    TimeOfDay time =
        TimeOfDay.fromDateTime(timeFormatter.parse(params.taskEntity.reminder));
    _notification.notify(
        id: Random().nextInt(10000),
        title: params.taskEntity.title,
        body: '',
        date: formatter.parse(params.taskEntity.date),
        time: time);
  }
}

class NotificationParams {
  final TaskEntity taskEntity;

  NotificationParams(
    this.taskEntity,
  );
}
