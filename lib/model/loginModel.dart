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