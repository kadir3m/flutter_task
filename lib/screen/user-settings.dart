import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/drawer.dart';
import 'package:task/widgets/textbox.dart';

import '../model/userModel.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final Dio _dio = Dio();
  var isReady = false;
  final userResponseModel = new UserResponseModel(
    name: "",
    surname: "",
    username: "",
    email: ""
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchProfile());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilim"),
      ),
drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isReady ? FormView() : Container()
      ),
    );
  }

  Widget FormView() {
    return Form(
  child: ListView(
  children: [
  CustomTextFormField(label: "Adı", onChanged: (context) {
  }, initialValue: userResponseModel.name.toString(), color: Colors.black,),
  SizedBox(height: 10,),
  CustomTextFormField(label: "Soyadı", onChanged: (context) {
  }, initialValue: userResponseModel.surname.toString(), color: Colors.black,),
SizedBox(height: 10),
    CustomTextFormField(label: "Email", onChanged: (context) {
    }, initialValue: userResponseModel.email.toString(), color: Colors.black,),

  ],
  ),

  );
}
  void fetchProfile() async{
     isReady = false;
    Dio dio = new Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =  await prefs.get("token");
    var id =  await prefs.get("id");
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer ${token}";
    var response = await dio.get("http://157.173.101.211:8080/user/${id}");

    var user = UserResponseModel.fromJson(response.data);

    setState(() {
      userResponseModel.name = user.name;
      userResponseModel.surname = user.surname;
      userResponseModel.email = user.email;
      userResponseModel.username = user.username;
    });
    print(user);
    isReady = true;
  }
}
