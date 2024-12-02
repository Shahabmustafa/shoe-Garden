import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/viewmodel/warehouse/Assign%20Stock/returned_stock_from_branch_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Branch/drawer/product/widget/view_return_stock.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/returned_stock_from_branch_export.dart';

class WReturnedStockFromBranch extends StatefulWidget {
  const WReturnedStockFromBranch({super.key});

  @override
  State<WReturnedStockFromBranch> createState() =>
      _WReturnedStockFromBranchState();
}

class _WReturnedStockFromBranchState extends State<WReturnedStockFromBranch> {
  String? selectType = 'Select Type';
  Future<void> refresh() async {
    Get.put(WReturnedStockFromBranchViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WReturnedStockFromBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Stock From Branch"),
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
                    final filteredProducts = controller.returnedStockList.value.body!.returnProducts!.where((product) {
                      return controller.search.value.text.isEmpty || product.returnFrom!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                    }).toList();
                    return RefreshIndicator(
                      onRefresh: refresh,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: AppTextField(
                                    controller: controller.search.value,
                                    labelText: "Search Branch",
                                    search: true,
                                    prefixIcon: const Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () => ReturnedStockFromBranchExport()
                                        .printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                                5: FlexColumnWidth(2),
                                6: FlexColumnWidth(2),
                                7: FlexColumnWidth(1),
                                8: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                // borderRadius: BorderRadius.circular(5),
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
                                      text: "Return Form",
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Product Name',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Color',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Type',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Size',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Quantity',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Status',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'View',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: controller.returnedStockList.value.body!.returnProducts!.isNotEmpty ?
                            filteredProducts.isEmpty ?
                            NotFoundWidget(title: "Branch Not found") :
                            ListView.builder(
                              itemCount: controller.returnedStockList.value.body!.returnProducts!.length,
                              itemBuilder: (context, index) {
                                var stock = controller.returnedStockList.value.body!.returnProducts![index];
                                var name = stock.returnFrom != null ? stock.returnFrom!.name.toString() : "";
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(2),
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                        6: FlexColumnWidth(2),
                                        7: FlexColumnWidth(1),
                                        8: FlexColumnWidth(1),
                                      },
                                      border: TableBorder.all(
                                        // borderRadius: BorderRadius.circular(5),
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
                                            CustomTableCell(
                                              text: stock.returnFrom != null ? stock.returnFrom!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.product != null ? stock.product!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.color != null ? stock.color!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.type != null ? stock.type!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.size != null ? stock.size!.number.toString() : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: stock.quantity != null ? stock.quantity.toString() : 'null',
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: InkWell(
                                                child: CustomIcon(
                                                  icons: stock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                  color: stock.status == 0 ? Colors.yellow : stock.status == 1 ? Colors.green : Colors.red,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewReturnProduct(
                                                        title:
                                                            'Return Product From Branch Detail',
                                                        assignBy:
                                                            stock.returnFrom ==
                                                                    null
                                                                ? "Null"
                                                                : stock
                                                                    .returnFrom!
                                                                    .name
                                                                    .toString(),
                                                        product:
                                                            stock.product ==
                                                                    null
                                                                ? " Null"
                                                                : stock.product!
                                                                    .name
                                                                    .toString(),
                                                        brand: stock.brand ==
                                                                null
                                                            ? "Null"
                                                            : stock.brand!.name
                                                                .toString(),
                                                        company:
                                                            stock.company ==
                                                                    null
                                                                ? "Null"
                                                                : stock.company!
                                                                    .name
                                                                    .toString(),
                                                        color: stock.color ==
                                                                null
                                                            ? "Null"
                                                            : stock.color!.name
                                                                .toString(),
                                                        size: stock.size == null
                                                            ? "Null"
                                                            : stock.size!.number
                                                                .toString(),
                                                        type: stock.type == null
                                                            ? "Null"
                                                            : stock.type!.name
                                                                .toString(),
                                                        quantity: stock
                                                                    .quantity ==
                                                                null
                                                            ? "Null"
                                                            : stock.quantity!
                                                                .toString(),
                                                        description:
                                                            stock.description ==
                                                                    null
                                                                ? "Null"
                                                                : stock
                                                                    .description!
                                                                    .toString(),
                                                        date: stock.date == null
                                                            ? "Null"
                                                            : stock.date!
                                                                .toString(),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.visibility,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ) :
                            Center(
                              child: Text(
                                "Return Stock from Branch is Empty",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }
              })),
        ],
      ),
    );
  }
}
