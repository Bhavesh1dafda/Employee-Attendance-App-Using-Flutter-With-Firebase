import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../model/attendance_model.dart';
import '../../model/eventmodel.dart';

class ViewAllAttendance extends StatefulWidget {
  @override
  ViewAllAttendanceState createState() => ViewAllAttendanceState();
}

class ViewAllAttendanceState extends State<ViewAllAttendance> {
  final Stream<QuerySnapshot> eventsStream =
      FirebaseFirestore.instance.collection('attendance').snapshots();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<AttendanceModel> attendanceList = [];
  var currentDateTimeIn;
  var currentDateTimeOut;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEventsList();
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        getEventsList();
      });


    }
  }

  getEventsList() async {
    CollectionReference attendance =
        FirebaseFirestore.instance.collection('attendance');
    QuerySnapshot querySnapshot = await attendance.get();

    for (var element in querySnapshot.docs) {
      AttendanceModel attendanceModel = AttendanceModel();
      attendanceModel.date = element["Date"];
      attendanceModel.timeIn = element["Time_In"];
      attendanceModel.timeOut = element["Time_Out"];

      setState(() {
        attendanceList.add(attendanceModel);
      });
    }

    var currentDate = _selectedDay!.day.toString() +
        DateFormat(' MMMM yyyy').format(_selectedDay!);

    currentDateTimeIn = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeIn;
    currentDateTimeOut = attendanceList
        .firstWhereOrNull((element) => element.date == currentDate)
        ?.timeOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mothly Attendance Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: eventsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // List<CalendarItemData
            }
            return Column(
              children: [
                Card(
                  child: TableCalendar<AttendanceModel>(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    holidayPredicate: (day) {
                      // Weekends
                      return day.weekday >= 6;
                    },
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                      ),
                      titleCentered: true,
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                    weekendDays: const [
                      DateTime.sunday,
                      DateTime.saturday,
                    ],
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: _onDaySelected,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: Text(currentDateTimeIn == null
                      ? "No Data Available"
                      : "Time In : " + currentDateTimeIn.toString()),
                ),
                ListTile(
                  title: Text(currentDateTimeOut == null
                      ? "No Data Available"
                      : "Time Out : " + currentDateTimeOut.toString()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
