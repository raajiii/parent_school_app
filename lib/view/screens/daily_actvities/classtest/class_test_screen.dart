import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raji_parent_school_app/view/screens/daily_actvities/classtest/today_classtest_screen.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../widgets/common_widgets.dart';
import 'past_classtest_screen.dart';
import 'report_clastest_screen.dart';

class ClassTestScreen extends StatelessWidget {
  const ClassTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassTestController>(
      init: ClassTestController(),
        builder: (classTestController){
        return _buildBody(classTestController, context);
        });
  }

  Widget _buildBody(ClassTestController controller,BuildContext context){
    return Scaffold(
        appBar: smsAppbar("Class Test"),
        body: DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const TabBar(
                    labelColor: AppColors.darkPinkColor,
                    unselectedLabelColor: AppColors.greyColor,
                    indicatorColor: AppColors.darkPinkColor,
                    tabs: [
                      Tab(
                        text: 'TODAY',
                      ),
                      Tab(text: 'PAST'),
                      Tab(text: 'REPORT'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child:  TabBarView(children: <Widget>[
                      TodayClassTestScreen(),
                      PastClassTestScreen(),
                      ReportClassTestScreen(),
                    ]),
                  )
                ])));
  }
}
