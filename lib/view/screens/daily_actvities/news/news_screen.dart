import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raji_parent_school_app/view/screens/daily_actvities/news/past_screen.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/news_circular_event_controller/circular_event_news_controller.dart';
import '../../../widgets/common_widgets.dart';
import '../latest_in_circular_event_news/latest_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("News"),
        body: GetBuilder<NewsCircularEventController>(
            init: NewsCircularEventController(),
            builder: (newsController) {
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
                          controller: newsController.tabController,
                          isScrollable: false,
                          onTap: (index){
                            newsController.updateTabIndex(index);
                          },
                          tabs:const [
                            Tab(
                              text: 'LATEST',
                            ),
                            Tab(text: 'PAST'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              controller: newsController.tabController,
                              children: <Widget>[
                                LatestScreen(),
                                const PastScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
