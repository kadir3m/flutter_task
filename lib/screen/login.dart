import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task/utils/text_utils.dart';
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
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg2.jpeg'), fit: BoxFit.fill )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.1)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Padding(
                  padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(
                      child: TextUtils(text: "Login", size: 30, color: Colors.white, weight: true),
                    ),
                    Spacer(),
                    CustomTextFormField(label: 'Username', onChanged: _onTextChanged),
                    SizedBox(height: 10,),
                    CustomTextFormField(label: 'Password', onChanged: _onPasswordChanged, obscure: true,),
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.white,

                        ),
                        SizedBox(width: 10),
                        Expanded(child: TextUtils(text: "Remember Me, Forget Password", size: 12, weight: true)),
                        Spacer(),

                        Container()
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () async {
                          },
                          child: const Text("Giriş")),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
