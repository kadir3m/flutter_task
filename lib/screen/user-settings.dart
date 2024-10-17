import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/drawer.dart';
import 'package:task/screen/edit-user.dart';
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
  File? _image;
  String? _base64Image;
  Uint8List? decodedImage;

  final   userResponseModel = new UserResponseModel(
    name: "",
    surname: "",
    username: "",
    email: "",
    id: "",
    hashedPassword: "",
    universityEmail: "",
    image: ""
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchProfile());
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(

        appBar: AppBar(
          title: Text("Profilim"),
        ),
      drawer: CustomDrawer(),
        body: !isReady ? Center(child: CircularProgressIndicator()) :  Padding(
          padding: const EdgeInsets.all(8.0),
          child: isReady ? FormView() : Container()
        ),
      ),
    );
  }

  Widget FormView() {
    return Padding(
      padding: EdgeInsets.all(10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:  showFoto(),
            child: decodedImage == null ? Icon(Icons.person, size: 50, color: Colors.white,) : null,

          ),
          TextButton(onPressed: _pickImage, child: Text("Resmi düzenle",style: TextStyle(color: Colors.blue),)),

        ],
      ),
    ),


  SizedBox(height: 14,),
  RowFlex("Adı", userResponseModel.name.toString(), 'name', userResponseModel),
  RowFlex("Soyadı", userResponseModel.surname.toString(), 'surname', userResponseModel),
  RowFlex("Kullanıcı adı", userResponseModel.username.toString(), 'username', userResponseModel),
  RowFlex("E-mail", userResponseModel.email.toString(), 'email', userResponseModel),
  ],
  ),

  );
}
  onTapRow() {
    print("tapp");
  }
Widget RowFlex(String title, String value, String key, data) {
    return  InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditUser(label: title, data: data, pKey: key),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child:  Container(
                child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16))),

          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                    value,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white, width: 0.3))
                ),
              )
          )
        ],
      ),
    );
}
showFoto() {
   if(_image != null) {
      return FileImage(_image!);
    } else   if(decodedImage != null) {
     return MemoryImage(decodedImage!);
   }
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
      userResponseModel.id = user.id;
      userResponseModel.hashedPassword = user.hashedPassword;
      userResponseModel.image = user.image;

    });
    print(user);
    _base64Image = userResponseModel.image;
     Uint8List? _decodedBytes = _base64Image != null ? base64Decode(_base64Image!) : null;
    setState(() {
      decodedImage = _decodedBytes;
    });
     isReady = true;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    _convertImageToBase64(_image!);
  }
  Future<void> _convertImageToBase64(File imageFile) async {
    Dio dio = new Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =  await prefs.get("token");
    var id =  await prefs.get("id");
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer ${token}";

    try {
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
        userResponseModel.image = _base64Image;
      });
      var response = await dio.put("http://157.173.101.211:8080/user/${id}",
          data: userResponseModel.toJson()
      );
      if(response.statusCode == 200) {
        print("success");
        // fetchProfile();
      }
    } catch (e) {
      print('Error converting image to Base64: $e');
    }
  }



}
