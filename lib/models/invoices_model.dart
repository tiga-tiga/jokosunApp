// To parse this JSON data, do
//
//     final invoices = invoicesFromJson(jsonString);

import 'dart:convert';

Invoices invoicesFromJson(String str) => Invoices.fromJson(json.decode(str));

String invoicesToJson(Invoices data) => json.encode(data.toJson());

class Invoices {
  Invoices({
    this.invoices,
  });

  List<Invoice> invoices;

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
    invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
  };
}

class Invoice {
  Invoice({
    this.id,
    this.user,
    this.status,
    this.file,
    this.createdAt,
  });

  int id;
  User user;
  String status;
  dynamic file;
  DateTime createdAt;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    user: User.fromJson(json["user"]),
    status: json["status"],
    file: json["file"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "status": status,
    "file": file,
    "created_at": createdAt.toIso8601String(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoUrl,
    this.role,
    this.company,
  });

  int id;
  String name;
  String email;
  String phone;
  String profilePhotoUrl;
  Role role;
  Company company;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profilePhotoUrl: json["profile_photo_url"],
    role: Role.fromJson(json["role"]),
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_photo_url": profilePhotoUrl,
    "role": role.toJson(),
    "company": company.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.ninea,
    this.balance,
    this.bonus,
  });

  int id;
  String name;
  String phone;
  String email;
  String address;
  String ninea;
  int balance;
  int bonus;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    ninea: json["ninea"],
    balance: json["balance"],
    bonus: json["bonus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
    "ninea": ninea,
    "balance": balance,
    "bonus": bonus,
  };
}

class Role {
  Role({
    this.id,
    this.label,
  });

  int id;
  String label;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
  };
}
