// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:jokosun/models/installations_model.dart';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    this.unreadNotifications,
    this.bonus,
    this.balance,
    this.finishedInstallations,
    this.nextInstallation,
  });

  UnreadNotifications unreadNotifications;
  int bonus;
  int balance;
  int finishedInstallations;
  Installation nextInstallation;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    unreadNotifications: UnreadNotifications.fromJson(json["unreadNotifications"]),
    bonus: json["bonus"],
    balance: json["balance"],
    finishedInstallations: json["finishedInstallations"],
    nextInstallation: json["nextInstallation"] != null ?  Installation.fromJson(json["nextInstallation"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "unreadNotifications": unreadNotifications.toJson(),
    "bonus": bonus,
    "balance": balance,
    "finishedInstallations": finishedInstallations,
    "nextInstallation": nextInstallation,
  };
}

class UnreadNotifications {
  UnreadNotifications({
    this.count,
    this.notifications,
  });

  int count;
  List<dynamic> notifications;

  factory UnreadNotifications.fromJson(Map<String, dynamic> json) => UnreadNotifications(
    count: json["count"],
    notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "notifications": List<dynamic>.from(notifications.map((x) => x)),
  };
}
