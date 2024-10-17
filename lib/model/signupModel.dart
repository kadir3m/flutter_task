class SignupModel {
  String? username;
  String? email;
  String? name;
  String? surname;
  String? universityEmail;
  University? university;
  Country? country;
  Discipline? discipline;
  Country? subject;
  Faculty? faculty;
  bool? status;
  Role? role;
  String? password;

  SignupModel(
      {this.username,
        this.email,
        this.name,
        this.surname,
        this.universityEmail,
        this.university,
        this.country,
        this.discipline,
        this.subject,
        this.faculty,
        this.status,
        this.role,
        this.password});

  SignupModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    universityEmail = json['universityEmail'];
    university = json['university'] != null
        ? new University.fromJson(json['university'])
        : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    discipline = json['discipline'] != null
        ? new Discipline.fromJson(json['discipline'])
        : null;
    subject =
    json['subject'] != null ? new Country.fromJson(json['subject']) : null;
    faculty =
    json['faculty'] != null ? new Faculty.fromJson(json['faculty']) : null;
    status = json['status'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['universityEmail'] = this.universityEmail;
    if (this.university != null) {
      data['university'] = this.university!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.discipline != null) {
      data['discipline'] = this.discipline!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.faculty != null) {
      data['faculty'] = this.faculty!.toJson();
    }
    data['status'] = this.status;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['password'] = this.password;
    return data;
  }
}

class University {
  String? id;
  String? name;
  String? countryId;

  University({this.id, this.name, this.countryId});

  University.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['countryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['countryId'] = this.countryId;
    return data;
  }
}

class Country {
  String? id;
  String? name;
  String? sign;

  Country({this.id, this.name, this.sign});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sign'] = this.sign;
    return data;
  }
}

class Discipline {
  String? id;
  String? name;
  String? subjectSignId;

  Discipline({this.id, this.name, this.subjectSignId});

  Discipline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subjectSignId = json['subjectSignId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['subjectSignId'] = this.subjectSignId;
    return data;
  }
}

class Faculty {
  String? id;
  String? name;

  Faculty({this.id, this.name});

  Faculty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Role {
  String? id;
  String? name;
  String? screenName;

  Role({this.id, this.name, this.screenName});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    screenName = json['screenName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['screenName'] = this.screenName;
    return data;
  }
}
