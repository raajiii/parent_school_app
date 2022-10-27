import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../../sample_audio_file.dart';
import '../../../../themes/app_styles.dart';

class VoiceCustom extends GetView<VoiceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(
        init: VoiceController(),
        builder: (controller) {
          return controller.finalList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.finalList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 8.0),
                                    child: Text(
                                        "${controller.finalList[index].date}",
                                        style:
                                            AppStyles.NunitoExtrabold.copyWith(
                                          fontSize: 14,
                                          color: AppColors.darkPinkColor,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5),
                                    child: InkWell(
                                      onTap: () {
                                          Get.to(SampleAudioPlayer(
                                              voiceTodayData:
                                              controller.finalList[index]));
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
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .darkPinkColor,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    color:
                                                        AppColors.darkPinkColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 8,
                                                  right: 8.0,
                                                  bottom: 10),
                                              child: Text(
                                                  "${controller.finalList[index].title}",
                                                  style: AppStyles
                                                      .NunitoExtrabold.copyWith(
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
                                  )
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}
