import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/tabletext/table_text.dart';

import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class StockInventoryTable extends StatelessWidget {
  StockInventoryTable(
      {required this.number,
      required this.product,
      required this.companyName,
      required this.brandName,
      required this.type,
      required this.size,
      required this.quantity,
      this.heading = false,
      this.editOnpress,
      this.deleteOnpress,
      required this.color,
      super.key});

  String number;
  String product;
  String companyName;
  String brandName;
  String type;
  String size;
  String quantity;
  String color;
  bool heading;

  final VoidCallback? editOnpress;
  final VoidCallback? deleteOnpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(0.8),
          8: FlexColumnWidth(0.8),
          9: FlexColumnWidth(0.8),
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
                text: product,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: companyName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: brandName,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: color,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: type,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: size,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: quantity,
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
