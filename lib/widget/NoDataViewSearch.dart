// // ignore_for_file: must_be_immutable
//
// import 'package:flutter/material.dart';
//
// class NoDataViewSearch extends StatelessWidget {
//   final BuildContext context;
//   late String? noDataText;
//   String appBarTitle;
//
//   NoDataViewSearch(this.context, {this.noDataText, required this.appBarTitle}) {
//     if (this.noDataText == null) {
//       this.noDataText = 'oops! Nothing';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(
//       children: [
//         Container(
//           // alignment: Alignment.center,
//           padding: EdgeInsets.only(top: 90, left: 30, right: 30),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                   height: 100,
//                   child: Image.asset(
//                     "images/error/error.png",
//                   )),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 8),
//                   child: Text(
//                     noDataText!,
//                     style: TextStyle(
//                         color: AppColors.appBlack,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//               Text(
//                 "        Found for ‘${appBarTitle}’ in our box \nYou can see below for similar products",
//                 style: TextStyle(
//                     color: AppColors.appBlack,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }
