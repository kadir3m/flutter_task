import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/userModel.dart';
import 'package:task/screen/drawer.dart';
import 'package:task/screen/login.dart';
import 'package:task/screen/user-settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),

      ),
      drawer: CustomDrawer()
    );
  }
  void handleClick() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
            const Login(),
          ),
        );
  }

void goToProfile() {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) =>
      const UserSettings(),
    ),
  );
}
}
