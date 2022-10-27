import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../const/contsants.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../enums/enum_navigation.dart';
import '../../../../model/home_work_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import 'homework_submission_screen.dart';

class TodayAndPastScreen extends GetView<HomeworkController> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Obx(() {
      final loadingType = controller.loadingState.value.loadingType;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      if (controller.finalList.isEmpty) {
        return const Center(child: Text(""));
      }
      return ListView(controller: controller.scrollController, children: [
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.builder(
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
                  } else if (isLastItem &&
                      loadingType == LoadingType.completed) {
                    return Text(
                        controller.loadingState.value.completed.toString());
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _dateWidget(controller.finalList[index]),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.finalList[index].subject?.length ??
                                      0,
                              itemBuilder: (BuildContext context, int index1) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 5),
                                  child: _buildCardWidget(
                                      context,
                                      controller.finalList[index].subject ?? [],
                                      index1,
                                      index,
                                      controller),
                                );
                              })
                        ]);
                  }
                }))
      ]);
    });
  }

  Padding _dateWidget(HomeWorkData homewrkData) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(homewrkData.date.toString(),
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }

  Widget _buildCardWidget(BuildContext context, List<Subject> subjectList,
      int index1, int index, HomeworkController controller) {
    return subjectList.isNotEmpty
        ? Card(
            elevation: 5,
            child: Stack(
              children: [
                statusIconWidget(subjectList[index1]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: _leadingImage(subjectList[index1]),
                      title: _titleWidget(subjectList[index1]),
                      subtitle: subtitleAndDesWidget(subjectList[index1]),
                    ),
                    viewMoreButton(controller, subjectList[index1]),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }

  Widget subtitleAndDesWidget(Subject subject) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject.title ?? "",
          style: AppStyles.arimoRegular.copyWith(
            fontSize: 13,
            color: AppColors.blackColor,
          ),
        ),
        Text(subject.description ?? "",
            style: AppStyles.normal
                .copyWith(fontSize: 12, color: AppColors.greyColor)),
      ],
    );
  }

  Widget _titleWidget(Subject subject) {
    return Text(
      subject.subjectName ?? "",
      style: AppStyles.NunitoExtrabold.copyWith(
        fontSize: 14,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _leadingImage(Subject subject) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(subject.icon.toString() ?? ""))));
  }

  Widget statusIconWidget(Subject subject) {
    return Positioned(
      right: 0.0,
      top: 0.0,
      child: IconButton(
          icon: Icon(
            Icons.verified,
            size: 24,
            color: ((subject.homeworkReply != null) &&
                    (subject.homeworkReply?.studentReply?.stuDescription !=
                        null) &&
                    (subject.homeworkReply?.staffReply?.staffDescription !=
                        null))
                ? AppColors.darkGreenColor
                : AppColors.orangeColor,
          ),
          onPressed: () {
            print("Pressed");
          }),
    );
  }

  Widget hiddenContainerOfViewmore(BuildContext context, Subject subjectList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 0.0, left: 5, right: 5),
          child: Divider(
            height: 1,
            color: AppColors.greyColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homewrkSubmissionTxt(),
            ((subjectList.homeworkReply != null) &&
                    (subjectList.homeworkReply?.staffReply?.staffDescription ==
                        null))
                ? InkWell(
                    onTap: () {
                      Get.to(
                          HomeWorkSubmissionScreen(subjectList: subjectList));
                      controller.homeworkController.text = subjectList
                              .homeworkReply?.studentReply?.stuDescription
                              .toString() ??
                          "";
                    },
                    child: const Text(
                      "EDIT",
                      style: TextStyle(color: AppColors.redColor),
                    ).paddingOnly(right: 20),
                  )
                : Container()
          ],
        ),
        if (subjectList.homeworkReply == null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10),
            child: SMSButtonWidget(
              onPress: () {
                Get.to(HomeWorkSubmissionScreen(subjectList: subjectList));
                controller.homeworkController.text = "";
              },
              text: Constants.SUBMITHOMEWORK,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 40,
              borderRadius: 5,
              primaryColor: AppColors.darkGreenColor,
              fontSize: 13,
            ),
          )
        else if (subjectList.homeworkReply?.studentReply?.stuDescription !=
            null)
          Text("Student Reply : ${subjectList.homeworkReply?.studentReply?.stuDescription ?? ""}")
              .paddingOnly(left: 10, bottom: 10),
        if (subjectList.homeworkReply?.staffReply?.staffDescription != null)
          Text("Staff Reply : ${subjectList.homeworkReply?.staffReply?.staffDescription ?? ""}")
              .paddingOnly(left: 10, bottom: 10)
      ],
    );
  }

  Widget viewMoreButton(HomeworkController controller, Subject subject) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text(
          "",
        ),
        childrenPadding: EdgeInsets.zero,
        tilePadding: const EdgeInsets.only(right: 30),
        onExpansionChanged: (bool expanded) {
          controller.expandedView(expanded);
        },
        trailing: SizedBox(
          width: Get.width * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(Constants.VIEWMORE,
                  style: AppStyles.normal
                      .copyWith(fontSize: 12, color: AppColors.darkPinkColor)),
              RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    controller.isExpanded
                        ? Icons.arrow_forward_ios_outlined
                        : Icons.arrow_back_ios,
                    size: 10,
                    color: AppColors.darkPinkColor,
                  )),
            ],
          ),
        ),
        children: [hiddenContainerOfViewmore(Get.context!, subject)],
      ),
    );
  }

  Widget homewrkSubmissionTxt() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(Constants.HOMEWRKSUBMISSIONTEXT,
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.blackColor,
          )),
    );
  }
}
