import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emloyee_attendance_app/screens/phon_auth.dart';
import 'package:emloyee_attendance_app/screens/round.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/app_route.dart';
import '../service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: 'dbhavesh101@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '78787878');
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/recruitment.png',
                height: 150,
              ),
              const SizedBox(height: 80),
              SizedBox(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: myinputborder(), //normal border
                    enabledBorder: myinputborder(), //enabled border
                    focusedBorder: myfocusborder(),

                    hintText: 'Email/Username/ID',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: myinputborder(), //normal border
                    enabledBorder: myinputborder(), //enabled border
                    focusedBorder: myfocusborder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.ForgotPassword);
                      },
                      child: Text('Forgot Password'))),
              const SizedBox(
                height: 30.0,
              ),
              RoundButton(
                onTap: () async {
                  final message = await AuthService().login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (message!.contains('Success')) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("email", _emailController.text);
                    Get.toNamed(AppRoute.Homepage, arguments: [
                      {
                        "1": _emailController.text,
                      },
                    ]);
                  } else {
                    Get.snackbar('Error', 'Enter Valid Email OR Password');
                  }
                },
                title: 'Login',
              ),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                onTap: () {
                  Get.to(LoginWithPhoneNumber());
                },
                title: 'Log In With Phone ?',
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.purple.withOpacity(0.50),
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.purple,
          width: 3,
        ));
  }
}
