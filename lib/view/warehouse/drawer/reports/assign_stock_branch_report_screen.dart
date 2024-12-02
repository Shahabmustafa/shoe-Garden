import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/view/warehouse/drawer/Assign%20stock/export/assign_stock_to_branch_export.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/Assign Stock/assign_branch_viewmodel.dart';
import '../../../Admin/drawer/asignstock/view_assign_stock.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class WAssignStockBranchReportScreen extends StatefulWidget {
  const WAssignStockBranchReportScreen({super.key});

  @override
  State<WAssignStockBranchReportScreen> createState() =>
      _WAssignStockBranchReportScreenState();
}

class _WAssignStockBranchReportScreenState
    extends State<WAssignStockBranchReportScreen> {
  Future<void> refresh() async {
    Get.put(WAssignStockBranchViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var controller = Get.put(WAssignStockBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to Branch Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse()) : Container(),
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
                    return Column(
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
                                  onTap: () =>
                                      AssignStockToBranchExport().printPdf(),
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
                              7: FlexColumnWidth(1.5),
                              8: FlexColumnWidth(1.5),
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
                                    text: 'Branch',
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
                            itemCount: controller.assignStockBranchList.value.body!.branchStocks!.length,
                            itemBuilder: (context, index) {
                              var assignStock = controller.assignStockBranchList.value.body!.branchStocks![index];
                              var name = assignStock.branch!.name.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(3),
                                      2: FlexColumnWidth(3),
                                      3: FlexColumnWidth(3),
                                      4: FlexColumnWidth(3),
                                      5: FlexColumnWidth(3),
                                      6: FlexColumnWidth(3),
                                      7: FlexColumnWidth(1.5),
                                      8: FlexColumnWidth(1.5),
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
                                            text: "${index + 1}",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: assignStock.branch != null ? assignStock.branch!.name : 'null',
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
                                            text: assignStock.size?.number.toString() ?? "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: assignStock.type?.name.toString() ?? "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: assignStock.quantity.toString() ?? "0",
                                            textColor: Colors.black,
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: assignStock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                              color: assignStock.status == 0 ? Colors.yellow : assignStock.status == 1 ? Colors.green : Colors.red,
                                            ),
                                          ),
                                          TableCell(
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewAssignStock(
                                                      title:
                                                      "Assign Stock To Branch",
                                                      barcode: assignStock.product == null ? "Null" : assignStock.product!.productCode.toString(),
                                                      productName: assignStock.product == null ? "Null" : assignStock.product!.name.toString(),
                                                      purchasePrice: assignStock.product == null ? "Null" : assignStock.product!.purchasePrice.toString(),
                                                      salePrice: assignStock.product == null ? "Null" : assignStock.product!.salePrice.toString(),
                                                      assignBy: assignStock.assignedBy == null ? "Null" : assignStock.assignedBy!.name.toString(),
                                                      name: assignStock.branch == null ? "Null" : assignStock.branch!.name.toString(),
                                                      brand: assignStock.brand == null ? "Null" : assignStock.brand!.name.toString(),
                                                      company: assignStock.company == null ? "Null" : assignStock.company!.name.toString(),
                                                      color: assignStock.color == null ? "Null" : assignStock.color!.name.toString(),
                                                      size: assignStock.size == null ? "Null" : assignStock.size!.number.toString(),
                                                      type: assignStock.type == null ? "Null" : assignStock.type!.name.toString(),
                                                      quantity: assignStock.quantity == null ? "Null" : assignStock.quantity!.toString(),
                                                      remaningQuantity: assignStock.remainingQuantity?.toString() ?? "",
                                                    );
                                                  },
                                                );
                                              },
                                              child: const CustomIcon(
                                                icons: Icons.visibility,
                                                color: Colors.green,
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
                          ),
                        ),
                      ],
                    );
                }
              })),
        ],
      ),
    );
  }
}
