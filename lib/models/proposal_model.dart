// To parse this JSON data, do
//
//     final proposal = proposalFromJson(jsonString);

import 'dart:convert';

import 'package:jokosun/models/user_model.dart';

import 'company_model.dart';
import 'kit_model.dart';

Proposal proposalFromJson(String str) => Proposal.fromJson(json.decode(str));

String proposalToJson(Proposal data) => json.encode(data.toJson());

class Proposal {
  Proposal({
    this.proposal,
  });

  List<ProposalElement> proposal;

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
    proposal: json["proposals"]!= null ? List<ProposalElement>.from(json["proposals"].map((x) => ProposalElement.fromJson(x))): [],
  );

  Map<String, dynamic> toJson() => {
    "proposal": List<dynamic>.from(proposal.map((x) => x.toJson())),
  };
}

class ProposalElement {
  ProposalElement({
    this.id,
    this.fullName,
    this.phone,
    this.address,
    this.dateWish,
    this.user,
    this.kit,
  });

  int id;
  String fullName;
  String phone;
  String address;
  DateTime dateWish;
  UserModel user;
  Kit kit;

  factory ProposalElement.fromJson(Map<String, dynamic> json) => ProposalElement(
    id: json["id"],
    fullName: json["fullName"],
    phone: json["phone"],
    address: json["address"],
    dateWish: DateTime.parse(json["date_wish"]),
    user: UserModel.fromJson(json["user"]),
    kit: Kit.fromJson(json["kit"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "address": address,
    "date_wish": dateWish.toIso8601String(),
    "user": user.toJson(),
    "kit": kit.toJson(),
  };
}


