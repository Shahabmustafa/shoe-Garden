import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../../tabletext/table_text.dart';

class FourTable extends StatelessWidget {
  FourTable(
      {required this.number,
      required this.name,
      this.heading = false,
      this.onTapDelete,
      this.onTapEdit,
      super.key});

  String number;
  String name;
  bool heading;
  VoidCallback? onTapDelete;
  VoidCallback? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(5),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
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
                text: name,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              heading
                  ? CustomTableCell(
                      text: "Edit",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : GestureDetector(
                      onTap: onTapEdit,
                      child: CustomIcon(
                        icons: CupertinoIcons.eyedropper_full,
                        color: Colors.blue,
                      ),
                    ),
              heading
                  ? CustomTableCell(
                      text: "Delete",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : GestureDetector(
                      onTap: onTapDelete,
                      child: CustomIcon(
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
