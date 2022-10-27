import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../../const/colors.dart';
import '../../../../controllers/attendance_controller/attendance_details_controller.dart';
import '../../../../model/leave_create_responce_model.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_styles.dart';
import '../../../widgets/common_widgets.dart';
import '../../storage.dart';

class CreateLeaveRequestScreen extends StatefulWidget {
  const CreateLeaveRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateLeaveRequestScreen> createState() =>
      _CreateLeaveRequestScreenState();
}

class _CreateLeaveRequestScreenState extends State<CreateLeaveRequestScreen> {
  int _currentValue = 1;
  @override
  void initState() {
    super.initState();
    _currentValue = 1;
    Get.put<AttendanceDetailsController>(AttendanceDetailsController()).editFlag!=1?
    _selectLeaveWidget():Container();
  }

  void _selectLeaveWidget() {
    Future.delayed(const Duration(seconds: 0), () {
      return  showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(title:
                  GetBuilder<AttendanceDetailsController>(
                      builder: (controller) {
                return Column(
                  children: [
                    Text(
                      "Select Leave",
                      style: AppStyles.NunitoExtrabold.copyWith(
                          fontSize: 15, color: AppColors.darkPinkColor),
                    ),
                    Text(
                      '''Scroll the Number to select the\n           Leave you need''',
                      style: AppStyles.NunitoRegular.copyWith(
                          fontSize: 13, color: AppColors.greyColor),
                    ),
                    _numberLeavesWidget(controller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SMSButtonWidget(
                          onPress: () {
                            if (_currentValue > 1) {
                              controller.dateRangeDialog(context).then((value) {
                                if (value != null) {
                                  Get.back();
                                  controller.updateOpenDialogValue(true);
                                  controller.noOfLeaves.text = value.end
                                      .difference(value.start)
                                      .inDays
                                      .toString();
                                }
                              });
                            } else {
                              controller.selectDate(context).then((value) {
                                if (value != null) {
                                  Get.back();
                                  controller.updateOpenDialogValue(true);
                                  controller.noOfLeaves.text = "1";
                                }
                              });
                            }
                          },
                          text: " SET ",
                          width: 10,
                          height: 40,
                          borderRadius: 5,
                          primaryColor: AppColors.darkPinkColor,
                        ),
                        SMSButtonWidget(
                            onPress: () {
                              Get.toNamed(AppRoutes.LEAVESTATUS);
                            },
                            text: "CANCEL",
                            width: 10,
                            height: 40,
                            borderRadius: 5,
                            primaryColor: AppColors.darkPinkColor),
                      ],
                    )
                  ],
                );
              })));
    });
  }

  Widget _numberLeavesWidget(AttendanceDetailsController controller) {
    return StatefulBuilder(builder: (context4, setState2) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: NumberPicker(
          textStyle: AppStyles.NunitoRegular.copyWith(
              color: AppColors.greyColor, fontSize: 14),
          selectedTextStyle: AppStyles.NunitoRegular.copyWith(
              color: AppColors.blackColor, fontSize: 14),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
              top: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          value: _currentValue,
          minValue: 1,
          maxValue: 100,
          onChanged: (value) {
            setState2(() {
              _currentValue = value;
              controller.noOfLeaves.text = _currentValue.toString();
              controller.update();
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     String? endDateTxt;
     String? startDateTxt;
    return Scaffold(
        appBar: smsAppbar("Create Leave Request"),
        body: GetBuilder<AttendanceDetailsController>(
            builder: (attendanceController) {
          return Visibility(
            visible: attendanceController.editFlag!=1?attendanceController.openDialogValue ? true : false:true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText("No of Leaves"),
                  SMSTextFieldWidget(
                    controller: attendanceController.noOfLeaves,
                    onTap: () {
                      attendanceController.noOfLeaves.text = "";
                      attendanceController.startDateController.text = "";
                      attendanceController.endDateController.text = "";
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              title:
                                  _numberLeavesWidget(attendanceController)));
                    },
                  ).paddingOnly(bottom: 20),
                   double.parse(attendanceController.noOfLeaves.text).toInt() > 1 //_currentValue
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildText("Start Date"),
                            SMSTextFieldWidget(
                              controller:
                                  attendanceController.startDateController,
                              onTap: () {
                                attendanceController.dateRangeDialog(context);
                              },
                            ).paddingOnly(bottom: 20),
                            _buildText("End Date"),
                            SMSTextFieldWidget(
                              controller:
                                  attendanceController.endDateController,
                              onTap: () {
                                attendanceController.dateRangeDialog(context);
                              },
                            ).paddingOnly(bottom: 20),
                          ],
                        ) : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildText("Leave Date"),
                            SMSTextFieldWidget(
                              controller:
                                  attendanceController.leaveDateController,
                            ).paddingOnly(bottom: 20),
                          ],
                        ),
                  _buildText("Leave Type"),
                  leaveTypeWidget(attendanceController).paddingOnly(bottom: 20),
                  _buildText("Leave Reason"),
                  TextFormField(
                    minLines: 5,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    controller: attendanceController.descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Reason for Leave",
                      errorStyle:
                          const TextStyle(height: 0, color: AppColors.redColor),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF969A9D),
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: AppColors.redColor, width: 1),
                      ),
                    ),
                  ).paddingOnly(bottom: 20),
                  SMSButtonWidget(
                    onPress: () async {

                      Map<String, dynamic> mapData1={};
                      Map<String, dynamic> mapData2={};

                      if(attendanceController.editFlag!=1){

                        String startDate;
                        String? endDate;
                        if(double.parse(attendanceController.noOfLeaves.text).toInt()>1){

                          startDate = attendanceController.startDateController.text;
                          endDate = attendanceController.endDateController.text;

                        }else{
                          startDate = attendanceController.leaveDateController.text;
                        }


                        mapData1 = {
                          "student_id": LocalStorage.getValue("studentId"),
                          "start_date": startDate,
                          "end_date": endDate??"",
                          "description": attendanceController.descriptionController.text,
                          "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),
                        };
                        LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate("",1,mapData1);
                        if (leaveCreateData != null && leaveCreateData.code == 200) {//
                          // print("Leave Create Response : ${leaveCreateData.code}");
                          attendanceController.getLeaveListData();
                        } else {
                          print("Leave Create Response : fail");
                        }
                      }else{

                        String startDate;
                        String? endDate;
                        if(double.parse(attendanceController.noOfLeaves.text).toInt()>1){

                          startDate = attendanceController.startDateController.text;
                          endDate = attendanceController.endDateController.text;

                        }else{
                          startDate = attendanceController.leaveDateController.text;
                        }

                        /*DateTime tempStartDate = DateFormat("dd/mm/yyyy").parse(attendanceController.startDateController.text);
                        String temp = double.parse(attendanceController.noOfLeaves.text).toInt()>1? attendanceController.endDateController.text:"";
                        String? endDate;
                        if(temp.isNotEmpty){
                          DateTime tempEndDate = DateFormat("dd/mm/yyyy").parse(temp);
                          endDate = DateFormat('yyyy-mm-dd').format(tempEndDate);
                        }
                        String startDate = DateFormat('yyyy-mm-dd').format(tempStartDate);*/

                        print("student_id : ${LocalStorage.getValue("studentId")}");
                        print("leave_request_id : ${attendanceController.leaveRequestId}");
                        print("start_date : $startDate");
                        print("end_date : $endDate");
                        print("description : ${attendanceController.descriptionController.text}");
                        print("half_day_leave : ${attendanceController.selectedLeaveTypeValue.toString()}");


                        mapData2 = {
                          "student_id": LocalStorage.getValue("studentId"),
                          "leave_request_id": attendanceController.leaveRequestId,
                          "start_date": startDate,
                          "end_date": endDate ?? "",
                          "description": attendanceController.descriptionController.text,
                          "half_day_leave": attendanceController.selectedLeaveTypeValue.toString(),//
                        };

                        LeaveCreateResponceModel? leaveCreateData = await attendanceController.leaveRequestCreate("",2,mapData2);
                        if (leaveCreateData != null && leaveCreateData.code == 200) {
                          attendanceController.getLeaveListData();
                        } else {
                          print("Leave Edit Response : fail");
                        }
                      }
                    },
                    text: "SUBMIT LEAVE",
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    borderRadius: 5,
                    primaryColor: Colors.grey,
                  ).paddingOnly(bottom: 20)
                ],
              ).paddingSymmetric(vertical: 10, horizontal: 10),
            ),
          );
        }));
  }

  Widget _buildText(String text) {
    return Text(text,
            style: AppStyles.NunitoRegular.copyWith(
                fontSize: 14, color: AppColors.darkPinkColor))
        .paddingOnly(bottom: 10);
  }

  Widget leaveTypeWidget(AttendanceDetailsController attendanceController) {
    return Column(children: <Widget>[
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: attendanceController.selectedLeaveType,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            onChanged: (data) {
              attendanceController.updateSelectedLeaveType(double.parse(attendanceController.noOfLeaves.text).toInt()>1?attendanceController.selectedLeaveList1:attendanceController.selectedLeaveList2,data!);
            },
            items: double.parse(attendanceController.noOfLeaves.text).toInt()>1?attendanceController.selectedLeaveList1
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value),
                ),
              );
            }).toList():attendanceController.selectedLeaveList2
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
