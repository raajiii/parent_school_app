import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/news_circular_event_controller/circular_event_news_controller.dart';
import '../../../widgets/common_widgets.dart';
import '../latest_in_circular_event_news/latest_screen.dart';
import '../news/past_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Event"),
        body: GetBuilder<NewsCircularEventController>(
            init: NewsCircularEventController(),
            builder: (eventController) {
              return DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                         TabBar(
                          labelColor: AppColors.darkPinkColor,
                          unselectedLabelColor: AppColors.greyColor,
                          indicatorColor: AppColors.darkPinkColor,
                          controller: eventController.tabController,
                           isScrollable: false,
                          onTap: (index) {
                            eventController.updateTabIndex(index);
                          },
                          tabs: const[
                            Tab(
                              text: 'LATEST',
                            ),
                            Tab(text: 'PAST'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              controller: eventController.tabController,
                              children: <Widget>[
                                LatestScreen(),
                                PastScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
