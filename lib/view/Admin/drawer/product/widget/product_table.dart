import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../res/circularindictor/circularindicator.dart';
import '../../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class ProductTable extends StatelessWidget {
  ProductTable(
      {required this.index,
      required this.image,
      required this.productName,
      required this.salePrice,
      required this.purchasePrice,
      this.heading = false,
      super.key,
      this.editOnpress,
      this.deleteOnpress});
  String index;
  String image;
  String productName;
  String salePrice;
  String purchasePrice;
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
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
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
              Container(
                height: heading ? 40 : 100,
                width: heading ? 100 : 150,
                child: CustomTableCell(
                  text: index,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ), heading ?
              CustomTableCell(
                      text: "image",
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    ) :
              Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 100,
                            width: 150,
                            fit: BoxFit.cover,
                            imageUrl: image,
                            placeholder: (context, url) => const Center(
                              child: CircularIndicator.waveSpinkit,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
              Container(
                height: heading ? 40 : 100,
                width: heading ? 100 : 150,
                child: CustomTableCell(
                  text: productName,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Container(
                height: heading ? 40 : 100,
                width: heading ? 100 : 150,
                child: CustomTableCell(
                  text: purchasePrice,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Container(
                height: heading ? 40 : 100,
                width: heading ? 100 : 150,
                child: CustomTableCell(
                  text: salePrice,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              heading
                  ? Container(
                      height: heading ? 40 : 100,
                      width: heading ? 100 : 150,
                      child: CustomTableCell(
                        text: "Edit",
                        textColor: heading ? Colors.white : Colors.black,
                        fontWeight:
                            heading ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  : InkWell(
                      onTap: editOnpress,
                      child: Container(
                        height: heading ? 40 : 100,
                        width: heading ? 100 : 150,
                        child: const CustomIcon(
                          icons: CupertinoIcons.eyedropper_full,
                          color: Colors.blue,
                        ),
                      ),
                    ),
              heading
                  ? InkWell(
                      onTap: deleteOnpress,
                      child: Container(
                        height: heading ? 40 : 100,
                        width: heading ? 100 : 150,
                        child: CustomTableCell(
                          text: "Delete",
                          textColor: heading ? Colors.white : Colors.black,
                          fontWeight:
                              heading ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: deleteOnpress,
                      child: Container(
                        height: heading ? 40 : 100,
                        width: heading ? 100 : 150,
                        child: const CustomIcon(
                          icons: CupertinoIcons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;

  const CustomTableCell({
    required this.text,
    required this.textColor,
    required this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center, // Center the content within the cell
      child: Text(
        text,
        textAlign: TextAlign.center, // Center the text horizontally
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
