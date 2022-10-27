import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../const/image_constants.dart';
import '../../../../controllers/daily_activity_controller/news_circular_event_controller/circular_event_news_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import '../../view_and_download/download_anyfile.dart';

class LatestScreen extends GetView<NewsCircularEventController> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
        return const Center(child: Text(""));
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
  }

  Padding titleAndDescription(
      NewsCircularEventController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8.0),
              child:
                  Text("${controller.finalList[index].customResponse?.title}",
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
                "${controller.finalList[index].customResponse?.description}",
                style: AppStyles.normal
                    .copyWith(fontSize: 12, color: AppColors.greyColor),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  controller.finalList[index].customResponse?.images?.length ??
                      0,
              itemBuilder: (BuildContext context, int index) {
                var imageList =
                    controller.finalList[index].customResponse?.images ?? [];
                return imageList.isNotEmpty
                    ? Row(
                        children: [
                          imageList[index].file!.contains(".pdf")
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(DownloadFiles(
                                        file: imageList[index].file ?? ""));
                                  },
                                  child: const SMSImageAsset(
                                    image: ImageConstants.pdfImg,
                                    height: 25,
                                    width: 40,
                                  ))
                              : imageList[index].file!.contains(".x")
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.to(DownloadFiles(
                                            file: imageList[index].file ?? ""));
                                      },
                                      child: const SMSImageAsset(
                                        image: ImageConstants.xlsImg,
                                        height: 25,
                                        width: 40,
                                      ))
                                  : imageList[index].file!.contains(".doc")
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.to(DownloadFiles(
                                                file: imageList[index].file ??
                                                    ""));
                                          },
                                          child: const SMSImageAsset(
                                            image: ImageConstants.docsImg,
                                            height: 25,
                                            width: 40,
                                          ))
                                      : imageList[index]
                                              .file!
                                              .contains(".image")
                                          ? GestureDetector(
                                              onTap: () {
                                                Get.to(DownloadFiles(
                                                    file:
                                                        imageList[index].file ??
                                                            ""));
                                              },
                                              child: Image.network(
                                                  "${imageList[index].file}"),
                                            )
                                          : const SizedBox(),
                        ],
                      )
                    : Container();
              },
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Padding dateWidget(NewsCircularEventController controller, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(" ${controller.finalList[index].date}",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }
}
