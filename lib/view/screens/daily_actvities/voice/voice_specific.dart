import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../model/voiceOverallModel.dart';
import '../../../../sample_audio_file.dart';
import '../../../../themes/app_styles.dart';

class VoiceSpecific extends GetView<VoiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.specificList.isEmpty) {
        return const Center(child: Text(""));
      }
      return ListView(
        controller: controller.specificScrollController,
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
                  ? controller.specificList.length + 1
                  : controller.specificList.length,
              itemBuilder: (BuildContext context, int index) {
                final isLastItem = index == controller.specificList.length;

                if (isLastItem && loadingType == LoadingType.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (isLastItem && loadingType == LoadingType.error) {
                  return Text(controller.loadingState.value.error.toString());
                } else if (isLastItem && loadingType == LoadingType.completed) {
                  return Text(
                      controller.loadingState.value.completed.toString());
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateWidget(controller.specificList[index]),
                      titleAndDescription(controller.specificList[index])
                    ],
                  );
                }
              },
              separatorBuilder: (context, index) => Container(),
            ),
          )
        ],
      );
    });
  }

  Padding titleAndDescription(VoiceOverallData overallData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: InkWell(
        onTap: () {
            Get.to(
                SampleAudioPlayer(voiceTodayData: overallData));
        },
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: AppColors.darkPinkColor,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: AppColors.darkPinkColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 8, right: 8.0, bottom: 10),
                child: Text("${overallData.title}",
                    style: AppStyles.NunitoExtrabold.copyWith(
                      fontSize: 14,
                      color: AppColors.blackColor,
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding dateWidget(VoiceOverallData overallData) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(" ${overallData.date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }
}
