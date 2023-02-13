import 'package:emloyee_attendance_app/route/app_pages.dart';
import 'package:emloyee_attendance_app/screens/homepage.dart';
import 'package:emloyee_attendance_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  var email = '';
  getData() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var email=prefs.getString("email");
    print(email);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
      BouncingScrollWrapper.builder(context, child!),
      maxWidth: 1200,
      minWidth: 450,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(450, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      ],),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      title: 'Atendance List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: email== null?const LoginPage():const Homepage(),);

  }
}


