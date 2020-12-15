

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  bool success;
  String message;
  int statusCode;
  Map<String, dynamic> data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    success: json["success"],
    message: json["message"],
    statusCode: json["status_code"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status_code": statusCode,
    "data": data,
  };
}

