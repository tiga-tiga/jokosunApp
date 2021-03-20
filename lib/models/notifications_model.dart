// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    this.notifications,
  });

  List<AppNotification> notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    notifications: List<AppNotification>.from(json["notifications"].map((x) => AppNotification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class AppNotification {
  AppNotification({
    this.id,
    this.message,
    this.createdAt,
    this.readAt,
  });

  String id;
  String message;
  String createdAt;
  String readAt;

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json["id"],
    message: json["message"],
    createdAt: json["created_at"],
    readAt: json["read_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "created_at": createdAt,
    "read_at": readAt,
  };
}
