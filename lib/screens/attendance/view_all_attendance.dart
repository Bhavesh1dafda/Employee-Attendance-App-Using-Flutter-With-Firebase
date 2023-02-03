import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

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
      body: StreamBuilder<Object>(
        stream: eventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List<CalendarItemData
          }
          return Column(
            children: [
              Card(
                child: TableCalendar<Event>(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
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
                title: Text(currentDateTimeIn == null ?  "No Data Available": "Time In : "+ currentDateTimeIn.toString() ),
              ),
              ListTile(
                title: Text(currentDateTimeOut == null ? "No Data Available": "Time Out : "+ currentDateTimeOut.toString()),
              ),
            ],
          );
        },
      ),
    );
  }
}

//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class ViewAllAttendance extends StatefulWidget {
//   const ViewAllAttendance({Key? key}) : super(key: key);
//
//   @override
//   State<ViewAllAttendance> createState() => _ViewAllAttendanceState();
// }
//
// class _ViewAllAttendanceState extends State<ViewAllAttendance> {
//   Future<void> getDataFromFireStore() async {
//     var snapShotsValue = await fireStoreReference
//         .collection("CalendarAppointmentCollection")
//         .get();
//
//     final Random random = new Random();
//     List<Meeting> list = snapShotsValue.docs
//         .map((e) => Meeting(
//         eventName: e.data()['Subject'],
//         from:
//         DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
//         to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
//         background: _colorCollection[random.nextInt(9)],
//         isAllDay: false,
//         key: e.id))
//         .toList();
//     setState(() {
//       events = MeetingDataSource(list);
//     });
//   }
//   void initState() {
//     _initializeEventColor();
//     getDataFromFireStore().then((results) {
//       SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
//         setState(() {});
//       });
//     });
//     fireStoreReference
//         .collection("CalendarAppointmentCollection")
//         .snapshots()
//         .listen((event) {
//       event.docChanges.forEach((element) {
//         if (element.type == DocumentChangeType.added) {
//           if (!isInitialLoaded) {
//             return;
//           }
//
//           final Random random = new Random();
//           Meeting app = Meeting.fromFireBaseSnapShotData(element,  _colorCollection[random.nextInt(9)]);
//           setState(() {
//             events!.appointments!.add(app);
//             events!.notifyListeners(CalendarDataSourceAction.add, [app]);
//           });
//         } else if (element.type == DocumentChangeType.modified) {
//           if (!isInitialLoaded) {
//             return;
//           }
//
//           final Random random = new Random();
//           Meeting app = Meeting.fromFireBaseSnapShotData(element,  _colorCollection[random.nextInt(9)]);
//           setState(() {
//             int index = events!.appointments!
//                 .indexWhere((app) => app.key == element.doc.id);
//
//             Meeting meeting = events!.appointments![index];
//
//             events!.appointments!.remove(meeting);
//             events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
//             events!.appointments!.add(app);
//             events!.notifyListeners(CalendarDataSourceAction.add, [app]);
//           });
//
//         }
//         else if (element.type == DocumentChangeType.removed) {
//           if (!isInitialLoaded) {
//             return;
//           }
//
//           setState(() {
//             int index = events!.appointments!
//                 .indexWhere((app) => app.key == element.doc.id);
//
//             Meeting meeting = events!.appointments![index];
//             events!.appointments!.remove(meeting);
//             events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
//           });
//         }
//       });
//
//       static Meeting fromFireBaseSnapShotData(dynamic element, Color color) {
//         return Meeting(
//             eventName: element.doc.data()!['Subject'],,
//             from: DateFormat('dd/MM/yyyy HH:mm:ss')
//             .parse(element.doc.data()!['StartTime']),
//         to: DateFormat('dd/MM/yyyy HH:mm:ss')
//             .parse(element.doc.data()!['EndTime']),
//         background: color,
//         isAllDay: false,
//         key: element.doc.id);
//       }
//
//
//   @override
//   Widget build(BuildContext context) {
//     List dataList = [];
//
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Mothly Attendance Report"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Container(
//             //   height: 800,
//             //
//             //   child: FutureBuilder(
//             //     future: FireStoreDataBase().getData(),
//             //     builder: (context, snapshot) {
//             //       if (snapshot.hasError) {
//             //         return const Text(
//             //           "Something went wrong",
//             //         );
//             //       }
//             //       if (snapshot.connectionState == ConnectionState.done) {
//             //         dataList = snapshot.data as List;
//             //         return buildItemsA(dataList);
//             //       }
//             //       return const Center(child: CircularProgressIndicator());
//             //     },
//             //   ),
//             // ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildItemsA(dataList) => GridView.builder(
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20),
//         padding: const EdgeInsets.all(8),
//         itemCount: dataList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 20,
//             width: 20,
//             child: Column(
//               children: [
//                 Text(
//                   "Date : " + dataList[index]["Date"].toString(),
//                 ),
//                 Text(
//                   "Time In : " + dataList[index]["Time In"].toString(),
//                 ),
//                 Text("Time Out : " + dataList[index]["Time Out"].toString()),
//               ],
//             ),
//           );
//         },
//       );
// }
//
// class FireStoreDataBase {
//   List studentsList = [];
//   final CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection("attendance");
//
//   Future getData() async {
//     try {
//       //to get data from a single/particular document alone.
//       // var temp = await collectionRef.doc("<your document ID here>").get();
//
//       // to get data from all documents sequentially
//       await collectionRef.get().then((querySnapshot) {
//         for (var result in querySnapshot.docs) {
//           studentsList.add(result.data());
//         }
//       });
//
//       return studentsList;
//     } catch (e) {
//       debugPrint("Error - $e");
//       return e;
//     }
//   }
// }
// // import 'dart:math';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/scheduler.dart';
// // import 'package:syncfusion_flutter_calendar/calendar.dart';
// // import 'package:intl/intl.dart';
// //
// // class ViewAllAttendance extends StatefulWidget {
// //   const ViewAllAttendance({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ViewAllAttendance> createState() => _ViewAllAttendanceState();
// // }
// //
// // class _ViewAllAttendanceState extends State<ViewAllAttendance> {
// //   List<Color> _colorCollection = <Color>[];
// //   MeetingDataSource? events;
// //   final List<String> options = <String>['Add', 'Delete', 'Update'];
// //   final fireStoreReference = FirebaseFirestore.instance;
// //   bool isInitialLoaded = false;
// //
// //   @override
// //   void initState() {
// //     _initializeEventColor();
// //     getDataFromFireStore().then((results) {
// //       SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
// //         setState(() {});
// //       });
// //     });
// //     fireStoreReference.collection("attendance").snapshots().listen((event) {
// //       event.docChanges.forEach((element) {
// //         if (element.type == DocumentChangeType.added) {
// //           if (!isInitialLoaded) {
// //             return;
// //           }
// //
// //           final Random random = new Random();
// //           Meeting app = Meeting.fromFireBaseSnapShotData(
// //               element, _colorCollection[random.nextInt(9)]);
// //           setState(() {
// //             events!.appointments!.add(app);
// //             events!.notifyListeners(CalendarDataSourceAction.add, [app]);
// //           });
// //         } else if (element.type == DocumentChangeType.modified) {
// //           if (!isInitialLoaded) {
// //             return;
// //           }
// //
// //           final Random random = new Random();
// //           Meeting app = Meeting.fromFireBaseSnapShotData(
// //               element, _colorCollection[random.nextInt(9)]);
// //           setState(() {
// //             int index = events!.appointments!
// //                 .indexWhere((app) => app.key == element.doc.id);
// //
// //             Meeting meeting = events!.appointments![index];
// //
// //             events!.appointments!.remove(meeting);
// //             events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
// //             events!.appointments!.add(app);
// //             events!.notifyListeners(CalendarDataSourceAction.add, [app]);
// //           });
// //         } else if (element.type == DocumentChangeType.removed) {
// //           if (!isInitialLoaded) {
// //             return;
// //           }
// //
// //           setState(() {
// //             int index = events!.appointments!
// //                 .indexWhere((app) => app.key == element.doc.id);
// //
// //             Meeting meeting = events!.appointments![index];
// //             events!.appointments!.remove(meeting);
// //             events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
// //           });
// //         }
// //       });
// //     });
// //     super.initState();
// //   }
// //
// //   Future<void> getDataFromFireStore() async {
// //     var snapShotsValue =
// //     await fireStoreReference.collection("attendance").get();
// //
// //     final Random random = new Random();
// //     List<Meeting> list = snapShotsValue.docs
// //         .map((e) => Meeting(
// //         LogIn: e.data()['Log In'],
// //         Date:e.data()['Log Out'],
// //         LogOut: e.data()['UserName'],
// //
// //         key: e.id))
// //         .toList();
// //     setState(() {
// //       events = MeetingDataSource(list);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     isInitialLoaded = true;
// //     return Scaffold(
// //         appBar: AppBar(
// //             leading: PopupMenuButton<String>(
// //               icon: Icon(Icons.settings),
// //               itemBuilder: (BuildContext context) => options.map((String choice) {
// //                 return PopupMenuItem<String>(
// //                   value: choice,
// //                   child: Text(choice),
// //                 );
// //               }).toList(),
// //               onSelected: (String value) {
// //                 if (value == 'Add') {
// //                   fireStoreReference.collection("attendance").doc("attendance").set({
// //                     'Log In': 'Log IN',
// //                     'Log Out': 'Log Out',
// //                     'UserName': 'UserName'
// //                   });
// //                 } else if (value == "Delete") {
// //                   try {
// //                     fireStoreReference.collection('attendance').doc('attendance').delete();
// //                   } catch (e) {}
// //                 } else if (value == "Update") {
// //                   try {
// //                     fireStoreReference
// //                         .collection('attendance')
// //                         .doc('1')
// //                         .update({'Subject': 'Date'});
// //                   } catch (e) {}
// //                 }
// //               },
// //             )),
// //         body: SfCalendar(
// //           view: CalendarView.month,
// //           initialDisplayDate: DateTime(2023, 1, 5, 9, 0, 0),
// //           dataSource: events,
// //           monthViewSettings: MonthViewSettings(
// //             showAgenda: true,
// //           ),
// //         ));
// //   }
// //
// //   void _initializeEventColor() {
// //     _colorCollection.add(const Color(0xFF0F8644));
// //     _colorCollection.add(const Color(0xFF8B1FA9));
// //     _colorCollection.add(const Color(0xFFD20100));
// //     _colorCollection.add(const Color(0xFFFC571D));
// //     _colorCollection.add(const Color(0xFF36B37B));
// //     _colorCollection.add(const Color(0xFF01A1EF));
// //     _colorCollection.add(const Color(0xFF3D4FB5));
// //     _colorCollection.add(const Color(0xFFE47C73));
// //     _colorCollection.add(const Color(0xFF636363));
// //     _colorCollection.add(const Color(0xFF0A8043));
// //   }
// // }
// //
// // class MeetingDataSource extends CalendarDataSource {
// //   MeetingDataSource(List<Meeting> source) {
// //     appointments = source;
// //   }
// //
// //   @override
// //   String getSubject(int index) {
// //     return appointments![index].Date;
// //   }
// //
// //   @override
// //   String LogIn(int index) {
// //     return appointments![index].LogIn;
// //   }
// //
// //   @override
// //   String LogOut(int index) {
// //     return appointments![index].LogOut;
// //   }
// // }
// //
// // class Meeting {
// //   String? Date;
// //   String? LogIn;
// //   String? LogOut;
// //   String? key;
// //
// //   Meeting({
// //     this.Date,
// //     this.LogIn,
// //     this.LogOut, this.key
// //   });
// //
// //   static Meeting fromFireBaseSnapShotData(dynamic element, Color color) {
// //     return Meeting(
// //         Date: element.doc.data()!['Date'],
// //         LogIn: element.doc.data()!['Log In'],
// //         LogOut: element.doc.data()!['Log Out'],
// //         key: element.doc.id
// //
// //     );
// //   }
// // }
