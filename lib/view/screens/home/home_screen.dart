import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../../const/colors.dart';
import '../../../const/image_constants.dart';
import '../../../controllers/home_controller/home_screen_controller.dart';
import '../../../model/attendance_overview_model.dart';
import '../../../routes/app_routes.dart';
import '../../../themes/app_styles.dart';
import '../../widgets/common_widgets.dart';
import 'package:get/get.dart';
import '../../../const/contsants.dart';
import '../../../enums/enum_navigation.dart';
import '../../widgets/utils.dart';
import '../profile/profile_main.dart';
import '../storage.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (homeController) {
              return _buildBody(context, homeController);
            }),
        drawer: _buildDrawer());
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeaderWidget(),
          _homeworkWithMenuItems(),
          _paymentWithMentItems(),
          _examMAnagerWithMenuItems(),
          _onlineClassesWithMenuItems(),
          _libraryWithMenuItems(),
          _inventoryWithMenuItems(),
          _extraActivitiesWithMEnuItems(),
          _schoolCalenderWidget(),
          _diverWidget(),
          _logoutWidget(),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeController homeController) {
    return SafeArea(
      child: Stack(
        children: [
          _homeBgColor(),
          _homeBgImage(),
          _rotatedHomeBg(context),
          _homeAppbarWidget(homeController),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildSizedBoxHeight(height: 60),
                _wishMsgWidget(context, homeController),
                _buildSizedBoxHeight(height: 30),
                _availableLanguages(context, homeController),
                _buildSizedBoxHeight(height: 15),
                _paymentCardView(context, homeController),
                _availableMenuItems(),
                overallAttendanceCard(context, homeController)
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _logoutWidget() {
    return ListTile(
      leading: const Icon(
        Icons.login,
        color: AppColors.darkPinkColor,
        size: 20,
      ),
      onTap: () {
        LocalStorage.setValue('login', false);
        LocalStorage.setValue('token', "");
        LocalStorage.setValue("studentId", "");
        Get.offAllNamed(AppRoutes.LOGINVIEW);
      },
      title: Text(
        Constants.LOGOUT,
        style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
      ),
    );
  }

  Widget _diverWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        height: 2,
        color: AppColors.greyColor,
      ),
    );
  }

  Widget _schoolCalenderWidget() {
    return ListTile(
        leading: const SMSImageAsset(
          image: ImageConstants.schoolCalnderImg,
          height: 20,
          width: 20,
        ),
        onTap: () {
          updateStatusOfTheRoute(Status.SCHOOLCALENDER);
        },
        title: Text(
          Constants.SCHOOLCALENDER,
          style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
        ));
  }

  Widget _extraActivitiesWithMEnuItems() {
    return SideMenu(
        headingText: Constants.EXTRAACTIVITIES,
        imageLeading: ImageConstants.extraActivitiesImg,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.message_sharp),
              title: Text(
                Constants.EXTRACURRICULAR,
                style: buildTextStyle(),
              ),
              onTap: () {
                updateStatusOfTheRoute(Status.EXTRACURRICULAR);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message_sharp),
              title: Text(
                Constants.REFRESHMENT,
                style: buildTextStyle(),
              ),
              onTap: () {
                updateStatusOfTheRoute(Status.REFRESHMENT);
              },
            ),
          ],
        ));
  }

  Widget _inventoryWithMenuItems() {
    return SideMenu(
        headingText: Constants.INVENTORY,
        imageLeading: ImageConstants.inventoryImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.MATERIALBILL,
              image: ImageConstants.materialBill,
              onTapped: () {
                updateStatusOfTheRoute(Status.MATERIALBILL);
              },
            ),
        /*    SubMenu(
              text: Constants.MATERIALBILLISSUED,
              image: ImageConstants.materialBill,
              onTapped: () {
                updateStatusOfTheRoute(Status.MATERIALBILLISSUED);
              },
            ),*/
          ],
        ));
  }

  Widget _libraryWithMenuItems() {
    return SideMenu(
        headingText: Constants.LIBRARY,
        imageLeading: ImageConstants.libraryImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.BARROWLIST,
              image: ImageConstants.barrowImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.BARROWLIST);
              },
            ),
            SubMenu(
              text: Constants.RETURNLIST,
              image: ImageConstants.returnListImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.RENEWLIST);
              },
            ),
            SubMenu(
              text: Constants.FINELIST,
              image: ImageConstants.fineListImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.FINELIST);
              },
            ),
            SubMenu(
              text: Constants.FINEINVOICE,
              image: ImageConstants.fineInvoiceImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.FINEINVOICE);
              },
            ),
          ],
        ));
  }

  Widget _onlineClassesWithMenuItems() {
    return SideMenu(
        headingText: Constants.ONLINECLASS,
        imageLeading: ImageConstants.onlineClassImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.LIVECLASSES,
              image: ImageConstants.liveClassImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.LIVECLASSES);
              },
            ),
            SubMenu(
              text: Constants.STUDYLAB,
              image: ImageConstants.studyLabImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.STUDYLAB);
              },
            ),
          ],
        ));
  }

  Widget _examMAnagerWithMenuItems() {
    return SideMenu(
        headingText: Constants.EXAMMANAGER,
        imageLeading: ImageConstants.examManagerImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.EXAMRESULT,
              image: ImageConstants.examResultImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.EXAMRESULT);
              },
            ),
            SubMenu(
              text: Constants.EXAMTIMETABLE,
              image: ImageConstants.examTimeTableImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.EXAMTIMETABLE);
              },
            ),
          ],
        ));
  }

  Widget _paymentWithMentItems() {
    return SideMenu(
        headingText: Constants.PAYMENTINVOICE,
        imageLeading: ImageConstants.paymentAndInvoiceImg,
        child: Column(
          children: [
            SubMenu(
              text: Constants.FEEPAYMENT,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.FEEPAYMENT);
              },
            ),
            SubMenu(
              text: Constants.FEEINVOICE,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.FEEINVOICE);
              },
            ),
            SubMenu(
              text: Constants.FEEPENDING,
              image: ImageConstants.vehicleTrackImg,
              onTapped: () {
                updateStatusOfTheRoute(Status.FEEPENDING);
              },
            ),
          ],
        ));
  }

  Widget _homeworkWithMenuItems() {
    return SideMenu(
      headingText: Constants.DAILYACTIVITIES,
      imageLeading: ImageConstants.dailyActivitesImg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SubMenu(
            text: Constants.HOMEWRK,
            image: ImageConstants.homeworkImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.HOMEWORK);
            },
          ),
          SubMenu(
            text: Constants.CLASSTEST,
            image: ImageConstants.classTestImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.CLASSTEST);
            },
          ),
          SubMenu(
            text: Constants.ATTENDANCEDETAILS,
            image: ImageConstants.attendanceDetailsImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.ATTENDANCEDETAILS);
            },
          ),
          SubMenu(
            text: Constants.CLASSTIMETABLE,
            image: ImageConstants.classTestImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.CLASSTIMETABLE);
            },
          ),
          SubMenu(
            text: Constants.CIRCULAR,
            image: ImageConstants.circularImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.CIRCULAR);
            },
          ),
          SubMenu(
            text: Constants.EVENT,
            image: ImageConstants.eventImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.EVENT);
            },
          ),
          SubMenu(
            text: Constants.NEWS,
            image: ImageConstants.newsImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.NEWS);
            },
          ),
          SubMenu(
            text: Constants.SMS,
            image: ImageConstants.smsImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.SMS);
            },
          ),
          SubMenu(
            text: Constants.VOICE,
            image: ImageConstants.voiceImage,
            onTapped: () {
              updateStatusOfTheRoute(Status.VOICE);
            },
          ),
          SubMenu(
            text: Constants.STAFFDETAILS,
            image: ImageConstants.staffImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.STAFFDETAILS);
            },
          ),
          SubMenu(
            text: Constants.VEHICLETRACKING,
            image: ImageConstants.vehicleTrackImg,
            onTapped: () {
              updateStatusOfTheRoute(Status.VEHICLETRACKING);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerHeaderWidget() {
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 0.0),
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Stack(
        children: [
          _homeBgColor(),
          _homeBgImage(),
          Center(
            child: Row(
              children: [_profileDrawerImage(), _userData()],
            ),
          ),
          _version()
        ],
      ),
    );
  }

  Widget _version() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        "Version : ${LocalStorage.getValue("versionName")}      ",
        style: AppStyles.normal
            .copyWith(fontSize: 13, color: AppColors.whiteColor),
      ).paddingOnly(bottom: 5),
    );
  }

  Widget _userData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalStorage.getValue("username") ?? "",
          style: arimoBoldTextStyle(fontSize: 15, color: AppColors.whiteColor),
        ),
        Text(
          LocalStorage.getValue("code") ?? "",
          style: AppStyles.normal
              .copyWith(fontSize: 13, color: AppColors.whiteColor),
        ).paddingOnly(top: 5, bottom: 5),
        Text(
          LocalStorage.getValue("phoneNumber") ?? "",
          style: AppStyles.normal
              .copyWith(fontSize: 14, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Widget _profileDrawerImage() {
    return Container(
        width: 120.0,
        height: 70.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: AppColors.blackColor),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(LocalStorage.getValue("photo") ?? ""))));
  }

  Widget _availableMenuItems() {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        children: [
          _firstRow(),
          _secondRow(),
          _thirdRow(),
          _fourthRow(),
        ],
      ),
    );
  }

  Widget _fourthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.voiceDash,
          text: Constants.VOICE,
          status: Status.VOICE,
        ),
        SelectCard(
          image: ImageConstants.staffDash,
          text: Constants.STAFFDETAILS,
          status: Status.STAFFDETAILS,
        ),
        SelectCard(
          image: ImageConstants.schoolCalenderDashImg,
          text: Constants.CALENDER,
          status: Status.SCHOOLCALENDER,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.eventDash,
          text: Constants.EVENT,
          status: Status.EVENT,
        ),
        SelectCard(
          image: ImageConstants.newsDash,
          text: Constants.NEWS,
          status: Status.NEWS,
        ),
        SelectCard(
          image: ImageConstants.smsDashIcon,
          text: Constants.SMS,
          status: Status.SMS,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.examResultDash,
          text: Constants.EXAMRESULT,
          status: Status.EXAMRESULT,
        ),
        SelectCard(
          image: ImageConstants.examTimeTableDash,
          text: Constants.EXAMTIMETABLE,
          status: Status.EXAMTIMETABLE,
        ),
        SelectCard(
          image: ImageConstants.circularDash,
          text: Constants.CIRCULAR,
          status: Status.CIRCULAR,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20);
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SelectCard(
          image: ImageConstants.homeworkDashImg,
          text: Constants.HOMEWRK,
          status: Status.HOMEWORK,
        ),
        SelectCard(
          image: ImageConstants.classTestDashImg,
          text: Constants.CLASSTEST,
          status: Status.CLASSTEST,
        ),
        SelectCard(
          image: ImageConstants.classTimeTableDash,
          text: Constants.CLASSTIMETABLE,
          status: Status.CLASSTIMETABLE,
        ),
      ],
    ).paddingOnly(left: 10.0, right: 10, bottom: 20, top: 10);
  }

  Widget _buildSizedBoxHeight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _wishMsgWidget(BuildContext context, HomeController homeController) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: timeOfTheDayWidget(homeController),
    );
  }

  Widget timeOfTheDayWidget(HomeController homeController) {
    int timeOfTheDay = DateTime.now().hour;
    String text = "";
    String text1 = '';
    String image = "";
    if (timeOfTheDay >= 0 && timeOfTheDay < 12) {
      text = Constants.goodmorning;
      text1 = Constants.goodMorningMsg;
      image = ImageConstants.morningJsonImg;
    } else if (timeOfTheDay >= 12 && timeOfTheDay < 16) {
      text = Constants.goodAfternoon;
      text1 = Constants.goodAfternoonMsg;
      image = ImageConstants.afternoonJsonImg;
    } else if (timeOfTheDay >= 16 && timeOfTheDay < 21) {
      text = Constants.goodEvng;
      text1 = Constants.goodEvenungMsg;
      image = ImageConstants.eveningJsonImg;
    } else if (timeOfTheDay >= 21 && timeOfTheDay < 24) {
      text = Constants.goodnyt;
      image = ImageConstants.nightJsonImg;
      text1 = Constants.goodnytMsg;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              text,
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 18, color: AppColors.whiteColor),
            ),
            subtitle: Text(text1,
                    style: AppStyles.NunitoRegular.copyWith(
                        fontSize: 15, color: AppColors.whiteColor))
                .paddingOnly(top: 5),
          ),
        ),
        Lottie.asset(image,
            width: Get.width * 0.4,
            repeat: true,
            controller: homeController.lottieController,
            onLoaded: (composition) {
          homeController.lottieController
            ..duration = composition.duration
            ..forward();
          homeController.lottieController.repeat();
        })
      ],
    );
  }

  Widget _rotatedHomeBg(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: RotatedBox(
            quarterTurns: -2,
            child: SMSImageAsset(
              image: ImageConstants.dashMaskImg,
              width: MediaQuery.of(context).size.width,
            )));
  }

  Widget _homeBgImage() =>
      const SMSImageAsset(image: ImageConstants.dashMaskImg);

  Widget _homeBgColor() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
      colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
    )));
  }

  Widget _availableLanguages(
      BuildContext context, HomeController homeController) {
    return homeController.subjectList.isEmpty
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.withOpacity(0.1),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.withOpacity(0.1), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5)),
                            child: Center(
                                child: Container(
                              color: Colors.white.withOpacity(0.5),
                            )),
                          ),
                          const Text("            ")
                              .paddingOnly(left: 5, right: 5),
                          Container(
                            width: 30.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.2)),
                            child: const Center(
                                child: Text(
                              "  ",
                            )),
                          ),
                        ],
                      ).paddingAll(5));
                },
              ),
            ),
          )
        : Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: homeController.subjectList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.HOMEWORK);
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColors.whiteColor,
                        child: Row(
                          children: [
                            Container(
                                width: 40.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(homeController
                                                .subjectList[index]
                                                .subject
                                                ?.icon
                                                .toString() ??
                                            ImageConstants.networkSampleImg)))),
                            Text(
                              homeController.subjectList[index].subject?.name
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                  color: AppColors.blackColor, fontSize: 14),
                            ).paddingOnly(left: 5, right: 5),
                            homeController.subjectList[index].subject
                                        ?.homeWorkCount ==
                                    0
                                ? Container()
                                : Container(
                                    width: 30.0,
                                    height: 20.0,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.redColor),
                                    child: Center(
                                        child: Text(
                                            homeController.subjectList[index]
                                                    .subject?.homeWorkCount
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                                color: AppColors.whiteColor))),
                                  ),
                          ],
                        ).paddingAll(5)),
                  );
                }),
          ).paddingOnly(left: 15);
  }

  Widget _homeAppbarWidget(HomeController homeController) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          _key.currentState!.openDrawer();
        },
        child:
            const SMSImageAsset(image: ImageConstants.menuIcon).paddingAll(15),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Get.to(const NotificationsScreen());
          },
        ), //IconButton
        InkWell(
          onTap: () {
            showDialog(
              context: Get.context!,
              builder: (ctx) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.all(5),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Select Children",
                              style: AppStyles.arimBold.copyWith(
                                  fontSize: 18, color: AppColors.blackColor))
                          .paddingOnly(bottom: 25, top: 15),
                      homeController.studentData.isNotEmpty
                          ? ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    LocalStorage.setValue(
                                        "studentId",
                                        homeController
                                            .studentData[index].studentId);
                                    homeController.fetchAvailableLanguage();
                                    homeController.paymentOverview();
                                    homeController.fetchMonthList();
                                    Get.back();
                                    homeController.update();
                                  },
                                  child: ListTile(
                                    leading: Container(
                                        width: 45.0,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.blackColor,
                                                width: 1),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    homeController
                                                        .studentData[index]
                                                        .photo
                                                        .toString())))),
                                    title: Text(
                                        "${homeController.studentData[index].studentName ?? ""} (${homeController.studentData[index].code ?? ""})",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    subtitle: Text(
                                      homeController
                                          .studentData[index].standardSection
                                          .toString(),
                                      style: AppStyles.NunitoLight.copyWith(
                                          fontSize: 12),
                                    ),
                                  ),
                                );
                              })
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.to(Profile());
                          homeController.fetchStudentDetails();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.settings),
                            const Text("View Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                                .paddingOnly(left: 15)
                          ],
                        ).paddingOnly(left: 25, top: 10),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
                  width: 40.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImageConstants.examTimeTableImg))))
              .paddingOnly(right: 10),
        ), //IconButton
      ], //<W
    );
  }

  Widget _paymentCardView(BuildContext context, HomeController homeController) {
    return /*((homeController.paymentOverviewModel != null) &&
            (homeController.paymentOverviewModel!.error!.isEmpty))
        ?*/
        Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.28,
      color: AppColors.toreaBayColor,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Constants.home_key1,
              style: AppStyles.NunitoExtrabold.copyWith(
                  fontSize: 17, color: AppColors.whiteColor),
            ).paddingOnly(left: 20, top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 12.0,
                  percent: percentageCal(homeController.paymentOverviewModel
                          ?.paymentOverviewData?.percentage ??
                      "0.0"),
                  center: Text(
                    homeController.paymentOverviewModel?.paymentOverviewData
                            ?.percentage ??
                        "0.0%",
                    style: const TextStyle(
                        fontSize: 20, color: AppColors.whiteColor),
                  ),
                  progressColor: AppColors.shadeOfIndianRed,
                ),
                Expanded(
                  child: Column(
                    children: [
                      linearProgressBar(
                          containerColor: AppColors.orangeColor,
                          progressColor: AppColors.orangeColor,
                          percentage: 1,
                          amount: homeController.paymentOverviewModel
                                  ?.paymentOverviewData?.total ??
                              "0",
                          text: "Total Fee"),
                      linearProgressBar(
                          progressColor: AppColors.shadeOfIndianRed,
                          containerColor: AppColors.shadeOfIndianRed,
                          percentage: 0,
                          amount: homeController.paymentOverviewModel
                                  ?.paymentOverviewData?.paid ??
                              "0",
                          text: "Total Paid"),
                      linearProgressBar(
                          containerColor: AppColors.cornflowerBlueColor,
                          progressColor: AppColors.cornflowerBlueColor,
                          percentage: 1,
                          amount: homeController.paymentOverviewModel
                                  ?.paymentOverviewData?.pending ??
                              "0",
                          text: "Total Pending"),
                    ],
                  ),
                )
              ],
            ).paddingOnly(left: 25, top: 5),
          ],
        ),
      ).paddingAll(10),
    ) /* : Container()*/;
  }

  Widget overallAttendanceCard(
      BuildContext context, HomeController homeController) {
    return ((homeController.attendanceOverviewModel != null) &&
            (homeController.attendanceOverviewModel!.error!.isEmpty))
        ? Container(
            color: Colors.transparent,
            child: Column(
              children: [
                _buildText(text: Constants.home_key2, fontSize: 16)
                    .paddingOnly(top: 20),
                _todayAttendance(
                    context, homeController.attendanceOverviewModel),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Working Days",
                          homeController.attendanceOverviewData?.noOfWorkingDays
                                  .toString() ??
                              0.toString()),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Presents",
                          homeController.attendanceOverviewData?.present
                                  .toString() ??
                              0.toString()),
                    ),
                  ],
                ).paddingOnly(left: 20, right: 20, top: 20, bottom: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  decoration: _decorationOverview(),
                  child: _cardOfAttendance(
                      "Absent",
                      homeController.attendanceOverviewData?.absent
                              .toString() ??
                          0.toString()),
                ).paddingOnly(left: 20, right: 20),
                _cblazeInfotechText()
              ],
            ),
          )
        : Container();
  }

  Widget _todayAttendance(
      BuildContext context, AttendanceOverviewModel? attendanceModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 15.0,
          percent: percentageCalWithSymbol(
              attendanceModel?.attendanceOverviewData?.percentage ?? "0.0%"),
          center: Text(
            attendanceModel?.attendanceOverviewData?.percentage.toString() ??
                "",
            style: const TextStyle(fontSize: 20, color: AppColors.whiteColor),
          ),
          progressColor: Colors.blue,
        ).paddingOnly(right: 20),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: _decorationOverview(),
          child: Row(
            children: [
              _buildText(text: Constants.home_key3, fontSize: 14)
                  .paddingOnly(left: 10),
              const SMSImageAsset(
                image: ImageConstants.absentSwitch,
                height: 70,
                width: 70,
              )
            ],
          ),
        )
      ],
    ).paddingOnly(top: 10);
  }

  Widget _cardOfAttendance(String txt, String txt2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText(text: txt, fontSize: 14),
            _buildText(text: txt2, fontSize: 14),
          ],
        ).paddingOnly(top: 10, bottom: 10, left: 10, right: 10),
        _attdanceLinearIndicator(),
      ],
    );
  }

  Widget _attdanceLinearIndicator() {
    return LinearPercentIndicator(
      lineHeight: 10.0,
      percent: 0.0,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: AppColors.whiteColor,
    ).paddingOnly(bottom: 5);
  }

  Widget _cblazeInfotechText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Constants.home_key4,
          style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
        ),
        _buildText(text: Constants.home_key5, fontSize: 12),
      ],
    ).paddingOnly(top: 20, bottom: 20.0);
  }

  BoxDecoration _decorationOverview() {
    return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.indigo2Color,
            AppColors.indigo2Color,
          ],
        ));
  }

  Text _buildText({String? text, double? fontSize}) => Text(
        text ?? "",
        style: AppStyles.NunitoExtrabold.copyWith(
            color: AppColors.whiteColor, fontSize: fontSize ?? 15),
      );
}

