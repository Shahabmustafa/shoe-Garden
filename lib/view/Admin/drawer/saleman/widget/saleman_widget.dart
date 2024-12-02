import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../res/tabletext/table_text.dart';
import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class SalemanTable extends StatelessWidget {
  SalemanTable(
      {required this.number,
      required this.name,
      required this.phoneNumber,
      required this.salary,
      required this.address,
      required this.branchName,
      required this.commission,
      this.heading = false,
      this.editOnpress,
      this.deleteOnpress,
      super.key});

  String number;
  String name;
  String phoneNumber;
  String salary;
  String commission;
  String address;
  String branchName;
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
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(2),
          7: FlexColumnWidth(1.5),
          8: FlexColumnWidth(1.5),
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
                text: branchName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: name,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: commission,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: phoneNumber,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: salary,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: address,
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
