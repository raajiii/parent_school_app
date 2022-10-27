import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../const/contsants.dart';
import '../../../../const/image_constants.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';

class HomeworkAttachmentScreen extends GetView<HomeworkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(Constants.HOMEWRKSUBMISSIONTEXT,
              style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
          actions: [
            InkWell(
                onTap: () {
                  showBottomModelSheet(context, controller);
                },
                child: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 27,
                ).paddingOnly(right: 10))
          ],
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.whiteColor,
                size: 28,
              )),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
            )),
          )),
      body: GetBuilder<HomeworkController>(builder: (homeController) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.filesList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    homeController.filesList[index].fileName.contains(".pdf")
                        ? const SMSImageAsset(
                            image: ImageConstants.pdfImg,
                            height: 25,
                            width: 40,
                          )
                        : (homeController.filesList[index].fileName
                                .contains(".doc"))
                            ? const SMSImageAsset(
                                image: ImageConstants.docsImg,
                                height: 25,
                                width: 40,
                              )
                            : (homeController.filesList[index].fileName
                                    .contains(".x"))
                                ? const SMSImageAsset(
                                    image: ImageConstants.xlsImg,
                                    height: 25,
                                    width: 40,
                                  )
                                : (controller.image != null)
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.file(
                                            File(controller.image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.file(
                                            controller.filesList[index].file!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                    InkWell(
                      onTap: () {
                        homeController.removeItem(index);
                      },
                      child: const Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.redColor,
                        size: 30,
                      ),
                    )
                  ],
                ).paddingAll(8),
              );
            });
      }),
    );
  }
}
