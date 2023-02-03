import 'package:get/get.dart';


import '../screens/attendance/view_all_attendance.dart';
import '../screens/dashboard.dart';
import '../screens/edit_profile.dart';
import '../screens/forgot_password.dart';
import '../screens/homepage.dart';
import '../screens/login_page.dart';
import 'app_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoute.LoginPage, page: () =>  LoginPage()),
    GetPage(name: AppRoute.DashBoardPage, page: () => DashBoardPage()),
    GetPage(name: AppRoute.ForgotPassword, page: () => const ForgotPassword()),
    GetPage(name: AppRoute.ViewAllAttendance, page: () =>  ViewAllAttendance()),
    GetPage(name: AppRoute.EditProfile, page: () => const EditProfile()),
    GetPage(name: AppRoute.Homepage, page: () => const Homepage()),

  ];
}
