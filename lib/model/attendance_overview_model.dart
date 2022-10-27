import 'dart:convert';

AttendanceOverviewModel attendanceOverviewModelFromJson(String str) => AttendanceOverviewModel.fromJson(json.decode(str));

String attendanceOverviewModelToJson(AttendanceOverviewModel data) => json.encode(data.toJson());

class AttendanceOverviewModel {
  AttendanceOverviewModel({
    required this.status,
    required this.code,
    this.attendanceOverviewData,
    this.error,
  });

  String status;
  int code;
  AttendanceOverViewData? attendanceOverviewData;
  String? error;

  factory AttendanceOverviewModel.fromJson(Map<String, dynamic> json) => AttendanceOverviewModel(
    status: json["status"],
    code: json["code"],
      attendanceOverviewData: AttendanceOverViewData.fromJson(json["data"]),
      error: json.containsKey("error") ? json["error"] : "");


  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": attendanceOverviewData!.toJson(),
  };
}

class AttendanceOverViewData {
  AttendanceOverViewData({
    this.todayAttendance,
    this.noOfWorkingDays,
    this.present,
    this.absent,
    this.absentDetail,
    this.percentage,
  });

  dynamic todayAttendance;
  int? noOfWorkingDays;
  int? present;
  int? absent;
  AbsentDetail? absentDetail;
  String? percentage;

  factory AttendanceOverViewData.fromJson(Map<String, dynamic> json) => AttendanceOverViewData(
    todayAttendance: json["today_attendance"],
    noOfWorkingDays: json["no_of_working_days"],
    present: json["present"],
    absent: json["absent"],
    absentDetail: AbsentDetail.fromJson(json["absent_detail"]),
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "today_attendance": todayAttendance,
    "no_of_working_days": noOfWorkingDays,
    "present": present,
    "absent": absent,
    "absent_detail": absentDetail!.toJson(),
    "percentage": percentage,
  };
}

class AbsentDetail {
  AbsentDetail({
    this.fullDay,
    this.haftDay,
    this.morningHaftDay,
    this.eveningHaftDay,
  });

  int? fullDay;
  int? haftDay;
  int? morningHaftDay;
  int? eveningHaftDay;

  factory AbsentDetail.fromJson(Map<String, dynamic> json) => AbsentDetail(
    fullDay: json["full_day"],
    haftDay: json["haft_day"],
    morningHaftDay: json["morning_haft_day"],
    eveningHaftDay: json["evening_haft_day"],
  );

  Map<String, dynamic> toJson() => {
    "full_day": fullDay,
    "haft_day": haftDay,
    "morning_haft_day": morningHaftDay,
    "evening_haft_day": eveningHaftDay,
  };
}
