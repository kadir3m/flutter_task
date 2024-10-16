class UserResponseModel {
  String? id;
  String? name;
  String? surname;
  String? username;
  String? email;
  String? image;
  String? universityEmail;
  String? hashedPassword;

  UserResponseModel(
      {this.id,
        this.name,
        this.surname,
        this.username,
        this.email,
        this.image,
        this.universityEmail,
        this.hashedPassword});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    email = json['email'];
    image = json['image'];
    universityEmail = json['universityEmail'];
    hashedPassword = json['hashedPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['image'] = this.image;
    data['universityEmail'] = this.universityEmail;
    data['hashedPassword'] = this.hashedPassword;
    return data;
  }
}
