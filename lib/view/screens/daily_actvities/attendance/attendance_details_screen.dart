import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../const/colors.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import 'leave_status_screen.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  AttendanceDetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Attendance"),
        body: GetBuilder<AttendanceDetailsController>(
            init: AttendanceDetailsController(),
            builder: (attendanceDetailsController) {
              return attendanceDetailsController.attendanceModel?.data!=null? SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: SfCircularChart(series: <CircularSeries>[
                          // Renders doughnut chart
                          DoughnutSeries<ChartData, String>(
                              dataSource: attendanceDetailsController.chartData,
                              animationDuration: 5000,
                              radius: '100%',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              dataLabelMapper: (ChartData data, _) => data.x,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y)
                        ]),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(LeaveStatusScreen());
                                  attendanceDetailsController.getLeaveListData();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkPinkColor,
                                  foregroundColor: AppColors.whiteColor,
                                  minimumSize: Size(10, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.leaderboard,
                                  size: 25.0,
                                ),
                                label: Text('LEAVE REQUEST'), // <-- Text
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.SCHOOLCALENDER);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkPinkColor,
                                  foregroundColor: AppColors.whiteColor,
                                  minimumSize: Size(10, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 25.0,
                                  color: AppColors.whiteColor,
                                ),
                                label:
                                    Text('MONTHWISE \nATTENDANCE'), // <-- Text
                              ),
                            ],
                          ),
                        ),
                      ),
                      _attendanceDetails(attendanceDetailsController,context),
                      _absentDetails(attendanceDetailsController,context)
                    ]),
              ):SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  Widget _attendanceDetails(AttendanceDetailsController attendanceDetailsController,BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Attendance Details",
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.blackColor),
            ).paddingOnly(left: 20, top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 10.0,
                  percent: 0.41,
                  center: Text(
                    "${attendanceDetailsController.attendanceModel?.data?.percentage}",
                    style: const TextStyle(fontSize: 20, color: AppColors.blackColor),
                  ),
                  progressColor: AppColors.darkPinkColor,
                ),
                Column(
                  children: [
                    attendanceLinearProgressBar(
                        1,
                        attendanceDetailsController,
                        containerColor: AppColors.lightOrange,
                        progressColor: AppColors.orangeColor,
                        percentage: 0.5,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                    attendanceLinearProgressBar(
                        2,
                        attendanceDetailsController,
                        progressColor: AppColors.shadeOfPinkColor,
                        containerColor: AppColors.cornflowerBlueColor,
                        percentage: 0.6,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                    attendanceLinearProgressBar(
                        3,
                        attendanceDetailsController,
                        containerColor: AppColors.DarkCyan,
                        progressColor: AppColors.DarkCyan,
                        percentage: 0.1,
                        width: MediaQuery.of(Get.context!).size.width * 0.35,
                        sizedBoxWidth:
                            MediaQuery.of(Get.context!).size.width * 0.3),
                  ],
                )
              ],
            ).paddingOnly(left: 25, top: 5),
          ],
        ),
      ).paddingAll(10),
    ).paddingAll(5);
  }

  Widget _absentDetails(AttendanceDetailsController attendanceDetailsController,BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Absent Details",
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.blackColor),
            ).paddingOnly(left: 20, top: 10),
            Column(
              children: [
                attendanceLinearProgressBar(
                    4,
                    attendanceDetailsController,
                    containerColor: AppColors.lightOrange,
                    progressColor: AppColors.orangeColor,
                    percentage: 0.5,
                    width: MediaQuery.of(Get.context!).size.width * 0.6,
                    sizedBoxWidth:
                        MediaQuery.of(Get.context!).size.width * 0.55),
                attendanceLinearProgressBar(
                    5,
                    attendanceDetailsController,
                    progressColor: AppColors.shadeOfPinkColor,
                    containerColor: AppColors.cornflowerBlueColor,
                    percentage: 0.6,
                    width: MediaQuery.of(Get.context!).size.width * 0.6,
                    sizedBoxWidth:
                        MediaQuery.of(Get.context!).size.width * 0.55),
                attendanceLinearProgressBar(
                    6,
                    attendanceDetailsController,
                    containerColor: AppColors.DarkCyan,
                    progressColor: AppColors.DarkCyan,
                    percentage: 0.1,
                    width: MediaQuery.of(Get.context!).size.width * 0.6,
                    sizedBoxWidth:
                        MediaQuery.of(Get.context!).size.width * 0.55),
              ],
            ).paddingOnly(left: 25, top: 5),
          ],
        ),
      ).paddingAll(10),
    ).paddingAll(5);
  }
}

Widget attendanceLinearProgressBar(
    int type,
    AttendanceDetailsController attendanceDetailsController,
    {Color? containerColor,
    double? percentage,
    Color? progressColor,
    required double width,
    required double sizedBoxWidth}) {

  String? progressLabel;
  int? progressValue;
  if(type==1){
    progressLabel = "Working Days";
    progressValue = attendanceDetailsController.attendanceModel?.data?.noOfWorkingDays;
  }else if(type==2){
    progressLabel = "Present";
    progressValue = attendanceDetailsController.attendanceModel?.data?.present;
  }else if(type==3){
    progressLabel = "Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absent;
  }else if(type==4){
    progressLabel = "Full Day Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absentDetail?.fullDay;
  }else if(type==5){
    progressLabel = "Today Morning Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absentDetail?.morningHaftDay;
  }else if(type==6){
    progressLabel = "Today Evening Absent";
    progressValue = attendanceDetailsController.attendanceModel?.data?.absentDetail?.eveningHaftDay;
  }

  return Row(
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: containerColor ?? AppColors.whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ).paddingOnly(top: 5, bottom: 5, left: 20, right: 5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: sizedBoxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [Text(
                  "$progressLabel",
                  style: const TextStyle(fontSize: 8, color: AppColors.blackColor),
                ),
                Text(
                  "$progressValue",
                  style: const TextStyle(fontSize: 8, color: AppColors.blackColor),
                ),
              ],
            ),
          ).paddingOnly(top: 5, bottom: 5, left: 10, right: 10),
          LinearPercentIndicator(
            width: width,
            lineHeight: 4.0,
            percent: percentage ?? 0.0,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: progressColor ?? AppColors.whiteColor,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ],
  );
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final int y;
  final Color? color;
}