Widget linearProgressBar(
    {Color? containerColor,
    double? percentage,
    Color? progressColor,
    String? amount,
    String? text}) {
  return Row(
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: containerColor ?? AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
      ).paddingOnly(top: 5, bottom: 5, left: 20, right: 5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.33,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text.toString() ?? "",
                  style:
                      const TextStyle(fontSize: 8, color: AppColors.whiteColor),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: AppColors.whiteColor,
                      size: 10,
                    ),
                    Text(
                      amount.toString() ?? "",
                      style: const TextStyle(
                          fontSize: 8, color: AppColors.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
          ).paddingOnly(top: 5, bottom: 5, left: 10, right: 10),
          LinearPercentIndicator(
            width: MediaQuery.of(Get.context!).size.width * 0.4,
            lineHeight: 4.0,
            percent: percentage ?? 0.0,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: progressColor ?? AppColors.whiteColor,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ],
  );
}

class SideMenu extends StatelessWidget {
  final String headingText;
  final Widget child;
  final String imageLeading;

  SideMenu(
      {Key? key,
      required this.headingText,
      required this.child,
      required this.imageLeading})
      : super(key: key);

  final theme =
      Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: ExpansionTile(
        iconColor: AppColors.darkPinkColor,
        collapsedIconColor: AppColors.darkPinkColor,
        leading: SMSImageAsset(
          image: imageLeading,
          height: 20,
          width: 20,
        ),
        title: Text(
          headingText,
          style: arimoBoldTextStyle(fontSize: 13, color: AppColors.blackColor),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard(
      {Key? key, required this.image, required this.text, required this.status})
      : super(key: key);
  final String text;
  final String image;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateStatusOfTheRoute(status);
      },
      child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 90,
                width: 90,
                child: Card(
                    elevation: 5,
                    child: Center(
                      child: SMSImageAsset(
                        image: image,
                        width: 60,
                        height: 60,
                      ),
                    )),
              ),
              Text(
                text,
                style: AppStyles.arimBold.copyWith(
                  fontSize: 12,
                ),
              ),
            ]),
      ),
    );
  }
}

class SubMenu extends StatelessWidget {
  final String image;
  final String text;
  final Function()? onTapped;

  const SubMenu(
      {Key? key, required this.text, required this.image, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SMSImageAsset(
        height: 15,
        width: 15,
        image: image,
      ),
      title: Text(
        text,
        style: buildTextStyle(),
      ),
      onTap: onTapped,
    );
  }
}

TextStyle buildTextStyle() => const TextStyle(
    color: AppColors.blackColor, fontSize: 12, fontWeight: FontWeight.w400);
