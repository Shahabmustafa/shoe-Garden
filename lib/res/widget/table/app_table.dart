import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../../tabletext/table_text.dart';

class AppTable extends StatelessWidget {
  AppTable(
      {this.rowOne,
      this.rowTwo,
      this.rowThree,
      this.rowSix,
      this.rowSeven,
      this.rowFour,
      this.rowFive,
      this.rowEight,
      // this.valueRowOne,
      // this.valueRowTwo,
      // this.valueRowThree,
      // this.valueRowFour,
      // this.valueRowFive,
      // this.valueRowSix,
      // this.valueRowSeven,
      // this.valueRowEight,
      // this.valueRowNine,
      required this.limit,
      this.heading = false,
      this.icons = false,
      super.key});
  List<String> title = [];
  String? rowOne;
  String? rowTwo;
  String? rowThree;
  String? rowFour;
  String? rowFive;
  String? rowSix;
  String? rowSeven;
  String? rowEight;
  bool heading;
  bool icons;
  int limit = 0;

  // Double? valueRowOne;
  // Double? valueRowTwo;
  // Double? valueRowThree;
  // Double? valueRowFour;
  // Double? valueRowFive;
  // Double? valueRowSix;
  // Double? valueRowSeven;
  // Double? valueRowEight;
  // Double? valueRowNine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Table(
        columnWidths: {
          // 0: FlexColumnWidth([valueRowOne]),
          // 1: FlexColumnWidth(valueRowTwo),
          // 2: FlexColumnWidth(valueRowThree),
          // 3: FlexColumnWidth(valueRowFour),
          // 4: FlexColumnWidth(valueRowFive),
          // 5: FlexColumnWidth(valueRowSix),
          // 6: FlexColumnWidth(valueRowSeven),
          // 7: FlexColumnWidth(valueRowEight),
          // 8: FlexColumnWidth(valueRowNine),
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
              for (int i = 0; i.bitLength < limit; i++)
                CustomTableCell(
                  text: title.toString(),
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              TableCell(
                child: heading
                    ? CustomTableCell(
                        text: rowSeven.toString(),
                        textColor: heading ? Colors.white : Colors.black,
                        fontWeight:
                            heading ? FontWeight.bold : FontWeight.normal,
                      )
                    : CustomIcon(
                        icons: CupertinoIcons.eyedropper, color: Colors.blue),
              ),
              TableCell(
                child: heading
                    ? CustomTableCell(
                        text: rowSeven.toString(),
                        textColor: heading ? Colors.white : Colors.black,
                        fontWeight:
                            heading ? FontWeight.bold : FontWeight.normal,
                      )
                    : CustomIcon(
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
