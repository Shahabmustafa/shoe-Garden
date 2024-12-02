import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/internet_execption_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock/export/assign_stock_to_other_branch_export.dart';
import 'package:sofi_shoes/viewmodel/branch/assign_stock/assign_stock_to_other_branch_view_model.dart';

import '../../../../date/response/status.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../stock/widget/view_assign_stock_to_other_branch.dart';

class BAssignStockToAnotherBranchReport extends StatefulWidget {
  const BAssignStockToAnotherBranchReport({super.key});

  @override
  State<BAssignStockToAnotherBranchReport> createState() =>
      _BAssignStockToAnotherBranchReportState();
}

class _BAssignStockToAnotherBranchReportState
    extends State<BAssignStockToAnotherBranchReport> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(AssignStockToOtherBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to Other Branch Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetBranch())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Obx(() {
                          print("Search text: ${controller.search.value.text}");
                          print(
                              "Search value: ${controller.searchValue.value}");
                          return AppTextField(
                            controller: controller.search.value, // Make sure this is the correct controller
                            labelText: "Search Name",
                            search: true,
                            prefixIcon: const Icon(Icons.search),
                            onChanged: (value) {
                              controller.searchValue.value = value;
                              setState(() {});
                            },
                          );
                        }),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            AssignStockToOtherBranchExport()
                                .printAssignStockPdf();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(2),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1),
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
                            text: 'Product',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Sale Price',
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
                            text: 'View',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Status',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: Obx(() {
                  switch (controller.rxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularIndicator.waveSpinkit);
                    case Status.ERROR:
                      if (controller.error.value == 'No internet') {
                        return InterNetExceptionWidget(onPress: () {
                          return controller.refreshApi();
                        });
                      } else {
                        return GeneralExceptionWidget(onPress: () {
                          controller.refreshApi();
                        });
                      }
                    case Status.COMPLETE:
                      return ListView.builder(
                        itemCount: controller.assignStockToOtherBranchList.value.body!.branchStocks!.length,
                        itemBuilder: (context, index) {
                          final data = controller.assignStockToOtherBranchList.value.body!.branchStocks![index];
                          var name = data.branch != null ? data.branch!.name.toString() : "Null";
                          if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
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
                                  7: FlexColumnWidth(2),
                                  8: FlexColumnWidth(1),
                                  9: FlexColumnWidth(1),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey.shade200,
                                ),
                                defaultColumnWidth: const FlexColumnWidth(0.5),
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
                                        text: data.branch != null ? data.branch!.name.toString() : "Branch is Empty",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product?.salePrice!.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.color == null ? "Null" : data.color!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.size == null ? "Null" : data.size!.number.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.type == null ? "Null" : data.type?.name!.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.quantity == null ? "Null" : data.quantity!.toString(),
                                        textColor: Colors.black,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ViewAssignStockToOtherBranch(
                                                branchName: data.branch != null ? data.branch!.name.toString() : "Branch is Empty",
                                                product: data.product == null ? "Null" : data.product!.name.toString(),
                                                brand: data.brand == null ? "Null" : data.brand!.name.toString(),
                                                company: data.company == null? "Null": data.company!.name.toString(),
                                                color: data.color == null? "Null": data.color!.name.toString(),
                                                size: data.size == null? "Null": data.size!.number.toString(),
                                                type: data.type == null? "Null": data.type!.name.toString(),
                                                quantity: data.quantity == null ? "Null" : data.quantity!.toString(),
                                                remainingquantity: data.remainingQuantity == null ? "Null" : data.remainingQuantity!.toString(),
                                              );
                                            },
                                          );
                                        },
                                        child: const CustomIcon(
                                          icons: Icons.visibility,
                                          color: Colors.green,
                                        ),
                                      ),
                                      CustomIcon(
                                          icons: data.status != 1
                                              ? CupertinoIcons
                                                  .clear_circled_solid
                                              : Icons.check_circle,
                                          color: data.status != 1
                                              ? Colors.red
                                              : Colors.green),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                  }
                })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
