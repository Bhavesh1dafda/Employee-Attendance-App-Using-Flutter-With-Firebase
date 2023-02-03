// // ignore_for_file: deprecated_member_use
//
// import 'package:flutter/material.dart';
// import 'package:freshmart/Theme.dart';
//
// class AppRaisedButton extends StatelessWidget {
//   final String? title;
//   final Widget? child;
//   final Color color;
//   final double height;
//   final double? width;
//   final double borderRadius;
//   final Color titleColor;
//   final double titleSize;
//   final FontWeight titleFontWeight;
//   final VoidCallback? onPressed;
//
//   AppRaisedButton({
//     this.title,
//     this.child,
//     this.color = AppColors.primaryColor,
//     this.height = 40.0,
//     this.width,
//     this.borderRadius = 0,
//     this.titleColor = Colors.white,
//     this.titleSize = 16.0,
//     this.titleFontWeight = FontWeight.bold,
//     this.onPressed,
//     String? fontFamily,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       width: width,
//       height: height,
//       child: RaisedButton(
//           elevation: 0,
//           color: color,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(borderRadius)),
//           child: title != null
//               ? Text(
//                   title!,
//                   style: TextStyle(
//                     color: titleColor,
//                     fontSize: titleSize,
//                     fontWeight: titleFontWeight,
//                   ),
//                   maxLines: 1,
//                 )
//               : child,
//           onPressed: onPressed),
//     );
//   }
// }
