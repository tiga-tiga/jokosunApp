// To parse this JSON data, do
//
//     final offers = offersFromJson(jsonString);

import 'dart:convert';

import 'kit_model.dart';

Offers offersFromJson(String str) => Offers.fromJson(json.decode(str));

String offersToJson(Offers data) => json.encode(data.toJson());

class Offers {
  Offers({
    this.offers,
  });

  List<Offer> offers;

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
    offers: json["offers"] != null ? List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))): [],
  );

  Map<String, dynamic> toJson() => {
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Offer {
  Offer({
    this.id,
    this.proposal,
    this.customerName,
    this.kit,
    this.flatRate,
    this.removalAndTransport,
    this.address,
    this.city,
    this.commissioningDate,
    this.technicians,
    this.applied,
    this.applications,
    this.installationId
  });

  int id;
  dynamic proposal;
  String customerName;
  Kit kit;
  String flatRate;
  String removalAndTransport;
  String address;
  String city;
  String commissioningDate;
  int technicians;
  bool applied;
  int installationId;
  int applications;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    proposal: json["proposal"],
    customerName: json["customer_name"],
    kit: Kit.fromJson(json["kit"]),
    flatRate: json["flat_rate"],
    removalAndTransport: json["removal_and_transport"],
    address: json["address"],
    city: json["city"],
    commissioningDate: json["commissioning_date"],
    technicians: json["technicians"],
    applied: json["applied"],
    installationId: json["installation_id"],
    applications: json["applications"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "proposal": proposal,
    "customer_name": customerName,
    "kit": kit.toJson(),
    "flat_rate": flatRate,
    "removal_and_transport": removalAndTransport,
    "address": address,
    "city": city,
    "commissioning_date": commissioningDate,
    "technicians": technicians,
    "applied": applied,
    "installation_id": installationId,
    "applications": applications,
  };
}


