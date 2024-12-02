import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';

import '../../tabletext/table_text.dart';

class DashboardTable extends StatelessWidget {
  DashboardTable(
      {required this.number,
      required this.artical,
      required this.image,
      required this.category,
      required this.company,
      required this.brand,
      required this.count,
      this.heading = false,
      super.key});

  String number;
  String artical;
  String image;
  String category;
  String company;
  String brand;
  String count;
  bool heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(2),
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
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                text: artical,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              heading
                  ? CustomTableCell(
                      width: heading ? 40 : 200,
                      height: heading ? 40 : 100,
                      text: image,
                      textColor: heading ? Colors.white : Colors.black,
                      fontWeight: heading ? FontWeight.bold : FontWeight.normal,
                    )
                  : Container(
                      width: heading ? 40 : 200,
                      height: heading ? 40 : 100,
                      child: Center(
                        child: CachedNetworkImage(
                          height: 60,
                          width: 130,
                          fit: BoxFit.cover,
                          imageUrl: image,
                          placeholder: (context, url) =>
                              Center(child: CircularIndicator.squareCircle),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
              CustomTableCell(
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                text: category,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                text: company,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                text: brand,
                textColor: heading ? Colors.white : Colors.black,
                fontWeight: heading ? FontWeight.bold : FontWeight.normal,
              ),
              CustomTableCell(
                width: heading ? 40 : 200,
                height: heading ? 40 : 100,
                text: count,
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
