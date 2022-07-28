class TaskEntity {
  int? id;
  String title;
  String date;
  String startTime;
  String endTime;
  String reminder;
  String repeat;
  bool isFav;
  bool isCompleted;
  String color;
  TaskEntity({
    this.id,
    required this.color,
    required this.isCompleted,
    required this.isFav,
    required this.reminder,
    required this.repeat,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}
