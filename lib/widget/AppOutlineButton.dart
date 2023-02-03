// import 'package:flutter/material.dart';
//
// class AppOutlineButton extends StatelessWidget {
//   final String? title;
//   final Widget? child;
//   final Color? color;
//   final double? height;
//   final double? width;
//   final double? borderRadius;
//   final Color? titleColor;
//   final double titleSize;
//   final FontWeight? titleFontWeight;
//   final VoidCallback? onPressed;
//
//   AppOutlineButton({
//     this.title,
//     this.child,
//     this.color = AppColors.primaryColor,
//     this.height = 40.0,
//     this.width,
//     this.borderRadius = 0,
//     this.titleColor = AppColors.primaryColor,
//     this.titleSize = 16.0,
//     this.titleFontWeight = FontWeight.bold,
//     this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return SizedBox(
//       width: width,
//       height: height,
//       child: OutlinedButton(
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(color: color!),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 borderRadius!,
//               ),
//             ),
//             textStyle: TextStyle(
//               color: titleColor,
//               fontSize: titleSize,
//               fontWeight: titleFontWeight,
//             ),
//           ),
//           child: title != null
//               ? Text(
//                   title!,
//                 )
//               : child ??
//                   const SizedBox(
//                     height: 0,
//                     width: 0,
//                   ),
//           onPressed: onPressed),
//     );
//   }
// }
