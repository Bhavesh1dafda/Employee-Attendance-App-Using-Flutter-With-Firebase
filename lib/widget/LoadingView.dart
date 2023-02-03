import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: CircularProgressIndicator(),
    );
  }
}
