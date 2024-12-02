// import 'package:flutter/material.dart';
//
// class SaleInvoiceTextField extends StatelessWidget {
//   SaleInvoiceTextField({required this.hintText,this.enabled = false,this.keyboardType,this.focusNode,this.controller,this.onSubmitted,super.key});
//   String hintText;
//   bool enabled;
//   TextInputType? keyboardType;
//   TextEditingController? controller;
//   void Function(String)? onSubmitted;
//   FocusNode? focusNode;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         // height: 30,
//         child: Center(
//           child: TextField(
//             keyboardType: keyboardType,
//             controller: controller,
//             focusNode: focusNode,
//             decoration: InputDecoration(
//               hintText: hintText,
//               enabled: enabled,
//               border: InputBorder.none,
//             ),
//             onSubmitted: onSubmitted,
//           ),
//         ),
//       ),
//     );
//   }
// }
