import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/login.dart';
import 'package:task/screen/user-settings.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Drawer Başlık"),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent
            ),),
          ListTile(
            title: Text("Profilim"),
            onTap: () {
              goToProfile();
            },


          ),
          ListTile(
            title: Text("Çıkış Yap"),
            onTap: () {
              handleClick();
            },
          )
        ],
      ),
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


