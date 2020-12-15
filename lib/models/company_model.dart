// To parse this JSON data, do
//
//     final companies = companiesFromJson(jsonString);

import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
  Companies({
    this.companies,
  });

  List<Company> companies;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
    companies: List<Company>.from(json["companies"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
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
    this.bonus,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String phone;
  String email;
  String address;
  String ninea;
  int bonus;
  DateTime createdAt;
  DateTime updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    ninea: json["ninea"],
    bonus: json["bonus"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
    "ninea": ninea,
    "bonus": bonus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
