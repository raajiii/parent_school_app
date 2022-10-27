import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../model/class_test_model.dart';
import '../../../../themes/app_styles.dart';

class TodayClassTestScreen extends StatelessWidget {
  ClassTestModel? classTestModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassTestController>(
        init: ClassTestController(),
        builder: (classTestController) {
          return SingleChildScrollView(
            child: _buildBody(classTestController, context),
          );
        });
  }

  Widget _buildBody(
      ClassTestController classTestController, BuildContext context) {
    return classTestController.customTodayModel.isNotEmpty?SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: classTestController.customTodayModel.length,//classTestData!.length
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ classTestController.customTodayModel[index].flag!=1?
                      _dateWidget(classTestController,index):
                    _buildCardWidget(classTestController,context,index)
                    ],
                  );
                }),
          ),
        ],
      )
    ):SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Padding _dateWidget(ClassTestController classTestController, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 8.0),
      child: Text(classTestController.customTodayModel[index].date ?? "",
          style: AppStyles.NunitoExtrabold.copyWith(
            fontSize: 14,
            color: AppColors.darkPinkColor,
          )),
    );
  }

  Widget _buildCardWidget(
    ClassTestController classTestController,
    BuildContext context,
    int index,
  ) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: _leadingImage(classTestController, index),
                title: _titleWidget(classTestController, index),
                subtitle: subtitleAndDesWidget(classTestController, index),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget subtitleAndDesWidget(
      ClassTestController classTestController, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          classTestController.customTodayModel[index].classTestTodayData!.title
                  .toString() ??
              "",
          style: AppStyles.arimoRegular.copyWith(
            fontSize: 13,
            color: AppColors.blackColor,
          ),
        ),
        Text(
            classTestController
                    .customTodayModel[index].classTestTodayData!.description
                    .toString() ??
                "",
            style: AppStyles.normal
                .copyWith(fontSize: 12, color: AppColors.greyColor)),
      ],
    );
  }

  Widget _titleWidget(ClassTestController classTestController, int index) {
    return Text(
      classTestController
              .customTodayModel[index].classTestTodayData!.subjectName
              .toString() ??
          "",
      //classTestData![index].subject![0].subjectName.toString()??""
      style: AppStyles.NunitoExtrabold.copyWith(
        fontSize: 14,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _leadingImage(ClassTestController classTestController, int index) {
    return Container(
        width: 50.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(classTestController
                        .customTodayModel[index].classTestTodayData!.icon
                        .toString() ??
                    ""))));
  }
}
