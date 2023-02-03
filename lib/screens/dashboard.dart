import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/attendance_model.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var data = Get.arguments;

  var isCheck = true;
  String timeIn = '', timeOut = '';
  bool isButtonClickable = true;
  bool noButtonClickable = true;
  var getInTime;
  var getOutTime;

  @override
  void initState() {
    super.initState();

    getEventsList();
  }

  List<AttendanceModel> attendanceList = [];
  DateTime _focusedDay = DateTime.now();

  var currentDateTimeIn;
  var currentDateTimeOut;

  getEventsList() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('attendance');
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs
        .map((attendance) => AttendanceModel(
              date: attendance['Date'],
              timeIn: attendance['Time_In'],
              timeOut: attendance['Time_Out'],
            ))
        .toList();

    setState(() {
      attendanceList = allData;
    });

    var currentDate = _focusedDay.day.toString() +
        DateFormat(' MMMM yyyy').format(_focusedDay);

    currentDateTimeIn = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeIn;
    currentDateTimeOut = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeOut;

    print('time in out : $currentDateTimeIn  : ${currentDateTimeOut}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Enter Your Today Attendance',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text('User Id : ${data[0]['1']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                          style: TextStyle(fontSize: 22, color: Colors.black45),
                        ),
                        Text(
                          currentDateTimeIn ?? "--/--",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Time Out',
                          style: TextStyle(fontSize: 22, color: Colors.black45),
                        ),
                        Text(
                          currentDateTimeOut ?? '--/--',
                          style: TextStyle(fontSize: 20),
                        ),
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
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        children: [
                      TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(color: Colors.black, fontSize: 20))
                    ]))),
            const SizedBox(height: 50.0),
            Center(
              child: InkWell(
                onTap: noButtonClickable
                    ? () {
                        setState(() {
                          noButtonClickable = false;
                          createStartTime();

                          getEventsList();
                          Get.snackbar("Success", "Welcome ",
                              snackPosition: SnackPosition.BOTTOM);
                        });
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
                onTap: isButtonClickable
                    ? () {
                        setState(() {
                          createEndTime();
                          isButtonClickable = false;

                          getEventsList();
                          Map<String, String> dataToSave = {
                            'Time_In': timeIn,
                            'Time_Out': timeOut.toString(),
                            'Date': DateTime.now().day.toString() +
                                DateFormat(' MMMM yyyy').format(DateTime.now()),
                          };

                          FirebaseFirestore.instance
                              .collection("attendance")
                              .add(dataToSave);

                          Get.snackbar("Success", "Good By ",
                              snackPosition: SnackPosition.BOTTOM);
                        });
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
  }

  createStartTime() {
    setState(() {
      timeIn = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  createEndTime() {
    setState(() {
      timeOut = DateFormat('hh:mm a').format(DateTime.now());
    });
  }
}
