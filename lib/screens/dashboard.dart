import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emloyee_attendance_app/controller/dashboard_controller.dart';
import 'package:emloyee_attendance_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/dashboard_controller.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var data = Get.arguments;

  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Welcome'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(onTap: (){
                    Get.to(()=>LoginPage());
                  },
                      child: Icon(Icons.logout)),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Enter Your Today Attendance',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                  ),

                  // Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 15),
                  //     alignment: Alignment.centerLeft,
                  //     child: Text('User Id : ${data[0]['1']}',
                  //         style: const TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 16))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Time In',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => Text(
                                  controller.currentDateTimeIn.toString().isEmpty
                                      ? "--/--"
                                      : controller.timeIn.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Time Out',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black45),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => Text(
                                  controller.timeOut.toString().isEmpty
                                      ? "--/--"
                                      : controller.timeOut.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1)),
                    builder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                              text: DateTime.now().day.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              children: [
                            TextSpan(
                                text: DateFormat(' MMMM yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20))
                          ]))),
                  const SizedBox(height: 50.0),
                  Center(
                    child: InkWell(
                      onTap: controller.noButtonClickable.value
                          ? () {
                              controller.noButtonClickable.value = false;
                              controller.createStartTime();
                              print(controller.timeIn.toString());

                              Get.snackbar("Success", "Welcome ",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          : () {
                              Get.snackbar("Sorry!", 'Only One Time Click');
                            },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 45.0,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Time In',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Center(
                    child: InkWell(
                      onTap: controller.isButtonClickable.value
                          ? () {
                              controller.isButtonClickable.value = false;
                              controller.createEndTime();
                              controller.getEventsList();
                              Map<String, String> dataToSave = {
                                'Time_In': controller.timeIn.toString(),
                                'Time_Out': controller.timeOut.toString(),
                                'Date': DateTime.now().day.toString() +
                                    DateFormat(' MMMM yyyy')
                                        .format(DateTime.now()),
                              };
                              print(controller.timeOut.toString());

                              FirebaseFirestore.instance
                                  .collection("attendance")
                                  .add(dataToSave);

                              Get.snackbar("Success", "Good By ",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          : () {
                              Get.snackbar("Sorry!", 'You Already Clicked ');
                            },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 45.0,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Time Out',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
