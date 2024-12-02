import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/tabletext/table_text.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class StockInventoryTable extends StatelessWidget {
  StockInventoryTable(
      {required this.number,
      required this.product,
      required this.barcode,
      required this.color,
      required this.size,
      required this.type,
      required this.quantity,
      required this.brand,
      required this.company,
      this.heading = false,
      this.editOnpress,
      this.deleteOnpress,
      this.showOn = false,
      this.print,
      super.key});

  String number;
  String barcode;
  String product;
  String color;
  String size;
  String type;
  String brand;
  String company;
  String quantity;
  bool heading;
  bool showOn;

  final VoidCallback? editOnpress;
  final VoidCallback? deleteOnpress;
  final VoidCallback? print;

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
          5: FlexColumnWidth(1.5),
          6: FlexColumnWidth(1.5),
          7: FlexColumnWidth(1.5),
          8: FlexColumnWidth(2),
          9: FlexColumnWidth(1),
          10: FlexColumnWidth(1),
          11: FlexColumnWidth(1),
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
              InkWell(
                onTap: (){
                  FlutterClipboard.copy(barcode).then((value){
                    Utils.SuccessToastMessage("Copied Barcode");
                  });
                },
                child: CustomTableCell(
                  text: barcode,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              CustomTableCell(
                text: product,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: company,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                text: brand,
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
                text: type,
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
                      text: "Print",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : InkWell(
                      onTap: print,
                      child: const CustomIcon(
                        icons: CupertinoIcons.printer,
                        color: Colors.black,
                      ),
                    ),
              showOn
                  ? SizedBox()
                  : heading
                      ? CustomTableCell(
                          text: "Edit",
                          textColor: heading ? Colors.white : Colors.black,
                          fontWeight:
                              heading ? FontWeight.bold : FontWeight.normal,
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
