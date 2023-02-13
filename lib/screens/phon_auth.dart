import 'package:emloyee_attendance_app/screens/round.dart';
import 'package:emloyee_attendance_app/screens/verify_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false ;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),

            TextFormField(
              controller: phoneNumberController,

              decoration: InputDecoration(
                  hintText: '+91 *********'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Login',loading: loading, onTap: (){

              setState(() {
                loading = true ;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false ;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false ;
                    });
                    Get.snackbar("erroe 1", "samothing rong");
                  },
                  codeSent: (String verificationId , int? token){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCodeScreen(verificationId:verificationId ,)));
                    setState(() {
                      loading = false ;
                    });
                  },
                  codeAutoRetrievalTimeout: (e){
                    Get.snackbar("Success", "Check Your Inbox!");
                    setState(() {
                      loading = false ;
                    });
                  });
            })

          ],
        ),
      ),
    );
  }
}