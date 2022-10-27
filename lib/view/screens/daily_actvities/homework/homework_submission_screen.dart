import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../const/contsants.dart';
import '../../../../const/image_constants.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../model/home_work_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../dialogs/dialog_helper.dart';
import '../../../widgets/common_widgets.dart';
import 'homework_attachements_screen.dart';

class HomeWorkSubmissionScreen extends StatelessWidget {
  final Subject subjectList;

  const HomeWorkSubmissionScreen({Key? key, required this.subjectList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar(Constants.HOMEWRKSUBMISSIONTEXT),
      body: GetBuilder<HomeworkController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Constants.HOMEWORK,
                    style: AppStyles.NunitoExtrabold.copyWith(
                      fontSize: 14,
                      color: AppColors.blackColor,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: TextFormField(
                    minLines: 5,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller.homeworkController,
                    decoration: InputDecoration(
                      hintText: "Enter Homework",
                      filled: true,
                      errorStyle:
                          const TextStyle(height: 0, color: AppColors.redColor),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF969A9D),
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: AppColors.greyColor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: AppColors.greyColor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: AppColors.darkPinkColor, width: 1.5)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1.5),
                      ),
                    ),
                  ),
                ),
                ((subjectList.homeworkReply != null) &&
                        (subjectList.homeworkReply!.studentReply != null) &&
                        (subjectList.homeworkReply!.studentReply!
                            .stuHomeworkFile!.isNotEmpty))
                    ? SizedBox(
                        height: Get.height * 0.1,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: subjectList.homeworkReply?.studentReply
                                    ?.stuHomeworkFile?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Wrap(
                                children: [
                                  subjectList.homeworkReply!.studentReply!
                                          .stuHomeworkFile![index].attachFile!
                                          .contains(".pdf")
                                      ? const SMSImageAsset(
                                          image: ImageConstants.pdfImg,
                                          height: 25,
                                          width: 40,
                                        )
                                      : subjectList
                                              .homeworkReply!
                                              .studentReply!
                                              .stuHomeworkFile![index]
                                              .attachFile!
                                              .contains(".doc")
                                          ? const SMSImageAsset(
                                              image: ImageConstants.docsImg,
                                              height: 25,
                                              width: 40,
                                            )
                                          : subjectList
                                                  .homeworkReply!
                                                  .studentReply!
                                                  .stuHomeworkFile![index]
                                                  .attachFile!
                                                  .contains(".x")
                                              ? const SMSImageAsset(
                                                  image: ImageConstants.xlsImg,
                                                  height: 25,
                                                  width: 40,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Image.file(
                                                      File(subjectList
                                                              .homeworkReply
                                                              ?.studentReply
                                                              ?.stuHomeworkFile?[
                                                                  index]
                                                              .attachFile
                                                              .toString() ??
                                                          ""),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                ],
                              );
                            }),
                      )
                    : Container(),
                Visibility(
                  visible: controller.filesList.length > 2 ? false : true,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SMSButtonWidget(
                        onPress: () {
                          showBottomModelSheet(context, controller);
                        },
                        text: "ADD",
                        width: 10,
                        height: 30,
                        borderRadius: 5),
                  ),
                ),
                controller.filesList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filesList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.filesList[index].fileName
                                        .contains(".pdf")
                                    ? const SMSImageAsset(
                                        image: ImageConstants.pdfImg,
                                        height: 25,
                                        width: 40,
                                      )
                                    : (controller.filesList[index].fileName
                                            .contains(".doc"))
                                        ? const SMSImageAsset(
                                            image: ImageConstants.docsImg,
                                            height: 25,
                                            width: 40,
                                          )
                                        : (controller.filesList[index].fileName
                                                .contains(".x"))
                                            ? const SMSImageAsset(
                                                image: ImageConstants.xlsImg,
                                                height: 25,
                                                width: 40,
                                              )
                                            : (controller.image != null)
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      child: Image.file(
                                                        File(controller
                                                            .image!.path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      child: Image.file(
                                                        controller
                                                            .filesList[index]
                                                            .file!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                InkWell(
                                  onTap: () {
                                    controller.removeItem(index);
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
                        })
                    : Container(),
                controller.filesList.length > 2
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, right: 20, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(HomeworkAttachmentScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(Constants.VIEWMORE,
                                  style: AppStyles.normal.copyWith(
                                      fontSize: 12,
                                      color: AppColors.darkPinkColor)),
                              const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 10,
                                    color: AppColors.darkPinkColor,
                                  ))
                            ],
                          ).paddingAll(8),
                        ),
                      )
                    : Container(),
                SMSButtonWidget(
                  onPress: () async {
                    if (controller.homeworkController.text.isNotEmpty) {
                      await controller.sendHomeworkSubmission(
                          homewrkId: subjectList.id.toString(),
                          homewrkText: controller.homeworkController.text,
                          filesList: controller.filesList,
                          url: "ApiHelper.homeworkSubmissionUrl");
                    } else {
                      showToastMsg("student description field is required");
                    }
                  },
                  text: Constants.SUBMITHOMEWORK,
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: 40,
                  borderRadius: 5,
                  primaryColor: AppColors.darkGreenColor,
                  fontSize: 13,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FilesUploadModel {
  File? file;
  String fileName;

  FilesUploadModel({required this.file, required this.fileName});
}
