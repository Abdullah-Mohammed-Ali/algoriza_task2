import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '/dependency_container.dart' as di;
import '../../../../constatns/colors.dart';
import '../bloc/tasks_cubit.dart';
import 'calendar_style.dart';
import 'navigation/board_navigation_screen.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDayz = DateTime.now();

  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TasksCubit>(),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          var cubit = TasksCubit.get(context);
          return DefaultScaffold(
            height: 100,
            title: 'Schedule',
            cubit: cubit,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: BlocBuilder<TasksCubit, TasksState>(
                  builder: (context, state) {
                    var cubit = TasksCubit.get(context);
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: TableCalendar<TasksCubit>(
                              shouldFillViewport: true,
                              // eventLoader: (dateTime) {
                              //   // return cubit.groups[
                              //   //         formatter.parse(formatter.format(dateTime))] ??
                              //   //     [];
                              // },
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                weekendStyle: TextStyle(
                                    color: AppColors.taskYellow,
                                    fontWeight: FontWeight.w500),
                              ),
                              startingDayOfWeek: StartingDayOfWeek.saturday,
                              headerStyle: myHeaderStyle(),
                              pageJumpingEnabled: true,
                              weekendDays: const [DateTime.friday],
                              calendarStyle: MyCalendarStyle(),
                              focusedDay: focusedDayz,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              selectedDayPredicate: (selectedDay) {
                                return isSameDay(focusedDayz, selectedDay);
                              },
                              onPageChanged: (focusedDay) {
                                focusedDayz = focusedDay;
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                this.selectedDay = selectedDay;

                                setState(() {
                                  focusedDayz = selectedDay;
                                  focusedDayz = focusedDay;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Schedule',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                      )),
                                  // Expanded(
                                  //   flex: 7,
                                  //   // child: myList(state),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            actionButton: Container(),
          );
        },
      ),
    );
  }
}

// Widget myList(TasksState state) {
// if (state is GetAllEventsSuccess) {
//   DateTime day = (DateTime.parse(formatter.format(DateTime.now())));
//   // List<DateTime> days = state.events.keys.toList();
//   // List<List<CalendarEventEntity>> events = state.events.values.toList();
//
//   if (state.events.isNotEmpty) {
//     return ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: state.events.length,
//         itemBuilder: (context, mainIndex) {
//           return DayEvents(days: days, events: events, mainIndex: mainIndex);
//         });
//   } else {
//     return Container();
//   }
// } else {
//   return Container();
// }
// }
