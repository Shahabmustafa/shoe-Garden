import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../../tabletext/table_text.dart';

class TenTable extends StatelessWidget {
  TenTable(
      {required this.number,
      required this.image,
      required this.barcode,
      required this.articalName,
      required this.brand,
      required this.salePrice,
      required this.purchasePrice,
      required this.discount,
      this.heading = false,
      super.key});

  String number;
  String image;
  String barcode;
  String articalName;
  String brand;
  String salePrice;
  String purchasePrice;
  String discount;
  bool heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(2),
          7: FlexColumnWidth(2),
          8: FlexColumnWidth(1.5),
          9: FlexColumnWidth(1.5),
        },
        border: TableBorder.all(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade300,
        ),
        defaultColumnWidth: const FlexColumnWidth(0.5),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: heading ? Color(0xff13132a) : Colors.white,
            ),
            children: [
              CustomTableCell(
                text: number,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: image,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: barcode,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: articalName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: brand,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: salePrice,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: purchasePrice,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: discount,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              const TableCell(
                child: CustomIcon(
                    icons: CupertinoIcons.eyedropper, color: Colors.blue),
              ),
              const TableCell(
                child:
                    CustomIcon(icons: CupertinoIcons.delete, color: Colors.red),
              )
            ],
          ),
        ],
      ),
    );
  }
}