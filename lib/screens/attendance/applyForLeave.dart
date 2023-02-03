import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApplyForLeave extends StatefulWidget {
  const ApplyForLeave({Key? key}) : super(key: key);

  @override
  State<ApplyForLeave> createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  TextEditingController fromdatecontroller = TextEditingController();
  TextEditingController todatecontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  //text editing controller for text field

  @override
  void initState() {
    fromdatecontroller.text = ""; //set the initial value of text field
    todatecontroller.text = ""; //set the initial value of text field
    reasoncontroller.text = ""; //set the initial value of text field
    notecontroller.text = ""; //set the initial value of text field
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply For Leave'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "From Date",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                      Container(
                          height: 50,
                          width: 150,
                          child: Center(
                              child: TextField(
                                controller: fromdatecontroller,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                    ),
                                    //icon of text field
                                    labelText: "Enter Date",
                                    labelStyle:
                                    TextStyle(fontSize: 20) //label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                  );

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      fromdatecontroller.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ))),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "To Date",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                      Container(
                          height: 50,
                          width: 150,
                          child: Center(
                              child: TextField(
                                controller: todatecontroller,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                    ),
                                    //icon of text field
                                    labelText: "Enter Date",
                                    labelStyle:
                                    TextStyle(fontSize: 20) //label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                  );

                                  if (pickedDate != null) {

                                    String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);


                                    setState(() {
                                      todatecontroller.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reason :",
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 15),
              child: TextField(controller: reasoncontroller,
                  decoration: InputDecoration(
                    border: myinputborder(), //normal border
                    enabledBorder: myinputborder(), //enabled border
                    focusedBorder: myfocusborder(), //focused border
                    // set more border style like disabledBorder
                  )),
            ), SizedBox(height: 15,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Note :",
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 15),
              child: TextField(controller: notecontroller,

                  decoration: InputDecoration(
                    border: myinputborder(), //normal border
                    enabledBorder: myinputborder(), //enabled border
                    focusedBorder: myfocusborder(), //focused border
                    // set more border style like disabledBorder
                  )),
            ), SizedBox(
              height: 70,
            ),
            Container(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {

                  print("You pressed Icon Elevated Button");
                  Map<String,String> dataToSave = {
                    'FromDate' : fromdatecontroller.text,
                    'ToDate' : todatecontroller.text,
                    'Reason' : reasoncontroller.text,
                    'Note' : notecontroller.text,
                  };

                  FirebaseFirestore.instance.collection('Leave').add(dataToSave);
                  fromdatecontroller.clear();
                  todatecontroller.clear();
                  reasoncontroller.clear();
                  notecontroller.clear();

                  Get.snackbar("Success", "Please Wait Approved For Leave ",snackPosition: SnackPosition.BOTTOM);

                },
                //icon data for elevated button
                child: Text("Apply For Leave",style: TextStyle(fontSize: 20),), //label text
              ),
            )

          ],
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