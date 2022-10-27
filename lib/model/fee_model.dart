
import 'dart:convert';

FeeModel feeModelFromJson(String str) => FeeModel.fromJson(json.decode(str));

String feeModelToJson(FeeModel data) => json.encode(data.toJson());

class FeeModel {
  FeeModel({
    required this.status,
    required this.code,
    this.feeData,
  });

  String status;
  int code;
  FeeData? feeData;

  factory FeeModel.fromJson(Map<String, dynamic> json) => FeeModel(
    status: json["status"],
    code: json["code"],
    feeData: FeeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": feeData!.toJson(),
  };
}

class FeeData {
  FeeData({
    this.total,
    this.discount,
    this.paid,
    this.pending,
    this.percentage,
    this.detail,
  });

  String? total;
  String? discount;
  String? paid;
  String? pending;
  String? percentage;
  List<Detail>? detail;

  factory FeeData.fromJson(Map<String, dynamic> json) => FeeData(
    total: json["total"],
    discount: json["discount"],
    paid: json["paid"],
    pending: json["pending"],
    percentage: json["percentage"],
    detail: json["detail"] == null ? [] :List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "discount": discount,
    "paid": paid,
    "pending": pending,
    "percentage": percentage,
    "detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.id,
    this.name,
    this.fees,
    this.total,
    this.discount,
    this.paid,
    this.pending,
  });

  int? id;
  String? name;
  List<Fee>? fees;
  int? total;
  int? discount;
  int? paid;
  int? pending;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    name: json["name"],
    fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
    total: json["total"],
    discount: json["discount"],
    paid: json["paid"],
    pending: json["pending"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fees": List<dynamic>.from(fees!.map((x) => x.toJson())),
    "total": total,
    "discount": discount,
    "paid": paid,
    "pending": pending,
  };
}

class Fee {
  Fee({
    this.id,
    this.name,
    this.subFee,
    this.total,
    this.discount,
    this.paid,
    this.pending,
    this.amount,
  });

  dynamic id;
  String? name;
  List<SubFee>? subFee;
  dynamic total;
  int? discount;
  int? paid;
  int? pending;
  int? amount;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    id: json["id"],
    name: json["name"],
    subFee: json["sub_fee"] == null ? []: List<SubFee>.from(json["sub_fee"].map((x) => SubFee.fromJson(x))),
    total: json["total"],
    discount: json["discount"],
    paid: json["paid"],
    pending: json["pending"],
    amount:  json["amount"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sub_fee": subFee == null ? [] : List<dynamic>.from(subFee!.map((x) => x.toJson())),
    "total": total,
    "discount": discount,
    "paid": paid,
    "pending": pending,
    "amount": amount??0,
  };
}

class SubFee {
  SubFee({
    this.id,
    this.name,
    this.total,
    this.discount,
    this.paid,
    this.pending,
  });

  int? id;
  String? name;
  String? total;
  int? discount;
  int? paid;
  int? pending;

  factory SubFee.fromJson(Map<String, dynamic> json) => SubFee(
    id: json["id"],
    name: json["name"],
    total: json["total"],
    discount: json["discount"],
    paid: json["paid"],
    pending: json["pending"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total": total,
    "discount": discount,
    "paid": paid,
    "pending": pending,
  };
}
