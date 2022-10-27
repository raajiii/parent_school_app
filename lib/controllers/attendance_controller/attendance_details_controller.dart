import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../const/colors.dart';
import '../../enums/enum_navigation.dart';
import '../../model/LeaveListModel.dart';
import '../../model/attendance_model.dart';
import '../../model/leave_create_responce_model.dart';
import '../../services/base_client.dart';
import '../../view/dialogs/dialog_helper.dart';
import '../../view/screens/daily_actvities/attendance/attendance_details_screen.dart';
import '../../view/screens/storage.dart';

class AttendanceDetailsController extends GetxController {
  DateTime? currentDate;
  String startDate = "";
  String endDate = "";
  String selectedLeaveType = 'Select Leave Type';
  bool openDialogValue = false;
  int? editFlag;
  int? leaveRequestId;
  double? noOfLeave;
  AttendanceModel? attendanceModel;
  final loadingState = LeaveListLoadingState(loadingType: LoadingType.stable).obs;
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  LeaveListModel? leaveListModel;
  List<LeaveListData> finalList = <LeaveListData>[].obs;
  final isLoading = true.obs;
  LeaveCreateResponceModel? leaveCreateResponceModel;
  int? selectedLeaveTypeValue = -1;
  List<String> selectedLeaveList1 = [
    'Select Leave Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
    "AN leave in Start date & MN leave in End date"
  ];
  List<String> selectedLeaveList2 = [
    'Select Leave Type',
    'Full Day',
    'AN leave Start date',
    'MN leave to End date',
  ];
  List<ChartData> chartData = [];

  TextEditingController noOfLeaves = TextEditingController();
  TextEditingController leaveDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startDate = "";
    endDate = "";
    // leaveDateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
    chartData = [
      ChartData('Present', 0, const Color.fromRGBO(255, 189, 57, 1)),
      ChartData('Absent', 0, const Color.fromRGBO(9, 0, 136, 1)),
    ];
    getData();
    scrollController.addListener(_scrollListener);
  }

  Future getLeaveListData() async {
    if(_pageNo==1){
      isLoading.value = true;
    }
    try {
      final result = await BaseService().getData("${"ApiHelper.leaveListUrl"}student_id=${LocalStorage.getValue("studentId")}&page=${_pageNo}");
      if (result != null) {
        if (result.statusCode == 200) {
          leaveListModel = LeaveListModel.fromJson(result.data);
          finalList.assignAll(leaveListModel?.data??[]);
          isLoading.value = false;
        }else{
          print("Leave list : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("Leave list $e");

    } finally {

    }
    update();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = LeaveListLoadingState(loadingType: LoadingType.loading);
      try {
        List<LeaveListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getLeaveListData();

        if (listOfData.isEmpty) {
          loadingState.value = LeaveListLoadingState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = LeaveListLoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LeaveListLoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<LeaveCreateResponceModel?> leaveRequestCreate(String url,int type,Map<String, dynamic> userData) async {
    //showLoadingDialog(Get.context!);
    try {
      //dynamic result;
      final result = await BaseService().postData(userData,url);
      /*if(type==1){
        result = await BaseService().postData(userData,ApiHelper.leaveCreateUrl);
      }else{

      }*/

      if (result != null) {
        if (result.statusCode == 200) {
          leaveCreateResponceModel = LeaveCreateResponceModel.fromJson(result.data);
        } else {
          /*leaveCreateResponceModel = LeaveCreateResponceModel(
              status: "Failed",
              code: 400,
              message: result.data.containsKey("message")
                  ? result.data["message"]
                  : "");*/

          print("leaveRequestEdit ${leaveCreateResponceModel?.message}");

        }
      }
    } catch (e) {
      print('Login Screen $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return leaveCreateResponceModel;
  }




  Future getData() async {
    try {
      final result = await BaseService().getData("${"ApiHelper.attendanceUrl"}student_id=${LocalStorage.getValue("studentId")}");
      if (result != null) {
        if (result.statusCode == 200) {
          attendanceModel = AttendanceModel.fromJson(result.data);
          chartData = [
            ChartData('Present ${attendanceModel?.data?.present??0}',attendanceModel?.data?.present??0, AppColors.darkGreenColor),
            ChartData('Absent ${attendanceModel?.data?.absent??0}', attendanceModel?.data?.absent??0, AppColors.darkPinkColor),
          ];
        }
      }
    } catch (e) {
      print("Fee Invoice $e");

    } finally {

    }
    update();
  }


  updateOpenDialogValue(bool value) {
    openDialogValue = value;
    update();
  }

  void updateSelectedLeaveType(List<String> list,String selectedIndex) {

    selectedLeaveType = selectedIndex;
    List.generate(list.length, (index) {

      if(list[index]==selectedLeaveType){

        if(index==1){
          selectedLeaveTypeValue = 0;
        }else if(index==2){
          selectedLeaveTypeValue = 1;
        }else if(index==3){
          selectedLeaveTypeValue = 2;
        }else if(index==4){
          selectedLeaveTypeValue = 3;
        }else{
          selectedLeaveTypeValue = -1;
        }
      }
    });
    print("dropdown assign value : ${selectedLeaveTypeValue}");
    print("dropdown selected : ${selectedLeaveType}");
    update();
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate ?? DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        currentDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      leaveDateController.text =
          DateFormat('yyyy-MM-dd').format(currentDate ?? DateTime.now());
      update();
      return currentDate;
    }
  }

  Future<DateTimeRange?> dateRangeDialog(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime(2070, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'SAVE',
        useRootNavigator: false,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });

    if (result != null) {
      startDate = result.start.toString().split(' ')[0];
      endDate = result.end.toString().split(' ')[0];
      noOfLeaves.text = result.end.difference(result.start).inDays.toString();
      startDateController.text = startDate;
      endDateController.text = endDate;
      update();
      return result;
    }
    return null;
  }
}
