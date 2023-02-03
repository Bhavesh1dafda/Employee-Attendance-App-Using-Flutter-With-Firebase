// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NoDataViewTimeSlot extends StatelessWidget {
  final BuildContext context;
  String? noDataText;

  NoDataViewTimeSlot(this.context, {this.noDataText}) {
    if (this.noDataText == null) {
      this.noDataText = 'Currently service unavilable in this area';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  noDataText!,
                  style: TextStyle(
                      color: Colors.blue,

                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
