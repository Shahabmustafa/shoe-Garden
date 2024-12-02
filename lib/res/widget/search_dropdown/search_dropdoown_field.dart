//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
// import 'package:sofi_shoes/res/color/app_color.dart';
//
// import '../../responsive.dart';
//
// class SearchAbleDropDown extends StatelessWidget {
//   SearchAbleDropDown({required this.hintText,this.items,this.onChanged,super.key});
//
//   String hintText;
//   List<SearchableDropdownMenuItem<dynamic>>? items;
//   void Function(dynamic?)? onChanged;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Responsive.isDesktop(context)
//           ? MediaQuery.sizeOf(context).width * 0.3
//           : Responsive.isTablet(context)
//           ? MediaQuery.sizeOf(context).width * 0.5
//           : MediaQuery.sizeOf(context).width * 1,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.primaryColor),
//       ),
//       child: SearchableDropdown<dynamic>(
//         hintText: Text(hintText),
//         isDialogExpanded: false,
//         margin: const EdgeInsets.all(15),
//         items: items,
//         onChanged: onChanged,
//         dialogOffset: -10,
//       ),
//     );
//   }
// }
