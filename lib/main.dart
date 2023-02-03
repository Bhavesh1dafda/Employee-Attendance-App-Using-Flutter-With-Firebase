
import 'package:emloyee_attendance_app/route/app_pages.dart';
import 'package:emloyee_attendance_app/screens/dashboard.dart';
import 'package:emloyee_attendance_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      title: 'Atendance List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;
  @override
  void initState(){
    _getCurrentUser();
super.initState();
  }

  Future<void> _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try{
      if(sharedPreferences.getString('employeeId')!= null){
       setState((){
         userAvailable= true;
       });
      }

    }catch(e){
      setState((){
        userAvailable= false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return userAvailable ? DashBoardPage():LoginPage();
  }
}

