import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/userModel.dart';
import 'package:task/screen/user-settings.dart';

class EditUser extends StatefulWidget {
  final String label;
  final String pKey;
  final UserResponseModel data;

  const EditUser({
    super.key,
    required this.label,
    required this.data,
    required this.pKey
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _controller;
  final Dio _dio = Dio();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
   _controller = TextEditingController(text: widget.data.toJson()[widget.pKey]);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.label),
      actions: [
        TextButton(
          child: const Text('Bitti', style: TextStyle(color: Colors.blue, fontSize: 16),),
          onPressed: () {

            widget.data.setValue(widget.pKey, _controller.text);
            updateUser();

          },
        ),
      ],
    ),

body: isLoading ? Center(child: CircularProgressIndicator()) : Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    controller: _controller,
          decoration: InputDecoration(
          labelText: widget.label,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12, width: 2)
            ),
      ),
      ),
),
    );
  }

  updateUser() async {
    this.isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =  await prefs.get("token");
    var id =  await prefs.get("id");
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = "Bearer ${token}";
    var response = await _dio.put("http://157.173.101.211:8080/user/${widget.data.toJson()['id']}",
        data: widget.data.toJson()
    );
    this.isLoading = false;
    if(response.statusCode == 200) {
      print("success");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
          const UserSettings(),
        ),
      );
      // fetchProfile();
    }

  }

}
