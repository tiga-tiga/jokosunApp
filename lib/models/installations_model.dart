// To parse this JSON data, do
//
//     final installations = installationsFromJson(jsonString);

import 'dart:convert';

Installations installationsFromJson(String str) => Installations.fromJson(json.decode(str));

String installationsToJson(Installations data) => json.encode(data.toJson());

class Installations {
  Installations({
    this.installations,
  });

  List<Installation> installations;

  factory Installations.fromJson(Map<String, dynamic> json) => Installations(
    installations:  List<Installation>.from(json["installations"].map((x) => Installation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "installations": List<dynamic>.from(installations.map((x) => x.toJson())),
  };
}

class Installation {
  Installation({
    this.id,
    this.latitude,
    this.longitude,
    this.startAt,
    this.endAt,
    this.status,
    this.application,
    this.preparation,
    this.invoiceable,
    this.invoice_status,
    this.finished,
  });

  int id;
  dynamic latitude;
  dynamic longitude;
  dynamic startAt;
  dynamic endAt;
  String status;
  bool invoiceable;
  String invoice_status;
  Application application;
  List<dynamic> preparation;
  List<dynamic> finished;

  factory Installation.fromJson(Map<String, dynamic> json) => Installation(
    id: json["id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    status: json["status"],
    invoiceable: json["invoiceable"],
    invoice_status: json["invoice_status"],
    application: Application.fromJson(json["application"]),
    preparation: List<dynamic>.from(json["preparation"].map((x) => x)),
    finished: List<dynamic>.from(json["finished"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "latitude": latitude,
    "longitude": longitude,
    "start_at": startAt,
    "end_at": endAt,
    "status": status,
    "invoiceable": invoiceable,
    "invoice_status": invoice_status,
    "application": application.toJson(),
    "preparation": List<dynamic>.from(preparation.map((x) => x)),
    "finished": List<dynamic>.from(finished.map((x) => x)),
  };
}

class Application {
  Application({
    this.id,
    this.offer,
    this.company,
    this.technicians,
  });

  int id;
  Offer offer;
  Company company;
  List<Technician> technicians;

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    id: json["id"],
    offer: Offer.fromJson(json["offer"]),
    company: Company.fromJson(json["company"]),
    technicians: List<Technician>.from(json["technicians"].map((x) => Technician.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer": offer.toJson(),
    "company": company.toJson(),
    "technicians": List<dynamic>.from(technicians.map((x) => x.toJson())),
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
    "ninea": ninea,
    "bonus": bonus,
  };
}

class Offer {
  Offer({
    this.id,
    this.installationId,
    this.proposal,
    this.customerName,
    this.kit,
    this.flatRate,
    this.removalAndTransport,
    this.city,
    this.address,
    this.commissioningDate,
    this.technicians,
    this.applied,
    this.applications,
  });

  int id;
  int installationId;
  dynamic proposal;
  String customerName;
  Kit kit;
  String flatRate;
  String removalAndTransport;
  String city;
  String address;
  String commissioningDate;
  int technicians;
  bool applied;
  int applications;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    installationId: json["installation_id"],
    proposal: json["proposal"],
    customerName: json["customer_name"],
    kit: Kit.fromJson(json["kit"]),
    flatRate: json["flat_rate"],
    removalAndTransport: json["removal_and_transport"],
    city: json["city"],
    address: json["address"],
    commissioningDate: json["commissioning_date"],
    technicians: json["technicians"],
    applied: json["applied"],
    applications: json["applications"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "installation_id": installationId,
    "proposal": proposal,
    "customer_name": customerName,
    "kit": kit.toJson(),
    "flat_rate": flatRate,
    "removal_and_transport": removalAndTransport,
    "city": city,
    "address": address,
    "commissioning_date": commissioningDate,
    "technicians": technicians,
    "applied": applied,
    "applications": applications,
  };
}

class Kit {
  Kit({
    this.id,
    this.name,
    this.reference,
    this.sheet,
    this.price,
    this.size,
    this.weight,
    this.description,
    this.category,
  });

  int id;
  String name;
  String reference;
  String sheet;
  dynamic price;
  dynamic size;
  dynamic weight;
  String description;
  Category category;

  factory Kit.fromJson(Map<String, dynamic> json) => Kit(
    id: json["id"],
    name: json["name"],
    reference: json["reference"],
    sheet: json["sheet"],
    price: json["price"],
    size: json["size"],
    weight: json["weight"],
    description: json["description"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "reference": reference,
    "sheet": sheet,
    "price": price,
    "size": size,
    "weight": weight,
    "description": description,
    "category": category.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.coefficient,
  });

  int id;
  String name;
  int coefficient;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    coefficient: json["coefficient"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coefficient": coefficient,
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
