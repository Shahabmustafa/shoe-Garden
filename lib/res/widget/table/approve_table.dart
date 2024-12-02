import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../res/tabletext/table_text.dart';
import '../../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';

class ApproveTableWidget extends StatelessWidget {
  ApproveTableWidget(
      {required this.number,
      required this.one,
      required this.two,
      required this.three,
      this.view,
      this.editOnpress,
      this.deleteOnpress,
      this.heading = false,
      this.onlyApprove = false,
      this.approve,
      super.key});

  String number;
  String one;
  String two;
  String three;
  bool heading;
  bool onlyApprove;

  final VoidCallback? editOnpress;
  final VoidCallback? deleteOnpress;
  final VoidCallback? view;
  final VoidCallback? approve;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(3),
          6: FlexColumnWidth(3),
          7: FlexColumnWidth(3),
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
                text: one,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: two,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: three,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              heading
                  ? CustomTableCell(
                      text: "View",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : InkWell(
                      onTap: view,
                      child: const CustomIcon(
                        icons: Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
              onlyApprove == true
                  ? heading
                      ? CustomTableCell(
                          text: "Approve",
                          textColor: heading ? Colors.white : Colors.black,
                          fontWeight:
                              heading ? FontWeight.bold : FontWeight.normal,
                        )
                      : InkWell(
                          onTap: approve,
                          child: const CustomIcon(
                            icons: Icons.approval,
                            color: Colors.blue,
                          ),
                        )
                  : Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            heading
                                ? CustomTableCell(
                                    text: "Approve",
                                    textColor:
                                        heading ? Colors.white : Colors.black,
                                    fontWeight: heading
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  )
                                : InkWell(
                                    onTap: approve,
                                    child: const CustomIcon(
                                      icons: Icons.approval,
                                      color: Colors.blue,
                                    ),
                                  ),
                            heading
                                ? CustomTableCell(
                                    text: "Edit",
                                    textColor:
                                        heading ? Colors.white : Colors.black,
                                    fontWeight: heading
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  )
                                : InkWell(
                                    onTap: editOnpress,
                                    child: const CustomIcon(
                                      icons: CupertinoIcons.eyedropper_full,
                                      color: Colors.blue,
                                    ),
                                  ),
                            heading
                                ? CustomTableCell(
                                    text: "Delete",
                                    textColor:
                                        heading ? Colors.white : Colors.black,
                                    fontWeight: heading
                                        ? FontWeight.bold
                                        : FontWeight.normal,
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
            ],
          ),
        ],
      ),
    );
  }
}
