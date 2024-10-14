import 'package:flutter/material.dart';
import 'package:task/widgets/textbox.dart';

class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _userNameValue = "";
  String _passwordValue = "";

  void _onTextChanged(String newValue) {
    setState(() {
      _userNameValue = newValue;
      print("user "+_userNameValue);
    });
  }

  void _onPasswordChanged(String newValue) {
    setState(() {
      _passwordValue = newValue;
      print("pass "+_passwordValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 25, color: Colors.blue.shade900, fontWeight: FontWeight.bold),),
               CustomTextFormField(label: 'Username', onChanged: _onTextChanged),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(label: 'Password', onChanged: _onPasswordChanged),
            ],
          ),
        ),
      ),
    );
  }
}
