import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../../tabletext/table_text.dart';

class SeveenTable extends StatelessWidget {
  SeveenTable(
      {required this.number,
      required this.customerName,
      required this.amount,
      required this.description,
      required this.date,
      this.heading = false,
      this.editOnpress,
      this.deleteOnpress,
      super.key});

  String number;
  String customerName;
  String amount;
  String description;
  String date;
  bool heading;

  VoidCallback? editOnpress;
  VoidCallback? deleteOnpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(1.5),
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
                text: customerName,
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
              heading
                  ? CustomTableCell(
                      text: "Edit",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : InkWell(
                      onTap: editOnpress,
                      child: const CustomIcon(
                        icons: CupertinoIcons.eyedropper_full,
                        color: Colors.blue,
                      ),
                    ),
              heading
                  ? InkWell(
                      onTap: deleteOnpress,
                      child: CustomTableCell(
                        text: "Delete",
                        textColor: heading ? Colors.white : Colors.black,
                        fontWeight:
                            heading ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  : InkWell(
                      onTap: deleteOnpress,
                      child: const CustomIcon(
                        icons: CupertinoIcons.delete,
                        color: Colors.red,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}