import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/colors.dart';
import '../../../const/image_constants.dart';
import '../../../controllers/profile_controller/profile_controller.dart';
import '../../../model/profile_responce_model.dart';
import '../../../model/student_details_model.dart';
import '../../../themes/app_styles.dart';
import '../../dialogs/dialog_helper.dart';
import '../../widgets/common_widgets.dart';
import '../storage.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  bool editView = false;
  int selectValue = 0;
  String? valueChoose;
  List listItem = ["Married", "Single"];
  List<StudentData> studentData = LocalStorage.getValue("studentDetails") ?? [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profileController) {
          return _buildBody(profileController, context);
        });
  }

  Widget _buildBody(ProfileController profileController, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: smsAppbar("Profile"),
        body: profileController.profileModel?.code == 200
            ? SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Visibility(
                      visible: selectValue == 1
                          ? (profileController.fatherDetailsView ? false : true)
                          : selectValue == 2
                              ? (profileController.motherDetailsView
                                  ? false
                                  : true)
                              : (profileController.passportDetailsView
                                  ? false
                                  : true),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSizedBox(10),
                            _profileImage(),
                            _buildSizedBox(10),
                            _username(profileController),
                            _buildSizedBox(10),
                            _usercodeWidget(profileController),
                            _buildSizedBox(20),

                            _studentDetails(width),
                            _fatherDetails(width, profileController),
                            _motherDetails(width, profileController),
                            _fatherPassportDetails(width, profileController),
                          ],
                        ),
                      ),
                    ),
                    //father Edit
                    _fatherEditDetailsWidget(profileController, width),
                    //Mother Edit
                    _motherEditDetailsWidget(profileController, width),
                    //Father Passport
                    _passportEditDetailsWidget(
                        profileController, context, width),
                  ],
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }

  Text _usercodeWidget(ProfileController profileController) {
    return Text(
      profileController.profileModel?.profileData?.code ?? "",
      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 13),
    );
  }

  Text _username(ProfileController profileController) {
    return Text(
      profileController.profileModel?.profileData?.userName ?? "",
      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18),
    );
  }

  SizedBox _buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _profileImage() {
    return Center(
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black, style: BorderStyle.solid),
            shape: BoxShape.circle,
            image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://picsum.photos/250?image=9'))),
      ),
    );
  }

  void _show(
      BuildContext ctx, ProfileController profileController, String url) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
              height: Get.height * 0.26,
              color: Colors.white54,
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile Photo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ).paddingOnly(bottom: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            profileController.pickGalleryImage(url);
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.red,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    alignment: Alignment.center,
                                    ImageConstants.galleryImg,
                                    color: AppColors.whiteColor,
                                  ).paddingOnly(top: 15, bottom: 15)),
                              Text("Gallery",
                                      style: AppStyles.arimoRegular.copyWith(
                                          fontSize: 14,
                                          color: AppColors.greyColor))
                                  .paddingOnly(top: 10)
                            ],
                          ).paddingAll(8),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            profileController.captureImage(url);
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.purple,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    ImageConstants.cameraImg,
                                    height: 20,
                                    width: 20,
                                    color: AppColors.whiteColor,
                                  ).paddingOnly(top: 15, bottom: 15)),
                              Text("Camera",
                                      style: AppStyles.arimoRegular.copyWith(
                                          fontSize: 14,
                                          color: AppColors.greyColor))
                                  .paddingOnly(top: 10)
                            ],
                          ).paddingAll(8),
                        ),
                      ],
                    ).paddingOnly(left: 5),
                  ],
                ),
              ),
            ));
  }

  Padding _fatherPassportDetails(
      double width, ProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black12, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Father Passport",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
                  InkWell(
                      onTap: () {
                        //editProfile(1,profileController);
                        selectValue = 3;
                        profileController.checkEditView(selectValue);
                      },
                      child: const SMSImageAsset(
                        image: "assets/edit_icons.png",
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Passport Number",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.passportNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Residence Permit No",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.residencePermitNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date of Issue ",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.dateOfIssue ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date of Expiry",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.dateOfExpiry ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Place of Issue",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.placeOfIssue ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Civil ID No",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.civilIdNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date of Res, Permit Expiry",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.dateOfExpiry ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date of Res, Permit Issue",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.passportDetail?.dateOfResPermitIssue ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date (Father Entered Kuwait)",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        profileController.profileModel?.profileData
                                ?.passportDetail?.enteredCountryDate ??
                            "",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _motherDetails(double width, ProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black12, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headingText("Mother Details"),
                  InkWell(
                      onTap: () {
                        //editProfile(1,profileController);
                        selectValue = 2;
                        profileController.checkEditView(selectValue);
                      },
                      child: const SMSImageAsset(
                        image: "assets/edit_icons.png",
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _show(Get.context!, profileController,
                    "ApiHelper.profileMotherPhotoEdit");
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.solid),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(profileController.profileModel
                                      ?.profileData?.motherDetail?.photo ??
                                  ""))),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: AppColors.darkPinkColor,
                          border: Border.all(
                              width: 1,
                              color: AppColors.darkPinkColor,
                              style: BorderStyle.solid),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_sharp,
                          color: AppColors.whiteColor,
                          size: 13,
                        )).paddingOnly(left: 30, top: 30),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.name ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Profession",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.professionName ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Religion",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.religionName ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Monthly Income",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.faIncomePerMonth ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Mobile Number",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.phoneNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("WhatsApp Number",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.motherDetail?.whatsAppNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email Address",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        profileController.profileModel?.profileData
                                ?.motherDetail?.email ??
                            "",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Office Address",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        profileController.profileModel?.profileData
                                ?.motherDetail?.officeAddress ??
                            "",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _fatherDetails(double width, ProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black12, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Father details",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
                  InkWell(
                      onTap: () {
                        //editProfile(1,profileController);
                        selectValue = 1;
                        profileController.checkEditView(selectValue);
                      },
                      child: const SMSImageAsset(
                        image: "assets/edit_icons.png",
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _show(Get.context!, profileController,
                    "ApiHelper.profileFatherPhotoEdit");
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.black,
                              style: BorderStyle.solid),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(profileController.profileModel
                                      ?.profileData?.fatherDetail?.photo ??
                                  ""))),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: AppColors.darkPinkColor,
                          border: Border.all(
                              width: 1,
                              color: AppColors.darkPinkColor,
                              style: BorderStyle.solid),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_sharp,
                          color: AppColors.whiteColor,
                          size: 13,
                        )).paddingOnly(left: 30, top: 30),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.name ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Profession",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.professionName ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Religion",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.religionName ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Monthly Income",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.faIncomePerMonth ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Mobile Number",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.phoneNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("WhatsApp Number",
                              style:
                                  AppStyles.NunitoLight.copyWith(fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              profileController.profileModel?.profileData
                                      ?.fatherDetail?.whatsAppNo ??
                                  "",
                              style: AppStyles.NunitoRegular.copyWith(
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email Address",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        profileController.profileModel?.profileData
                                ?.fatherDetail?.email ??
                            "",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Office Address",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        profileController.profileModel?.profileData
                                ?.fatherDetail?.officeAddress ??
                            "",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _studentDetails(double width) {
    return studentData.isNotEmpty
        ? Container(
            width: width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.black12, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Student Details",
                      style: AppStyles.NunitoExtrabold.copyWith(
                          fontSize: 18)),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: studentData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSizedBox(10),
                          _studentProfilePic(index),
                          _buildSizedBox(20),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                _firstNameOfStudentDetails(width, index),
                                _communityOfStudentDetails(width, index),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                _casteOfStudentDetails(width, index),
                                _subCasteOfStudentDetails(width, index),
                              ],
                            ),
                          ),
                          Divider(height: 1,color: AppColors.greyColor,)
                        ],
                      );
                    }),
              ],
            ),
          )
        : Container();
  }

  InkWell _studentProfilePic(int index) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Colors.black, style: BorderStyle.solid),
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(studentData[index].photo ?? ""))),
        ),
      ),
    );
  }

  Flexible _subCasteOfStudentDetails(double width, int index) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Sub Caste",
                style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(studentData[index].subCaste ?? "",
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Flexible _casteOfStudentDetails(double width, int index) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Caste", style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(studentData[index].caste ?? "",
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Flexible _communityOfStudentDetails(double width, int index) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Community",
                style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(studentData[index].community ?? "",
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Flexible _firstNameOfStudentDetails(double width, int index) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("First Name",
                style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(studentData[index].studentName ?? "",
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _fatherEditDetailsWidget(
      ProfileController profileController, double width) {
    return Visibility(
      visible: profileController.fatherDetailsView ? true : false,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headingText(
                    "Father details",
                  ),
                  _buildSizedBox(10),
                  _basicDetailsInfoText(),
                  _buildSizedBox(20),
                  _buildText("Father Email Address"),
                  _buildSizedBox(10),
                  _fatherEmailTextFormField(profileController,
                      profileController.fatherEmailController),
                  _buildSizedBox(20),
                  _buildText("Mobile Number"),
                  _buildSizedBox(10),
                  _fatherMobileNumberTextField(profileController,
                      profileController.fatherMobileController),
                  _buildSizedBox(20),
                  _buildText("WhatsApp Number"),
                  _buildSizedBox(10),
                  _fatherwtsappNumberTexFormField(profileController,
                      profileController.fatherWhatsAppController),
                  _buildSizedBox(20),
                  _buildText("Landline Number"),
                  _buildSizedBox(10),
                  _fatherLandlineNumTextField(profileController,
                      profileController.fatherLandlineController),
                  _buildSizedBox(20),
                  _buildText("Father profession"),
                  _buildSizedBox(20),
                  _professionDropdown(profileController),
                  _buildSizedBox(20),
                  _buildText(
                    "Father Religion",
                  ),
                  _buildSizedBox(20),
                  _religionDropdown(width, profileController),
                  _buildSizedBox(20),
                  _buildText(
                    "Office Address",
                  ),
                  _buildSizedBox(10),
                  _fatherOfficeAddressTextField(profileController,
                      profileController.fatherOfficeAddressController),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _cancelButton(profileController, 1),
                    _buildSizedBox(20),
                    _fatherSubmitButton(profileController, width)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _fatherSubmitButton(
      ProfileController profileController, double width) {
    return SMSButtonWidget(
      onPress: () async {
        if ((profileController.fatherEmailController.text.isNotEmpty) &&
            (EmailValidator.validate(
                profileController.fatherEmailController.text))) {
          if (profileController.fatherMobileController.text.isNotEmpty &&
              profileController.fatherMobileController.text.length == 10) {
            Map<String, dynamic> profileEditData = {
              "father_email": profileController.fatherEmailController.text,
              "father_phone_no": profileController.fatherMobileController.text,
              "father_whats_app_no":
                  profileController.fatherWhatsAppController.text,
              "father_telephone_no":
                  profileController.fatherLandlineController.text,
              "father_profession_id": profileController.professionId,
              "father_religion_id": profileController.religionId,
              "father_office_address":
                  profileController.fatherOfficeAddressController.text,
            };
            ProfileResponceModel? profileModel =
                await profileController.fatherProfileEdit(profileEditData);
            if (profileModel != null && profileModel.code == 200) {
              showToastMsg(profileModel.status);
              profileController.getProfile();
              profileController.updateAfterEditing(
                  motherDetails: false,
                  fatherDetails: false,
                  fatherPassportDetails: false);
            } else {
              showToastMsg(profileModel?.status ?? "");
            }
          } else {
            showToastMsg("10 digits Mobile Number is required");
          }
        } else {
          showToastMsg("Invalid Email Address");
        }
      },
      text: "Submit",
      width: width * 0.1,
      height: 35,
      borderRadius: 20,
      primaryColor: AppColors.darkPinkColor,
    );
  }

  Widget _motherEditDetailsWidget(
      ProfileController profileController, double width) {
    return Visibility(
      visible: profileController.motherDetailsView ? true : false,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headingText("Mother Details"),
                  _buildSizedBox(20),
                  _basicDetailsInfoText(),
                  _buildSizedBox(20),
                  _buildText(
                    "Mother Email Address",
                  ),
                  _buildSizedBox(10),
                  _fatherEmailTextFormField(profileController,
                      profileController.motherEmailController),
                  _buildSizedBox(20),
                  _buildText(
                    "Mobile Number",
                  ),
                  _buildSizedBox(20),
                  _fatherMobileNumberTextField(profileController,
                      profileController.motherMobileController),
                  _buildSizedBox(20),
                  _buildText(
                    "WhatsApp Number",
                  ),
                  _buildSizedBox(10),
                  _fatherwtsappNumberTexFormField(profileController,
                      profileController.motherWhatsAppController),
                  _buildSizedBox(10),
                  _buildText(
                    "Landline Number",
                  ),
                  _buildSizedBox(10),
                  _fatherLandlineNumTextField(profileController,
                      profileController.motherLandlineController),
                  _buildSizedBox(20),
                  _buildText("Mother profession"),
                  _buildSizedBox(20),
                  _professionDropdown(profileController),
                  _buildSizedBox(20),
                  _buildText(
                    "Mother Religion",
                  ),
                  _buildSizedBox(20),
                  _religionDropdown(width, profileController),
                  _buildSizedBox(20),
                  _buildText(
                    "Office Address",
                  ),
                  _buildSizedBox(10),
                  _fatherOfficeAddressTextField(profileController,
                      profileController.motherOfficeAddressController)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _cancelButton(profileController, 2),
                    _buildSizedBox(20),
                    _motherSubmitButton(profileController, width)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _motherSubmitButton(
      ProfileController profileController, double width) {
    return SMSButtonWidget(
      onPress: () async {
        if ((profileController.motherEmailController.text.isNotEmpty) &&
            (EmailValidator.validate(
                profileController.motherEmailController.text))) {
          if (profileController.motherMobileController.text.isNotEmpty &&
              profileController.motherMobileController.text.length == 10) {
            Map<String, dynamic> sendData = {
              "mother_email": profileController.motherEmailController.text,
              "mother_phone_no": profileController.motherMobileController.text,
              "mother_whats_app_no":
                  profileController.motherWhatsAppController.text,
              "mother_telephone_no":
                  profileController.motherLandlineController.text,
              "mother_profession_id": profileController.professionId,
              "mother_religion_id": profileController.religionId,
              "mother_office_address":
                  profileController.motherOfficeAddressController.text,
            };
            ProfileResponceModel? profileModel =
                await profileController.motherProfileEdit(sendData);
            if (profileModel != null && profileModel.code == 200) {
              showToastMsg(profileModel.status);
              profileController.getProfile();
              profileController.updateAfterEditing(
                  motherDetails: false,
                  fatherDetails: false,
                  fatherPassportDetails: false);
            } else {
              showToastMsg(profileModel?.status ?? "");
            }
          } else {
            showToastMsg("10 digits Mobile Number is required");
          }
        } else {
          showToastMsg("Invalid Email Address");
        }
      },
      text: "Submit",
      width: width * 0.1,
      height: 35,
      borderRadius: 20,
      primaryColor: AppColors.darkPinkColor,
    );
  }

  Visibility _passportEditDetailsWidget(
      ProfileController profileController, BuildContext context, double width) {
    return Visibility(
      visible: profileController.passportDetailsView ? true : false,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headingText(
                    "Father Passport",
                  ),
                  _buildSizedBox(10),
                  _basicDetailsInfoText(),
                  _buildSizedBox(20),
                  _buildText(
                    "Passport No",
                  ),
                  _buildSizedBox(10),
                  _numberTextFormField(profileController,
                      profileController.passportNoController),
                  _buildSizedBox(20),
                  _buildText(
                    "Date of Issue",
                  ),
                  _buildSizedBox(10),
                  _dateTextField(profileController,
                      profileController.dateOfIssueController),
                  _buildSizedBox(20),
                  _buildText(
                    "Date of Expiry",
                  ),
                  _buildSizedBox(10),
                  _dateTextField(profileController,
                      profileController.dateOfExpiryController),
                  _buildSizedBox(20),
                  _buildText(
                    "Place of Issue",
                  ),
                  _buildSizedBox(10),
                  _numberTextFormField(profileController,
                      profileController.placeOfIssueController),
                  _buildSizedBox(20),
                  _buildText(
                    "Residence Permit No",
                  ),
                  _buildSizedBox(10),
                  _resPermitNoTextField(profileController),
                  _buildSizedBox(20),
                  _buildText(
                    "Civil Id No",
                  ),
                  _buildSizedBox(10),
                  _numberTextFormField(
                      profileController, profileController.civilIdNoController),
                  _buildSizedBox(20),
                  _buildText(
                    "Date of Res. Permit Expiry",
                  ),
                  _buildSizedBox(10),
                  _dateTextField(profileController,
                      profileController.dateOfResPermitExpiryController),
                  _buildSizedBox(20),
                  _buildText(
                    "Date of Res. Permit Issue",
                  ),
                  _buildSizedBox(10),
                  _dateTextField(profileController,
                      profileController.dateOfResPermitIssueController),
                  _buildSizedBox(20),
                  _buildText(
                    "Date (Father Entred Kuwait)",
                  ),
                  _buildSizedBox(10),
                  _dateTextField(profileController,
                      profileController.enteredCountryDateController),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _cancelButton(profileController, 3),
                    _buildSizedBox(20),
                    _fatherPassportSubmit(profileController, width)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _fatherPassportSubmit(
      ProfileController profileController, double width) {
    return SMSButtonWidget(
      onPress: () async {
        if (profileController.passportNoController.text.isNotEmpty) {
          if (profileController.dateOfIssueController.text.isNotEmpty) {
            if (profileController.dateOfExpiryController.text.isNotEmpty) {
              if (profileController.placeOfIssueController.text.isNotEmpty) {
                if (profileController.civilIdNoController.text.isNotEmpty) {
                  Map<String, dynamic> mapData = {
                    "passport_no":
                        profileController.passportNoController.text.toString(),
                    "date_of_issue":
                        profileController.dateOfIssueController.text.toString(),
                    "date_of_expiry": profileController
                        .dateOfExpiryController.text
                        .toString(),
                    "place_of_issue": profileController
                        .placeOfIssueController.text
                        .toString(),
                    "civil_id_no":
                        profileController.civilIdNoController.text.toString(),
                    "residence_permit_no":
                        profileController.resPermitNoController.text.toString(),
                    "date_of_res_permit_issue": profileController
                        .dateOfResPermitIssueController.text
                        .toString(),
                    "entered_country_date": profileController
                        .enteredCountryDateController.text
                        .toString()
                  };
                  ProfileResponceModel? profileModel = await profileController
                      .fatherPassportProfileEdit(mapData);
                  if (profileModel != null && profileModel.code == 200) {
                    showToastMsg(profileModel.status);
                    profileController.getProfile();
                    profileController.updateAfterEditing(
                        motherDetails: false,
                        fatherDetails: false,
                        fatherPassportDetails: false);
                  } else {
                    showToastMsg(profileModel?.status ?? "");
                  }
                } else {
                  showToastMsg("Civil Id No is required");
                }
              } else {
                showToastMsg("Place of Issue is required");
              }
            } else {
              showToastMsg("Date of Expiry is required");
            }
          } else {
            showToastMsg("Date of Issue is required");
          }
        } else {
          showToastMsg("Passport No is required");
        }
      },
      text: "Submit",
      width: width * 0.1,
      height: 35,
      borderRadius: 20,
      primaryColor: AppColors.darkPinkColor,
    );
  }

  TextButton _cancelButton(ProfileController profileController, int value) {
    return TextButton(
        onPressed: () {
          profileController.checkEditView(value);
        },
        child: Text(
          "CANCEL",
          style: AppStyles.NunitoRegular.copyWith(
              color: Colors.black, fontSize: 15),
        ));
  }

  Text _headingText(String text) {
    return Text(text, style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18));
  }

  Text _basicDetailsInfoText() {
    return Text(
        "You can change or modify your basic details information at anytime",
        style: AppStyles.NunitoLight.copyWith(fontSize: 15));
  }

  TextFormField _fatherOfficeAddressTextField(
      ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 5,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  Container _professionDropdown(ProfileController profileController) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: profileController.updateProfessionSelectedValue.isNotEmpty
              ? profileController.updateProfessionSelectedValue
              : profileController.professionData.isNotEmpty
                  ? profileController.professionData.first.name
                  : "",
          icon: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.arrow_drop_down),
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
          onChanged: (data) {
            profileController.professionUpdate(data!);
          },
          items: profileController.professionData //listItem
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(value.name ?? ""),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container _religionDropdown(
      double width, ProfileController profileController) {
    return Container(
      height: 45,
      width: width * 0.94,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: profileController.updateReligionSelectedValue.isNotEmpty
              ? profileController.updateReligionSelectedValue
              : profileController.religionData.isNotEmpty
                  ? profileController.religionData.first.name
                  : "",
          icon: const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.arrow_drop_down),
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
          onChanged: (data) {
            profileController.religionUpdate(data!);
          },
          items: profileController.religionData //listItem
              .map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value.name,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(value.name ?? ""),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  TextFormField _fatherLandlineNumTextField(ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.phone,
        maxLines: null,
        minLines: 1,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _dateTextField(ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        readOnly: true,
        keyboardType: TextInputType.text,
        controller: textEditingController,
        maxLines: null,
        minLines: 1,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _numberTextFormField(ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.text,
        maxLines: null,
        minLines: 1,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _resPermitNoTextField(ProfileController profileController) {
    return TextFormField(
        keyboardType: TextInputType.text,
        maxLines: null,
        minLines: 1,
        controller: profileController.resPermitNoController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _fatherwtsappNumberTexFormField(
      ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.phone,
        maxLines: null,
        minLines: 1,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _fatherMobileNumberTextField(
      ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.phone,
        maxLines: null,
        minLines: 1,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  Text _buildText(String text) {
    return Text(text,
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  TextFormField _fatherEmailTextFormField(ProfileController profileController,
      TextEditingController textEditingController) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        maxLines: null,
        controller: textEditingController,
        cursorColor: AppColors.darkPinkColor,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  Future<void> datePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
  }
}
