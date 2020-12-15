// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'company_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
    this.company,
    this.role,
  });

  int id;
  String name;
  String email;
  String phone;
  String profilePhotoUrl;
  Company company;
  Role role;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        profilePhotoUrl: json["profile_photo_url"],
        company: Company.fromJson(json["company"]),
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "profile_photo_url": profilePhotoUrl,
        "company": company.toJson(),
      };
}

class Role {
  int id;
  String label;

  Role({
    this.id,
    this.label
  });

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(
        id: json["id"],
        label: json["label"],
      );
}


