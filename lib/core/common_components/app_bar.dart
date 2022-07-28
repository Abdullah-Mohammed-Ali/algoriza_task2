import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constatns/String/board_bar_titles.dart';
import '../../constatns/colors.dart';
import '../../features/tasks/presentation/bloc/tasks_cubit.dart';

AppBar generalAppBar(
    {TickerProvider? tickerProvider,
    required BuildContext context,
    required TasksCubit cubit,
    required String title,
    required double height,
    required double width,
    bool tabBarExists = false}) {
  return AppBar(
    iconTheme: const IconThemeData(color: AppColors.appBarIcons),
    toolbarHeight: height.h,
    actions: tabBarExists
        ? [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today,
                  color: AppColors.textSelected,
                ))
          ]
        : null,
    title: Text(title),
    titleSpacing: width.w,
    titleTextStyle: Theme.of(context).textTheme.headline3!.copyWith(
        color: AppColors.textSelected,
        fontWeight: FontWeight.bold,
        fontSize: 22),
    backgroundColor: AppColors.main,
    elevation: 0,
    bottom: tabBarExists
        ? PreferredSize(
            preferredSize: Size(double.infinity, 40.h),
            child: Column(
              children: [
                const Divider(height: 8, color: AppColors.divider),
                TabBar(
                  controller: TabController(
                      length: 4,
                      vsync: tickerProvider!,
                      initialIndex: cubit.tabBarIndex),
                  isScrollable: true,
                  onTap: (index) {
                    cubit.changeTabBarScreen(index);
                  },
                  labelColor: AppColors.textSelected,
                  unselectedLabelColor: AppColors.textUnSelected,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
                  indicatorColor: AppColors.textSelected,
                  tabs: const [
                    Text(BoardBarTitles.allTasks),
                    Text(BoardBarTitles.completed),
                    Text(BoardBarTitles.uncompleted),
                    Text(BoardBarTitles.favourite)
                  ],
                ),
                const Divider(height: 8, color: AppColors.divider),
              ],
            ),
          )
        : null,
  );
}
