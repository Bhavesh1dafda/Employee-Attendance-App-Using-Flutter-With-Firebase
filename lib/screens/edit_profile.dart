import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emloyee_attendance_app/screens/change_password.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController idController = TextEditingController();
  TextEditingController usnameController = TextEditingController();
  TextEditingController desiController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return pickedFile;
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return null;

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref("images")
          .child('1113131');

      await ref.putFile(_photo!);
    } catch (e) {

    }
  }

  String? downloadURL;

  Future getData() async {
    try {
      await downloadURLExample();
      return downloadURL;
    } catch (e) {

      return null;
    }
  }

  Future<void> downloadURLExample() async {
    downloadURL = await FirebaseStorage.instance
        .ref("images")
        .child("01-shutterstock_476340928-Irina-Bg.jpg")
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 15),
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.more_vert),
            color: Color(0xffFFFFFF),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: Container(
                height: 20,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => ChangPass());
                        },
                        child: Text('Chang Password')),
                  ],
                ),
              ))
            ],
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        "Something went wrong",
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot.data.toString(),
                                    ))),
                            height: 150,
                            width:150,

                          ),
                          Positioned(right: 10,
                              bottom: 0,
                              child: Container(height: 50,width: 50,
                                  child: Image.asset("assets/camera.png"))),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ID",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      border: myinputborder(), //normal border
                      enabledBorder: myinputborder(), //enabled border
                      focusedBorder: myfocusborder(), //focused border
                      // set more border style like disabledBorder
                    )),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "User Name",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: usnameController,
                    decoration: InputDecoration(
                      border: myinputborder(), //normal border
                      enabledBorder: myinputborder(), //enabled border
                      focusedBorder: myfocusborder(), //focused border
                      // set more border style like disabledBorder
                    )),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Designation",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: desiController,
                    decoration: InputDecoration(
                      border: myinputborder(), //normal border
                      enabledBorder: myinputborder(), //enabled border
                      focusedBorder: myfocusborder(), //focused border
                      // set more border style like disabledBorder
                    )),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: myinputborder(), //normal border
                      enabledBorder: myinputborder(), //enabled border
                      focusedBorder: myfocusborder(), //focused border
                      // set more border style like disabledBorder
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print("You pressed Icon Elevated Button");
                    Map<String, String> dataToSave = {
                      'ID': idController.text,
                      'UserName': usnameController.text,
                      'Designation': desiController.text,
                      'Address': addressController.text,
                      'profile': _photo.toString(),
                    };

                    FirebaseFirestore.instance
                        .collection("profile_update")
                        .add(dataToSave);
                    idController.clear();
                    usnameController.clear();
                    desiController.clear();
                    addressController.clear();

                    Get.snackbar("Success", "Profile Updated ",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  //icon data for elevated button
                  child: Text("Update Profile"), //label text
                ),
              )
            ],
          ),
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
