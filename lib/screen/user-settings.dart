import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;
  String? _base64Image;
  Uint8List? decodedImage;

  final userResponseModel = new UserResponseModel(
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
    CircleAvatar(
      radius: 50,
      backgroundImage:  showFoto(),
      child: decodedImage == null ? Icon(Icons.person, size: 50) : null,

    ),

    IconButton(
      icon: Icon(Icons.camera_alt),
      color: Colors.black,
      onPressed: _pickImage,
      padding: EdgeInsets.all(8),
      iconSize: 30,
      splashRadius: 25,
      tooltip: 'Edit Profile Photo',
    ),
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
