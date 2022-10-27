import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import 'create_leave_request_screen.dart';

class LeaveStatusScreen extends GetView<AttendanceDetailsController> {
  const LeaveStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Leave Status"),
      body: Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.finalList!.isEmpty) {
          return const Center(child: Text("No Data"));
        }
        return ListView(
          controller: controller.scrollController,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loadingType == LoadingType.loading ||
                    loadingType == LoadingType.error ||
                    loadingType == LoadingType.completed
                    ? controller.finalList!.length + 1
                    : controller.finalList!.length,
                itemBuilder: (BuildContext context, int index) {
                  final isLastItem = index == controller.finalList!.length;

                  if (isLastItem && loadingType == LoadingType.loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (isLastItem && loadingType == LoadingType.error) {
                    return Text(controller.loadingState.value.error.toString());
                  } else if (isLastItem && loadingType == LoadingType.completed) {
                    return Text(
                        controller.loadingState.value.completed.toString());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "From ${controller.finalList[index].startDate} To ${controller.finalList[index].endDate}",
                                  style: AppStyles.arimBold.copyWith(
                                      color: AppColors.blackColor,
                                      fontSize: 15),
                                ),
                                controller.finalList[index].status==0?
                                 InkWell(
                                  onTap: (){
                                    controller.editFlag  = 1;
                                    controller.leaveRequestId  = controller.finalList[index].id;
                                    controller.noOfLeaves.text = "${controller.finalList[index].total}";
                                    controller.startDateController.text = "${controller.finalList[index].startDate}";
                                    controller.leaveDateController.text = "${controller.finalList[index].startDate}";
                                    controller.endDateController.text = "${controller.finalList[index].endDate}";
                                    controller.descriptionController.text = "${controller.finalList[index].description}";

                                    for(int i=0;i<controller.selectedLeaveList1.length;i++){

                                      if(i!=0){
                                        if(controller.finalList[index].halfDayLeave==0){
                                          controller.selectedLeaveType = "Full Day";
                                          break;
                                        }else if(controller.finalList[index].halfDayLeave==1){
                                          controller.selectedLeaveType = "AN leave Start date";
                                          break;
                                        }else if(controller.finalList[index].halfDayLeave==2){
                                          controller.selectedLeaveType = "MN leave to End date";
                                          break;
                                        }else if(controller.finalList[index].halfDayLeave==3){
                                          controller.selectedLeaveType = "AN leave in Start date & MN leave in End date";
                                          break;
                                        }
                                      }
                                    }
                                    print("Leave Type Value :  ${controller.selectedLeaveType}");
                                    print("Leave Type id in Api :  ${controller.finalList[index].halfDayLeave}");


                                    Get.to(const CreateLeaveRequestScreen());
                                  },
                                  child:  const Icon(
                                    Icons.edit,
                                    color: AppColors.darkPinkColor,
                                  ),
                                ):Container()
                              ],
                            ).paddingOnly(top: 10, right: 10, left: 10),
                            Text(
                              "${controller.finalList[index].description}",
                              style: AppStyles.normal.copyWith(
                                  color: AppColors.greyColor, fontSize: 12),
                            ).paddingOnly(top: 10, right: 10, left: 10),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.finalList[index].statusName}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13, color: Colors.green),
                                ),
                                Text(
                                  "Applied on ${controller.finalList[index].applyDate}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.greyColor),
                                )
                              ],
                            ).paddingOnly(
                                top: 10, right: 10, left: 10, bottom: 10)
                          ],
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) => Container(),
              ),
            )
          ],
        );
      }),
      floatingActionButton: GetBuilder<AttendanceDetailsController>(
          init: AttendanceDetailsController(),
          builder: (attendanceDetailsController) {
            return ElevatedButton.icon(
              onPressed: () {
                attendanceDetailsController.descriptionController.text="";
                attendanceDetailsController.selectedLeaveType = "Select Leave Type";
                attendanceDetailsController.selectedLeaveTypeValue=-1;
                attendanceDetailsController.editFlag  = 0;
                attendanceDetailsController.openDialogValue = false;
                Get.to(const CreateLeaveRequestScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkPinkColor,
                foregroundColor: AppColors.whiteColor,
                minimumSize: const Size(10, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(
                Icons.leaderboard,
                size: 25.0,
                color: AppColors.whiteColor,
              ),
              label: Text('LEAVE REQUEST'), // <-- Text
            );
          }),
    );




  }
}
