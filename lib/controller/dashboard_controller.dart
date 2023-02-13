import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/attendance_model.dart';

class DashboardController extends GetxController {
  final timeIn = "".obs;
  final timeOut = "".obs;
  RxBool isButtonClickable = true.obs;
  RxBool noButtonClickable = true.obs;

  createStartTime() {
    timeIn.value = DateFormat('hh:mm a').format(DateTime.now());
    update();
  }

  createEndTime() {
    timeOut.value = DateFormat('hh:mm a').format(DateTime.now());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    createStartTime();
    createEndTime();
    getEventsList();
  }

  List<AttendanceModel> attendanceList = [];
  DateTime _focusedDay = DateTime.now();

  var currentDateTimeIn;
  var currentDateTimeOut;

  getEventsList() async {
    CollectionReference attendance =
        FirebaseFirestore.instance.collection('attendance');
    QuerySnapshot querySnapshot = await attendance.get();

    for (var element in querySnapshot.docs) {
      AttendanceModel attendanceModel = AttendanceModel();
      attendanceModel.date = element["Date"];
      attendanceModel.timeIn = element["Time_In"];
      attendanceModel.timeOut = element["Time_Out"];
      attendanceList.add(attendanceModel);
    }

    var currentDate = _focusedDay.day.toString() +
        DateFormat(' MMMM yyyy').format(_focusedDay);

    currentDateTimeIn = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeIn;

    currentDateTimeOut = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeOut;
  }
}
