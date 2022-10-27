import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import 'Today_past_screen.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeworkController>(
        init: HomeworkController(),
        builder: (controller) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Date",
                          style: AppStyles.arimBold.copyWith(
                              fontSize: 14, color: AppColors.blackColor),
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            controller.updateFinalList();
                            controller.selectDate(context);
                          },
                          text: "SINGLE DAY",
                          width: 10,
                          height: 40,
                          primaryColor: AppColors.darkPinkColor,
                          borderRadius: 5,
                          fontSize: 11,
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            controller.updateFinalList();
                            controller.dateRangeDialog(context);
                          },
                          text: '''MULTIPLE \nDAYS''',
                          width: 10,
                          height: 40,
                          borderRadius: 5,
                          primaryColor: AppColors.darkPinkColor,
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              controller.isVisible
                  ? Container()
                  : SizedBox(
                      height: Get.height * 0.65, child: TodayAndPastScreen()),
              const SizedBox(
                height: 20,
              )
            ],
          );
        });
  }
}
