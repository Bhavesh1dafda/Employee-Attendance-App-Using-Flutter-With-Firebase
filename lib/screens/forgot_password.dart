import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final emailController =TextEditingController();
    final auth = FirebaseAuth.instance ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration:
                const InputDecoration(hintText: 'Enter Your Email'),
              ),
              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () {

                    auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                      emailController.clear();
                      return Get.snackbar('Succes', 'Check Your Email');

                    }).onError((error, stackTrace){

                      return Get.snackbar('Error', 'Enter Yor Resister Email');
                    });


                },
                child: const Text('Resend Your Password'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

