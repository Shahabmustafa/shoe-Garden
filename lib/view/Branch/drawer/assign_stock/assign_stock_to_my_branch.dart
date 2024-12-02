import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock%20position/view_branch_stock.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/utils/utils.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/branch/assign_stock/assign_stock_to_my_branch.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../stock position/export/assign_this_branch_export.dart';
import '../stock position/export/only_branch_stock_export.dart';

class AssignStockToMyBranchScreen extends StatefulWidget {
  const AssignStockToMyBranchScreen({super.key});

  @override
  State<AssignStockToMyBranchScreen> createState() => _AssignStockToMyBranchScreenState();
}

class _AssignStockToMyBranchScreenState extends State<AssignStockToMyBranchScreen> {
  TextEditingController search = TextEditingController();
  String searchValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(AssignStockToMyBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to this Branch"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
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
                        child: AppTextField(
                          labelText: "Search Name",
                          controller: search,
                          prefixIcon: Icon(Icons.search),
                          search: true,
                          onChanged: (value) {
                            setState(() {});
                            searchValue = value;
                          },
                        ),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            AssignThisBranchStockExport().printPdf();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: AppBoxes(
                            title: "Total Item Remaining Quantity",
                            amount: controller.AssignStockToMyBranchList.value.body?.sumOfQuantity.toString() ?? "0",
                            imageUrl: TImageUrl.imgProductT,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: AppBoxes(
                            title: "Total Item Sale Prices",
                            amount: controller.AssignStockToMyBranchList.value.body?.sumOfSalePrice.toString() ?? "0",
                            imageUrl: TImageUrl.imgsaleI,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
                            text: 'Assign By',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Products',
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
                            text: 'Quantiy',
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
                      // Get the list of stocks
                        var branchStocks = controller.AssignStockToMyBranchList.value.body!.branchStocks!;

                        // Filter stocks based on search input
                        var filteredStocks = branchStocks.where((data) {
                          return search.text.isEmpty ||
                              (data.product != null && data.product!.name!.toLowerCase().contains(search.text.trim().toLowerCase()));
                        }).toList();

                        // Check if filtered list is empty
                        if (filteredStocks.isEmpty) {
                          return NotFoundWidget(
                            title: "Product Not Found",
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredStocks.length,
                          itemBuilder: (context, index) {
                            var data = filteredStocks[index];
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
                                        text: '${index + 1}',
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.assignedBy == null ? "Null" : data.assignedBy!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product!.salePrice.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.color == null ? "Null" : data.color!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.type == null ? "Null" : data.type!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.size == null ? "Null" : data.size!.number.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.quantity == null ? "Null" : data.quantity.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomIcon(
                                        icons: data.approvedByBranch == 1 ? Icons.check_circle : Icons.remove_circle,
                                        color: data.approvedByBranch == 0 ? Colors.yellow :
                                        data.approvedByBranch == 1 ? Colors.green : Colors.red,
                                        onTap: () {
                                          data.approvedByBranch == 0 ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditDialog(
                                                title: "Do you want to Approve",
                                                accept: () {
                                                  controller.updateStatus('1', data.id.toString());
                                                  Get.back();
                                                },
                                                reject: () {
                                                  controller.updateStatus('2', data.id.toString());
                                                  Get.back();
                                                },
                                              );
                                            },
                                          ) : Utils.ErrorToastMessage('Do not change status');
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ViewBranchStock(
                                                title: 'Only My Branch Detail',
                                                assignBy: data.assignedBy == null ? "Null" : data.assignedBy!.name.toString(),
                                                barcode: data.barcode == null ? "Null" : data.barcode.toString(),
                                                product: data.product == null ? "Null" : data.product!.name.toString(),
                                                purchase: "",
                                                salePrice: data.product == null ? "Null" : data.product!.salePrice.toString(),
                                                brand: data.brand == null ? "Null" : data.brand!.name.toString(),
                                                company: data.company == null ? "Null" : data.company!.name.toString(),
                                                color: data.color == null ? "Null" : data.color!.name.toString(),
                                                size: data.size == null ? "Null" : data.size!.number.toString(),
                                                type: data.type == null ? "Null" : data.type!.name.toString(),
                                                quantity: data.quantity == null ? "Quantity Null" : data.quantity!.toString(),
                                              );
                                            },
                                          );
                                        },
                                        child: CustomIcon(
                                          icons: Icons.visibility,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
