class UserResponseModel {
  String? name;
  String? surname;
  String? username;
  String? email;

  UserResponseModel({this.name, this.surname, this.username, this.email});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}