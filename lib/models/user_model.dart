class User {
  User({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.username,
    this.password,
    this.createdAt,
    this.profile,
    this.profession,
    this.company,
    this.active,
    this.blacklisted,
  });

  int id;
  String firstname;
  String lastname;
  String phone;
  String email;
  String username;
  String password;
  int createdAt;
  Profile profile;
  dynamic profession;
  dynamic company;
  bool active;
  bool blacklisted;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    createdAt: json["createdAt"],
    profile: Profile.fromJson(json["profile"]),
    profession: json["profession"],
    company: json["company"],
    active: json["active"],
    blacklisted: json["blacklisted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "email": email,
    "username": username,
    "password": password,
    "createdAt": createdAt,
    "profile": profile.toJson(),
    "profession": profession,
    "company": company,
    "active": active,
    "blacklisted": blacklisted,
  };
}

class Profile {
  Profile({
    this.id,
    this.title,
    this.description,
    this.status,
  });

  int id;
  String title;
  String description;
  int status;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
  };
}
