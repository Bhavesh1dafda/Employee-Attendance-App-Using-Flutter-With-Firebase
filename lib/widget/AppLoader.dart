import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
