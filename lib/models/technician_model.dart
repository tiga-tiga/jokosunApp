// To parse this JSON data, do
//
//     final technicians = techniciansFromJson(jsonString);

import 'dart:convert';

Technicians techniciansFromJson(String str) => Technicians.fromJson(json.decode(str));

String techniciansToJson(Technicians data) => json.encode(data.toJson());

class Technicians {
  Technicians({
    this.technicians,
  });

  List<Technician> technicians;

  factory Technicians.fromJson(Map<String, dynamic> json) => Technicians(
    technicians: List<Technician>.from(json["technicians"].map((x) => Technician.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "technicians": List<dynamic>.from(technicians.map((x) => x.toJson())),
  };
}

class Technician {
  Technician({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
  });

  int id;
  String name;
  String email;
  String phone;
  String profilePhotoUrl;

  factory Technician.fromJson(Map<String, dynamic> json) => Technician(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_photo_url": profilePhotoUrl,
  };
}
