import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task/model/signupModel.dart';
import 'package:task/screen/login.dart';

import '../utils/text_utils.dart';
import '../widgets/textbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Dio _dio = Dio();
  var isLoading = false;

  SignupModel user = new SignupModel(
      username: "",
      email: "",
      name: "",
      surname: "",
      universityEmail: "",
      university: null,
      country: null,
      discipline: null,
      subject: null,
      faculty: null,
      status: true,
      role: null,
      password: ""
  );
  late TextEditingController name;
  late TextEditingController surname;
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: user.name);
    surname = TextEditingController(text: user.surname);
    email = TextEditingController(text: user.email);
    username = TextEditingController(text: user.username);
    password = TextEditingController(text: user.password);

    // Update the model whenever the text changes.
    // _onNameChange() {
    //   user.name = name.text;
    // }
    // name.addListener(() {
    //   setState(() {
    //     user.name = name.text;
    //   });
    // });
    // surname.addListener(() {
    //   setState(() {
    //     user.surname = surname.text;
    //   });
    // });
    // email.addListener(() {
    //   setState(() {
    //     user.email = email.text;
    //   });
    // });
    // username.addListener(() {
    //   setState(() {
    //     user.username = username.text;
    //   });
    // });
    // password.addListener(() {
    //   setState(() {
    //     user.password = password.text;
    //   });
    // });
  }

  @override
  void dispose() {
    name.dispose();
    surname.dispose();
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
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
        child: Container(

          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.1)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: TextUtils(text: "Kayıt", size: 30, color: Colors.white, weight: true),
                        ),
                        SizedBox(height: 14,),
                        CustomTextFormField(label: 'Adı', onChanged: (String value) {
                          setState(() {
                            user.name = value;
                          });
                        }, initialValue: '',),
                        SizedBox(height: 10,),
                        CustomTextFormField(label: 'Soyadı', onChanged: (String value) {
                          setState(() {
                            user.surname = value;
                          });
                        }, obscure: false, initialValue: '',),
                        SizedBox(height: 10),
                        CustomTextFormField(label: 'E-mail', onChanged: (String value) {
                          setState(() {
                            user.email = value;
                          });
                        }, initialValue: '',),
                        SizedBox(height: 10,),
                        CustomTextFormField(label: 'Kullanıcı Adı', onChanged: (String value) {
                          setState(() {
                            user.username = value;
                          });
                        }, initialValue: '',),
                        SizedBox(height: 10,),
                        CustomTextFormField(label: 'Şifre', onChanged: (String value) {
                          setState(() {
                            user.password = value;
                          });
                        }, initialValue: '',obscure: true,),
                        SizedBox(height: 10,),
                        SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue, // Change the background color
                                foregroundColor: Colors.white, // Change the text (foreground) color
                              ),
                                onPressed: () async {
                                  _register();
                                },
                                child: const Text("Kayıt Ol", style: TextStyle(color: Colors.white),)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Zaten bir hesabınız var mı?"),
                            TextButton(onPressed: () => {

                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                            builder: (context) =>
                            const Login(),
                            ),
                            ),
                            }, child: Text("Giriş Yap"), style: TextButton.styleFrom(
                                foregroundColor: Colors.white
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  _register() async{
    this.isLoading = true;
    try {
      final response =  await _dio.post(
        'http://157.173.101.211:8080/auth/signup', // Replace with your API URL
        data: user.toJson()
      );
   this.isLoading = false;

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
            const Login(),
          ),
        );
      }
      }catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
