// import 'package:flutter/material.dart';
// import 'package:freshmart/Theme.dart';
//
// class AppRadioButton<T> extends StatelessWidget {
//   final String title;
//   final T value;
//   final T groupValue;
//   final EdgeInsetsGeometry padding;
//   final Color titleColor;
//   final double fontSize;
//   final FontWeight? fontWeight;
//   final TextAlign? textAlign;
//   final TextDecoration? textDecoration;
//   final bool isExpanded;
//   final Function(T)? onChanged;
//
//   AppRadioButton({
//     required this.title,
//     required this.value,
//     required this.groupValue,
//     this.padding = const EdgeInsets.all(10.0),
//     this.titleColor = Colors.black,
//     this.fontSize = 14.0,
//     this.fontWeight,
//     this.textAlign,
//     this.textDecoration,
//     this.isExpanded = false,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Container(
//         padding: padding,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Icon(
//               value == groupValue
//                   ? Icons.radio_button_checked
//                   : Icons.radio_button_unchecked,
//               color: value == groupValue ? AppColors.app_blue : Colors.black,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             titleWidget(),
//           ],
//         ),
//       ),
//       onTap: () {
//         if (onChanged != null) {
//           onChanged!(value);
//         }
//       },
//     );
//   }
//
//   Widget titleWidget() {
//     if (isExpanded) {
//       return Expanded(
//         child: Text(
//           title,
//           textAlign: textAlign,
//           style: TextStyle(
//             color: titleColor,
//             fontSize: fontSize,
//             fontWeight: fontWeight,
//             decoration: textDecoration,
//           ),
//         ),
//       );
//     }
//     return Flexible(
//       child: Text(
//         title,
//         textAlign: textAlign,
//         style: TextStyle(
//           color: titleColor,
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           decoration: textDecoration,
//         ),
//       ),
//     );
//   }
// }
