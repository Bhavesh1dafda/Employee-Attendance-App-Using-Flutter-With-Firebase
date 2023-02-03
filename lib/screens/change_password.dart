import 'package:emloyee_attendance_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangPass extends StatefulWidget {
  const ChangPass({Key? key}) : super(key: key);

  @override
  State<ChangPass> createState() => _changPassState();
}

class _changPassState extends State<ChangPass> {
  final _formkey = GlobalKey<FormState>();
  var newPassword = '';
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  channgPassword() async {
    try {
      await currentUser?.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Get.to(LoginPage());
      Get.snackbar("Succes", "Your Password Has Been Changed... Log In Again");
    } catch (error) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Entere New Password";
                    }
                    return null;
                  },

                  controller: newPasswordController,
                  decoration:
                       InputDecoration(hintText: 'Enter New Password',
                        border: myinputborder(), //normal border
                        enabledBorder: myinputborder(), //enabled border
                        focusedBorder: myfocusborder(),
                      ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_formkey.currentState!.validate()){
                    setState((){
                      newPassword = newPasswordController.text;
                      channgPassword();
                    });

                  }

                },
                child: const Text('Change Password'),
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
