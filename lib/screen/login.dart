
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/loginModel.dart';
import 'package:task/screen/home.dart';
import 'package:task/screen/register.dart';
import 'package:task/utils/text_utils.dart';
import 'package:task/widgets/textbox.dart';

class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _userNameValue = "akadir@test.com";
  String _passwordValue = "1q2w3e4r5t**";

  final Dio _dio = Dio();

  void _onTextChanged(String newValue) {
    setState(() {
      _userNameValue = newValue;
    });
  }

  void _onPasswordChanged(String newValue) {
    setState(() {
      _passwordValue = newValue;
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
                    CustomTextFormField(label: 'Kullanıcı adı veya mail', onChanged: _onTextChanged, initialValue: "akadir@test.com",),
                    SizedBox(height: 10,),
                    CustomTextFormField(label: 'Şifre', onChanged: _onPasswordChanged, obscure: true,initialValue: "1q2w3e4r5t**",),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.white,

                        ),
                        SizedBox(width: 10),
                        Expanded(child: TextUtils(text: "Beni Hatırla", size: 12, weight: true)),
                        Spacer(),

                        Container()
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () async {
                            _login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Change the background color
                            foregroundColor: Colors.white, // Change the text (foreground) color
                          ),
                          child: const Text("Giriş", style: TextStyle(color: Colors.white),)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Hesabınız yok mu?"),
                        TextButton(onPressed: () => {
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                        builder: (context) =>
                        const RegisterScreen(),
                        ),
                        ),
                        }, child: Text("Kayıt Ol"), style: TextButton.styleFrom(
                          foregroundColor: Colors.white
                        )),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    final String username = _userNameValue;
    final String password = _passwordValue;

    try {
      final response =  await _dio.post(
        'http://157.173.101.211:8080/auth/login', // Replace with your API URL
        data: {
          'username': username,
          'password': password,
        },
      );
      debugPrint(username);

      if (response.statusCode == 200) {
        // Successful login
        var body =  LoginResponseModel.fromJson(response.data);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", body.token.toString());
        await prefs.setString("id", body.id.toString());
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Login successful!')),
        // );
        MaterialPageRoute pageRoute = MaterialPageRoute(builder: (_)  {
          return const HomeScreen();
        });

        Navigator.pushReplacement(context, pageRoute);
      } else {
        // Handle login error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

}



