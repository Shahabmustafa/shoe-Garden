import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../responsive.dart';

// ignore: must_be_immutable
class AppDropDown extends StatelessWidget {
  AppDropDown({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.selectedItem,
    this.borderColor,
    this.allowBorder = true,
    this.enabled = true,
  });
  List<String> items;
  String labelText;
  String? selectedItem;
  Color? borderColor;

  void Function(String?)? onChanged;
  bool allowBorder;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.07,
      width: Responsive.isDesktop(context)
          ? size.width * 0.3
          : Responsive.isTablet(context)
              ? size.width * 0.5
              : size.width * 1,
      child: DropdownSearch<String>(
        items: items,
        enabled: enabled,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: labelText,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            border: const OutlineInputBorder(),
          ),
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search here',
            ),
          ),
          searchDelay: Duration(microseconds: 10),
          showSelectedItems: true,
          isFilterOnline: true,
        ),
      ),
    );
  }
}
