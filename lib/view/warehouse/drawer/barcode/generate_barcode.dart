import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/viewmodel/warehouse/barcode/barcode_view_model.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class GenerateBarcodeScreen extends StatefulWidget {
  const GenerateBarcodeScreen({super.key});

  @override
  State<GenerateBarcodeScreen> createState() => _GenerateBarcodeScreenState();
}

class _GenerateBarcodeScreenState extends State<GenerateBarcodeScreen> {
  Future<void> refresh() async {
    Get.put(BarcodViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BarcodViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Barcode"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse())
              : Container(),
          Expanded(
              flex: 8,
              child: Obx(() {
                switch (controller.rxRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularIndicator.waveSpinkit);
                  case Status.ERROR:
                    if (controller.error.value == 'No internet') {
                      return InterNetExceptionWidget(onPress: () {
                        return controller.refreshApi();
                      });
                    } else {
                      return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshApi();
                          });
                    }
                  case Status.COMPLETE:
                    return RefreshIndicator(
                      onRefresh: refresh,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: AppTextField(
                                    controller: controller.search.value,
                                    labelText: "Search Barcode",
                                    search: true,
                                    prefixIcon: Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(4),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                color: Colors.grey.shade300,
                              ),
                              defaultColumnWidth: const FlexColumnWidth(0.5),
                              children: const [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Color(0xff13132a),
                                  ),
                                  children: [
                                    CustomTableCell(
                                      text: "#",
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Barcode',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Print',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Delete',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  controller.barcodeList.value.body!.length,
                              itemBuilder: (context, index) {
                                var stock =
                                    controller.barcodeList.value.body![index];
                                var name = stock.barcode!.toString();
                                if (controller.search.value.text.isEmpty ||
                                    name.toLowerCase().contains(controller
                                        .search.value.text
                                        .trim()
                                        .toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 2.5),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1),
                                      },
                                      border: TableBorder.all(
                                        color: Colors.grey.shade200,
                                      ),
                                      defaultColumnWidth:
                                          const FlexColumnWidth(0.5),
                                      children: [
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          children: [
                                            CustomTableCell(
                                              text: '${index + 1}',
                                              textColor: Colors.black,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: stock.barcode!,
                                                  ),
                                                ).then((value) {
                                                  Utils.SuccessToastMessage(
                                                      'Copy barcode');
                                                });
                                              },
                                              child: CustomTableCell(
                                                text: stock.barcode != null
                                                    ? stock.barcode.toString()
                                                    : '',
                                                textColor: Colors.black,
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    // controller.printBarcode(
                                                    //     context,
                                                    //     stock.barcode!);
                                                  },
                                                  child: CustomIcon(
                                                    icons: Icons.print,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return EditDialog(
                                                          reject: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          accept: () {
                                                            controller
                                                                .deleteBarcode(stock
                                                                    .id
                                                                    .toString());
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const CustomIcon(
                                                    icons:
                                                        CupertinoIcons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                }
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.generateBarcode();
        },
        label: const Text("Generate Bardcode"),
      ),
    );
  }
}
