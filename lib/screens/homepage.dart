
import 'package:emloyee_attendance_app/screens/attendance/view_all_attendance.dart';
import 'package:emloyee_attendance_app/screens/dashboard.dart';
import 'package:emloyee_attendance_app/screens/edit_profile.dart';
import 'package:flutter/material.dart';

import '../widget/TextView.dart';
import 'attendance/applyForLeave.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  int current_index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  void onTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0xffEDEDED),
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: TabBar(
          isScrollable: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          onTap: (index) {
            setState(() {
              controller.index = index;
            });
          },
          tabs: [

            Tab(

              icon:controller.index == 0
                  ?
              Column(
                children: [
                  Icon(Icons.home_outlined,size: 40,color: Colors.purple,),


                ],
              ):
              Column(
                children: [
                  Icon(Icons.home_outlined,size: 25,color: Colors.purple,),


                ],
              )

            ),
            Tab(
              icon: controller.index == 1
                  ?
              Column(
                children: [
                  Icon(Icons.calendar_month,size: 40,color: Colors.purple,),


                ],
              ):
              Column(
                children: [
                  Icon(Icons.calendar_month_outlined,size: 25,color: Colors.purple,),


                ],
              )

            ),
            Tab(
              icon:controller.index == 2
                  ?  Column(
                children: [
                  Icon(Icons.app_registration_outlined,size: 40,color: Colors.purple,),

                ],
              ):
              Column(
                children: [
                  Icon(Icons.app_registration_outlined,size: 25,color: Colors.purple,),

                ],
              ),

            ),
            Tab(
              icon:controller.index == 3
                  ? Column(
                children: [
                  Icon(Icons.person,size: 40,color: Colors.purple,),

                ],
              ):
              Column(
                children: [
                  Icon(Icons.person,size: 25,color: Colors.purple,),

                ],
              ),

            ),

          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          DashBoardPage(),
          ViewAllAttendance(),
          ApplyForLeave(),
          EditProfile(),

        ],
      ),
    );
  }
}