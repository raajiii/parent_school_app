import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../apihelper/api_helper.dart';
import '../../model/attendance_overview_model.dart';
import '../../model/dashboard_model.dart';
import '../../model/month_list_model.dart';
import '../../model/payment_overview_model.dart';
import '../../model/student_details_model.dart';
import '../../services/base_client.dart';
import '../../view/dialogs/dialog_helper.dart';
import '../../view/screens/storage.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PaymentOverviewModel? paymentOverviewModel;
  AttendanceOverviewModel? attendanceOverviewModel;
  AttendanceOverViewData? attendanceOverviewData;
  List<SubjectList> subjectList = [];
  int? currentMonthId;
  late AnimationController lottieController;
  List<StudentData> studentData = [];
  PackageInfo? packageInfo;

  @override
  void onInit() async {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    packageInfo = await PackageInfo.fromPlatform();
    LocalStorage.setValue("versionName", packageInfo?.version ?? "");
    fetchStudentDetails();
    fetchAvailableLanguage();
    paymentOverview();
    fetchMonthList();
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  Future fetchStudentDetails() async {
    try {
      final result = await BaseService().getData("ApiHelper.studentDetailsUrl");
      if (result != null) {
        if (result.statusCode == 200) {
          StudentDetailsModel studentDetailsModel =
              StudentDetailsModel.fromJson(result.data);
          studentData = studentDetailsModel.studentData;
          LocalStorage.setValue("studentDetails", studentData);
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future fetchMonthList() async {
    try {
      final result = await BaseService().getData("ApiHelper.monthListUrl");
      if (result != null) {
        if (result.statusCode == 200) {
          MonthListModel monthListModel = MonthListModel.fromJson(result.data);
          List<MonthListData> monthList = monthListModel.monthData;
          if (monthList.isNotEmpty) {
            for (var element in monthList) {
              if (element.commonName ==
                  DateFormat("MMMM").format(DateTime.now()).trim()) {
                currentMonthId = element.id;
              }
            }
            if (currentMonthId != null) {
              attendanceOverview(id: currentMonthId);
            }
          }
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future fetchAvailableLanguage() async {
    try {
      final result = await BaseService().getData(
          "${"ApiHelper.dashboardUrl"}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null) {
        if (result.statusCode == 200) {
          DashboardModel dashboardModel = DashboardModel.fromJson(result.data);
          DashboardData dashboardData = dashboardModel.dashboardData;
          subjectList = dashboardData.subjectList ?? [];
        } else {
          showToastMsg("Something went wrong");
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future paymentOverview() async {
    try {
      final result = await BaseService().getData(
          "${"ApiHelper.feePayment"}student_id=${LocalStorage.getValue('studentId')}");
      if (result != null) {
        if (result.statusCode == 200) {
          paymentOverviewModel = PaymentOverviewModel.fromJson(result.data);
        } else {
          paymentOverviewModel = PaymentOverviewModel(
              status: "Failed",
              code: 400,
              error: paymentOverviewModel?.error ?? "");
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }

  Future attendanceOverview({int? id}) async {
    try {
      final result = await BaseService().getData(
          "${"ApiHelper.attendanceOverviewUrl"}student_id=${LocalStorage.getValue('studentId')}&month_list_id=$id");
      if (result != null) {
        if (result.statusCode == 200) {
          attendanceOverviewModel =
              AttendanceOverviewModel.fromJson(result.data);
          attendanceOverviewData =
              attendanceOverviewModel?.attendanceOverviewData;
        } else {
          attendanceOverviewModel = AttendanceOverviewModel(
              status: "Failed",
              code: 400,
              error: attendanceOverviewModel?.error ?? "");
        }
      }
    } catch (e) {
      print('Home Payment Overview $e');
    }
    update();
  }
}
