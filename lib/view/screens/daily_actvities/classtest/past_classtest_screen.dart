import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../themes/app_styles.dart';

class PastClassTestScreen extends GetView<ClassTestController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
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
                  ? controller.finalList.length + 1
                  : controller.finalList.length,
              itemBuilder: (BuildContext context, int index) {
                final isLastItem = index == controller.finalList.length;

                if (isLastItem && loadingType == LoadingType.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (isLastItem && loadingType == LoadingType.error) {
                  return Text(controller.loadingState.value.error.toString());
                } else if (isLastItem && loadingType == LoadingType.completed) {
                  return Text(
                      controller.loadingState.value.completed.toString());
                } else {
                  return controller.finalList[index].flag != 1 ? dateWidget(controller, index)
                      : titleAndDescription(controller, index);
                }
              },
              separatorBuilder: (context, index) => Container(),
            ),
          )
        ],
      );
    });
      //_buildBody(context);
  }

  Padding dateWidget(ClassTestController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(" ${controller.finalList[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }

  Padding titleAndDescription(ClassTestController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8.0),
                  child:
                  Text("${controller.finalList[index].classTestPastSubject!.subjectName}",
                      style: AppStyles.NunitoExtrabold.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    "${controller.finalList[index].classTestPastSubject!.title}",
                    style: AppStyles.normal
                        .copyWith(fontSize: 12, color: AppColors.greyColor),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    "${controller.finalList[index].classTestPastSubject!.description}",
                    style: AppStyles.normal
                        .copyWith(fontSize: 12, color: AppColors.greyColor),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            controller.finalList[index].classTestPastSubject?.resultData!=null?
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 10.0,
                    percent: 0.41,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                         Text(
                           "${controller.finalList[index].classTestPastSubject?.resultData!.totalMark??""}",
                          style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.totalMark??""}
                        ),
                        const SizedBox(height: 2,),
                        const Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                            "${controller.finalList[index].classTestPastSubject?.resultData!.resultMax??""}",
                          style: const TextStyle(fontSize: 15, color: AppColors.blackColor),//${controller.finalList[index].classTestPastSubject!.resultData!.resultMax??""}
                        ),

                      ],
                    ),
                    progressColor: AppColors.shadeOfIndianRed,
                  ),
                ),
              ],
            ):Container()
          ],
        ),
      ),
    );
  }


}

