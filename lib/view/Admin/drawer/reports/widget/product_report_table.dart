import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../res/circularindictor/circularindicator.dart';
import '../../../../../res/tabletext/table_text.dart';

class ProductReportTable extends StatelessWidget {
  ProductReportTable(
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
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(1),
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
              Container(
                height: heading ? 40 : 100,
                width: heading ? 100 : 150,
                child: CustomTableCell(
                  text: index,
                  textColor: heading ? Colors.white : Colors.black,
                  fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              heading ?
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
            ],
          ),
        ],
      ),
    );
  }
}
