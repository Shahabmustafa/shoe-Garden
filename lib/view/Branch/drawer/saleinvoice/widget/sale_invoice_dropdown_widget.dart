import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SaleInvoiceDropdown extends StatelessWidget {
  SaleInvoiceDropdown({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.selectedItem,
    this.borderColor,
    this.allowBorder = true,
    this.enabled = true,
  });

  final List<String> items;
  final String labelText;
  final String? selectedItem;
  final Color? borderColor;
  final void Function(String?)? onChanged;
  final bool allowBorder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: enabled ? null : () {},
      child: AbsorbPointer(
        absorbing: !enabled,
        child: SizedBox(
          height: size.height * 0.06,
          child: DropdownSearch<String>(
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSelectedItems: false,
            ),
            items: items,
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: const TextStyle(color: Colors.black),
              dropdownSearchDecoration: InputDecoration(
                hintText: labelText,
                contentPadding: EdgeInsets.only(left: 15, top: 15),
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            onChanged: enabled ? onChanged : null,
            selectedItem: selectedItem,
          ),
        ),
      ),
    );
  }
}
