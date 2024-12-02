import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/export/asign_stock_to_warehouse_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/view_assign_stock.dart';
import 'package:sofi_shoes/viewmodel/admin/assignstock/assignstock_warehouse_viewmodel.dart';

import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class AdminAssignStockWarehouseReport extends StatefulWidget {
  const AdminAssignStockWarehouseReport({super.key});

  @override
  State<AdminAssignStockWarehouseReport> createState() =>
      _AdminAssignStockWarehouseReportState();
}

class _AdminAssignStockWarehouseReportState
    extends State<AdminAssignStockWarehouseReport> {
  Future<void> refresh() async {
    Get.put(AssignStockWarehouseViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var controller = Get.put(AssignStockWarehouseViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock Warehouse Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetAdmin())
              : Container(),
          Expanded(
              flex: 8,
              child: Obx(() {
                switch (controller.rxRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularIndicator.waveSpinkit);
                  case Status.ERROR:
                    return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      },
                    );
                  case Status.COMPLETE:
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
                                    labelText: "Search Warehouse",
                                    search: true,
                                    prefixIcon: Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () => AsignStockToWarehouseExport()
                                        .printPdf(),
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
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(3),
                                4: FlexColumnWidth(3),
                                5: FlexColumnWidth(3),
                                6: FlexColumnWidth(3),
                                7: FlexColumnWidth(2),
                                8: FlexColumnWidth(2),
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
                                      text: 'Warehouse',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Products',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Color',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Size',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Type',
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
                            child: ListView.builder(
                              itemCount: controller.assignStockWaresHouseList.value.body!.warehouseStocks!.length,
                              itemBuilder: (context, index) {
                                var assignStock = controller.assignStockWaresHouseList.value.body!.warehouseStocks![index];
                                var name = assignStock.warehouse != null ? assignStock.warehouse!.name : 'NUll';
                                if (controller.search.value.text.isEmpty ||
                                    name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 2.5),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(3),
                                        2: FlexColumnWidth(3),
                                        3: FlexColumnWidth(3),
                                        4: FlexColumnWidth(3),
                                        5: FlexColumnWidth(3),
                                        6: FlexColumnWidth(3),
                                        7: FlexColumnWidth(2),
                                        8: FlexColumnWidth(2),
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
                                              text: "${index + 1}",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.warehouse != null ? assignStock.warehouse!.name : "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.product != null ? assignStock.product!.name : 'Null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.color?.name.toString() ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.size?.number?.toString() ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.type?.name?.toString() ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.quantity?.toString() ?? "Null",
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: Icon(
                                                assignStock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                color: assignStock.status == 0 ? Colors.yellow : assignStock.status == 1 ? Colors.green : Colors.red,
                                                size: 16,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewAssignStock(
                                                      title:
                                                          "Assign Stock to Warehouse Detail",
                                                      barcode: assignStock
                                                                  .barcode !=
                                                              null
                                                          ? assignStock.barcode!
                                                              .toString()
                                                          : 'null',
                                                      productName:
                                                          assignStock.product !=
                                                                  null
                                                              ? assignStock
                                                                  .product!.name
                                                                  .toString()
                                                              : 'null',
                                                      purchasePrice:
                                                          assignStock.product !=
                                                                  null
                                                              ? assignStock
                                                                  .product!
                                                                  .purchasePrice
                                                                  .toString()
                                                              : 'null',
                                                      salePrice:
                                                          assignStock.product !=
                                                                  null
                                                              ? assignStock
                                                                  .product!
                                                                  .salePrice
                                                                  .toString()
                                                              : 'null',
                                                      company:
                                                          assignStock.company !=
                                                                  null
                                                              ? assignStock
                                                                  .company!.name
                                                                  .toString()
                                                              : 'null',
                                                      brand:
                                                          assignStock.brand !=
                                                                  null
                                                              ? assignStock
                                                                  .brand!.name
                                                                  .toString()
                                                              : 'null',
                                                      color:
                                                          assignStock.color !=
                                                                  null
                                                              ? assignStock
                                                                  .color!.name
                                                                  .toString()
                                                              : 'null',
                                                      size:
                                                          assignStock.product !=
                                                                  null
                                                              ? assignStock
                                                                  .size!.number
                                                                  .toString()
                                                              : 'null',
                                                      type: assignStock.type !=
                                                              null
                                                          ? assignStock
                                                              .type!.name
                                                              .toString()
                                                          : 'null',
                                                      quantity: assignStock
                                                                  .quantity !=
                                                              null
                                                          ? assignStock.quantity
                                                              .toString()
                                                          : 'null',
                                                      assignBy: assignStock
                                                                  .assignedBy !=
                                                              null
                                                          ? assignStock
                                                              .assignedBy!.name
                                                              .toString()
                                                          : 'null',
                                                      name: assignStock
                                                                  .warehouse !=
                                                              null
                                                          ? assignStock
                                                              .warehouse!.name
                                                              .toString()
                                                          : 'null',
                                                      remaningQuantity: assignStock
                                                              .remainingQuantity
                                                              .toString() ??
                                                          "",
                                                    );
                                                  },
                                                );
                                              },
                                              child: const CustomIcon(
                                                icons: Icons.visibility,
                                                color: Colors.green,
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
