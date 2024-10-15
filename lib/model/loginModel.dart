class LoginService {
  String? username;
  String? password;

  LoginService({this.username, this.password});

  LoginService.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

Future _login(username, password) async {

}

class LoginResponseModel {
  String? token;
  String? id;

  LoginResponseModel({this.token, this.id});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    return data;
  }
}