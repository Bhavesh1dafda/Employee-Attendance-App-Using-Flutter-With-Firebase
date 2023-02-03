// import 'package:flutter/material.dart';
// import 'package:freshmart/model/appconfig/Currency.dart';
// import 'package:freshmart/model/cart/CartExtraInfo.dart';
// import 'package:freshmart/utils/AppUtility.dart';
// import 'package:freshmart/utils/Dimensions.dart';
// import 'package:freshmart/widget/TextView.dart';
//
// class CartInfoWidget extends StatelessWidget {
//   final CartExtraInfo cartInfo;
//   final Currency currency;
//
//   CartInfoWidget(this.cartInfo, this.currency);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(Dimensions(context).padding_3),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               TextView(
//                 'Total items : ',
//                 textColor: Colors.black,
//                 textAlign: TextAlign.center,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//               Text(
//                 "${cartInfo.items}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               TextView(
//                 'Total amount : ',
//                 textColor: Colors.black,
//                 textAlign: TextAlign.center,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//               Text(
//                 "${AppUtility.getAmountString(currency, cartInfo.amountpayable)}",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
