import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../widgets/common_widgets.dart';
import 'Today_past_screen.dart';
import 'home_report_screen.dart';

class HomeWorkScreen extends StatelessWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Homework"),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<HomeworkController>(
            init: HomeworkController(),
            builder: (controller) {
              return DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          controller: controller.tabController,
                          labelColor: AppColors.darkPinkColor,
                          unselectedLabelColor: AppColors.greyColor,
                          indicatorColor: AppColors.darkPinkColor,
                          isScrollable: false,
                          onTap: (index) {
                            controller.updateTabIndex(index);
                          },
                          tabs: const [
                            Tab(
                              text: 'TODAY',
                            ),
                            Tab(text: 'PAST'),
                            Tab(text: 'REPORT'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                TodayAndPastScreen(),
                                TodayAndPastScreen(),
                                const ReportScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
