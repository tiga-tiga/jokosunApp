// To parse this JSON data, do
//
//     final applications = applicationsFromJson(jsonString);

import 'dart:convert';

import 'package:jokosun/models/technician_model.dart';

import 'company_model.dart';
import 'offers_model.dart';

Applications applicationsFromJson(String str) => Applications.fromJson(json.decode(str));

String applicationsToJson(Applications data) => json.encode(data.toJson());

class Applications {
  Applications({
    this.applications,
  });

  List<Application> applications;

  factory Applications.fromJson(Map<String, dynamic> json) => Applications(
    applications: List<Application>.from(json["applications"].map((x) => Application.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "applications": List<dynamic>.from(applications.map((x) => x.toJson())),
  };
}

class Application {
  Application({
    this.id,
    this.company,
    this.technicians,
    this.offer
  });

  int id;
  Company company;
  Offer offer;
  List<Technician> technicians;

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    id: json["id"],
    company: Company.fromJson(json["company"]),
    offer: json["offer"]  != null ?Offer.fromJson(json["offer"]) : [],
    technicians: List<Technician>.from(json["technicians"].map((x) => Technician.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company.toJson(),
    "offer": offer.toJson(),
    "technicians": List<dynamic>.from(technicians.map((x) => x.toJson())),
  };
}

