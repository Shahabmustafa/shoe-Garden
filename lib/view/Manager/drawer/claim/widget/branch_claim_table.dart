import 'package:flutter/material.dart';

import '../../../../../res/tabletext/table_text.dart';

class BranchClaimTable extends StatelessWidget {
  BranchClaimTable(
      {required this.number,
      required this.branchName,
      required this.product,
      required this.brand,
      required this.company,
      required this.type,
      required this.color,
      required this.size,
      required this.description,
      required this.status,
      required this.date,
      this.heading = false,
      this.changeStatus,
      super.key});

  String number;
  String branchName;
  String product;
  String brand;
  String company;
  String type;
  String color;
  String size;
  String description;
  String date;
  String status;
  bool heading;

  VoidCallback? changeStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
          8: FlexColumnWidth(2),
          9: FlexColumnWidth(2),
          10: FlexColumnWidth(2),
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
                text: branchName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: product,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: brand,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: company,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: type,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: color,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: size,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: description,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              InkWell(
                onTap: changeStatus,
                child: CustomTableCell(
                  text: status,
                  textColor: heading
                      ? Colors.white
                      : status == 'approved'
                          ? Colors.green
                          : status == 'not approved'
                              ? Colors.red
                              : Colors.grey,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
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
