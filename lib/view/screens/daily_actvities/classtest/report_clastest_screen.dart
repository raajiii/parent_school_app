import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';


class ReportClassTestScreen extends GetView<ClassTestController> {
  ReportClassTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isClicked=false;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
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
                            //profileController.religionUpdate(data!);
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
                           // isClicked=true;
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
            ],
          ),
          const SizedBox(height: 20,),
          Obx(() {
            final loadingType = controller.loadingState.value.loadingType;
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (controller.finalList.isEmpty) {
              return const Center(child: Text("No Data"));
            }
            return Visibility(
              visible: controller.reportSelectedVal==true?controller.finalList.isNotEmpty?true:false:false,
              child: ListView(
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
                          return Text(
                              controller.loadingState.value.error.toString());
                        } else if (isLastItem &&
                            loadingType == LoadingType.completed) {
                          return Text(
                              controller.loadingState.value.completed.toString());
                        } else {
                          return controller.finalList[index].flag != 1
                              ? dateWidget(controller, index)
                              : titleAndDescription(controller, index);
                        }
                      },
                      separatorBuilder: (context, index) => Container(),
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );

    Obx(() {
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
                  return controller.finalList[index].flag != 1
                      ? dateWidget(controller, index)
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: Text(
                      "${controller.finalList[index].classTestPastSubject!.subjectName}",
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
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8.0),
                  child: Text(
                      "${controller.finalList[index].classTestPastSubject!.subjectName}",
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
          ],
        ),
      ),
    );
  }

/* @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassTestController>(
        init: ClassTestController(),
        builder: (classTestController) {
          return Column(
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
                            classTestController.selectDate(context);
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
                            classTestController.dateRangeDialog(context);
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
            ],
          );
        });
  }*/
}
