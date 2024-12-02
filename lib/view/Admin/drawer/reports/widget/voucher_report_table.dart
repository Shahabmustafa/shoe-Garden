import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/tabletext/table_text.dart';

class VoucherReportTable extends StatelessWidget {
  VoucherReportTable(
      {required this.number,
      required this.customName,
      required this.amount,
      required this.description,
      required this.date,
      this.heading = false,
      this.editOnpress,
      this.deleteOnpress,
      super.key});

  String number;
  String customName;
  String amount;
  String description;
  String date;
  bool heading;

  final VoidCallback? editOnpress;
  final VoidCallback? deleteOnpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(5),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(1),
          6: FlexColumnWidth(1),
        },
        border: TableBorder.all(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade300,
        ),
        defaultColumnWidth: const FlexColumnWidth(0.5),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: heading ? const Color(0xff13132a) : Colors.white,
            ),
            children: [
              CustomTableCell(
                text: number,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: customName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: amount,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: description,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: date,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
