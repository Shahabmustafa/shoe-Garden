import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/export/all_stock_of_different_branch_export.dart';
import 'package:sofi_shoes/viewmodel/admin/assignstock/all_stock_of_different_branches_viewmodel.dart';

import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../Admin/drawer/asignstock/view_assign_stock.dart';
import '../dashboard/dashboard_screen_a.dart';

class MApproveStockDifferentBranchScreen extends StatefulWidget {
  const MApproveStockDifferentBranchScreen({super.key});

  @override
  State<MApproveStockDifferentBranchScreen> createState() =>
      _MApproveStockDifferentBranchScreenState();
}

class _MApproveStockDifferentBranchScreenState
    extends State<MApproveStockDifferentBranchScreen> {
  Future<void> refresh() async {
    Get.put(AllStockOfBranchesViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var controller = Get.put(AllStockOfBranchesViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Stock Different Branchs"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetManager()) : Container(),
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
                        });
                  case Status.COMPLETE:
                    var filteredStocks = controller.assignStockBranchList.value.body!.branchStocks!.where((data) {
                      return controller.search.value.text.isEmpty || (data.branch != null && data.branch!.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
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
                                    prefixIcon: const Icon(Icons.search),
                                    search: true,
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () => AllStockOfDifferentBranchExport().printPdf(),
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
                                      text: "Assign to",
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
                            child: filteredStocks.isEmpty ?
                            NotFoundWidget(title: "Branch Not Found") :
                            ListView.builder(
                              itemCount: controller.assignStockBranchList.value.body!.branchStocks!.length,
                              itemBuilder: (context, index) {
                                var assignStock = controller.assignStockBranchList.value.body!.branchStocks![index];
                                var name = assignStock.branch != null ? assignStock.branch!.name.toString() : "null";
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
                                              text: assignStock.branch != null ? assignStock.branch!.name : "Null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.product != null ? assignStock.product!.name : "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.color?.name.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.size?.number.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.type?.name.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.quantity?.toString() ?? "null",
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: CustomIcon(
                                                icons: assignStock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                color: assignStock.status == 0 ? Colors.yellow : assignStock.status == 1 ? Colors.green : Colors.red,
                                                onTap: () {
                                                  assignStock.status == 0 ?
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return EditDialog(
                                                        title: "Do you want to Approve",
                                                        accept: () {
                                                          controller.updateStatus('1', assignStock.id.toString());
                                                          Get.back();
                                                        },
                                                        reject: () {
                                                          controller.updateStatus('2', assignStock.id.toString());
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                  ) :
                                                  Utils.ErrorToastMessage('do not change status');
                                                },
                                              ),
                                            ),
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewAssignStock(
                                                        title:
                                                        "Assign Stock Different Branch Detail",
                                                        barcode: assignStock.barcode != null ? assignStock.barcode.toString() : 'null',
                                                        productName: assignStock.product != null ? assignStock.product!.name.toString() : 'null',
                                                        purchasePrice: assignStock.product != null ? assignStock.product!.purchasePrice.toString() : 'null',
                                                        salePrice: assignStock.product != null ? assignStock.product!.salePrice.toString() : 'null',
                                                        company: assignStock.company != null ? assignStock.company!.name.toString() : 'null',
                                                        brand: assignStock.brand != null ? assignStock.brand!.name.toString() : 'null',
                                                        color: assignStock.color != null ? assignStock.color!.name.toString() : 'null',
                                                        size: assignStock.size != null ? assignStock.size!.number.toString() : 'null',
                                                        type: assignStock.type != null ? assignStock.type!.name.toString() : 'null',
                                                        quantity: assignStock.quantity != null ? assignStock.quantity!.toString() : 'null',
                                                        assignBy: assignStock.assignedBy != null ? assignStock.assignedBy!.name.toString() : 'null',
                                                        name: assignStock.branch != null ? assignStock.branch!.name.toString() : 'null',
                                                        remaningQuantity: assignStock.remainingQuantity?.toString() ?? "0",
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
                      ),
                    );
                }
              })),
        ],
      ),
    );
  }
}
