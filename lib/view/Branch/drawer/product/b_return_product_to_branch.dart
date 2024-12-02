import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/product/export/return_product_to_branch_export.dart';
import 'package:sofi_shoes/view/Branch/drawer/product/widget/add_branch_product_return.dart';
import 'package:sofi_shoes/viewmodel/branch/product/return_product_to_branch_view_model.dart';

import '../../../../date/response/status.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Admin/drawer/asignstock/view_assign_stock.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class BReturnProductToBranch extends StatefulWidget {
  const BReturnProductToBranch({super.key});

  @override
  State<BReturnProductToBranch> createState() => _BReturnProductToBranchState();
}

class _BReturnProductToBranchState extends State<BReturnProductToBranch> {
  List<T> removeDuplicates<T>(List<T> list) {
    return LinkedHashSet<T>.from(list).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BReturnProductToBranchViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Stock to Branch"),
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
                          controller: controller.search.value,
                          labelText: "Search Branch",
                          search: true,
                          prefixIcon: Icon(Icons.search_rounded),
                          onChanged: (value) {
                            setState(() {
                              controller.searchValue.value = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            ReturnProductBranchExport().printReturnProductPdf();
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
                            text: 'Return To Branch',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Product',
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
                      // Get the list of return products
                        var returnProducts = controller.returnProductToBranchList.value.body!.returnProducts!;

                        // Filter products based on search input
                        var filteredProducts = returnProducts.where((data) {
                          return controller.search.value.text.isEmpty ||
                              (data.returnTo != null && data.returnTo!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                        }).toList();

                        // Check if filtered list is empty
                        if (filteredProducts.isEmpty) {
                          return NotFoundWidget(title: "Branch Not Found");
                        }

                        // If there are matching products, display them in a ListView
                        return ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final data = filteredProducts[index];
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
                                  color: Colors.grey.shade200,
                                ),
                                defaultColumnWidth: const FlexColumnWidth(0.5),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    children: [
                                      CustomTableCell(
                                        text: "${index + 1}",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.returnTo != null ? data.returnTo!.name.toString() : "null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product!.name.toString(),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.type == null ? "Null" : data.type!.name.toString(),
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
                                        text: data.quantity == null ? "Null" : data.quantity!.toString(),
                                        textColor: Colors.black,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ViewAssignStock(
                                                title: 'Return Product To Branch Detail',
                                                barcode: data.product == null ? "Null" : data.product!.productCode.toString(),
                                                productName: data.product == null ? "Null" : data.product!.name.toString(),
                                                purchasePrice: "",
                                                salePrice: data.product == null ? "Null" : data.product!.salePrice.toString(),
                                                assignBy: data.returnFrom == null ? "Null" : data.returnFrom!.name.toString(),
                                                name: data.returnTo == null ? "Null" : data.returnTo!.name.toString(),
                                                brand: data.brand == null ? "Null" : data.brand!.name.toString(),
                                                company: data.company == null ? "Null" : data.company!.name.toString(),
                                                color: data.color == null ? "Null" : data.color!.name.toString(),
                                                size: data.size == null ? "Null" : data.size!.number.toString(),
                                                type: data.type == null ? "Null" : data.type!.name.toString(),
                                                quantity: data.quantity == null ? "Null" : data.quantity!.toString(),
                                                remaningQuantity: "",
                                              );
                                            },
                                          );
                                        },
                                        child: CustomIcon(
                                          icons: Icons.visibility,
                                          color: Colors.green,
                                        ),
                                      ),
                                      CustomIcon(
                                        icons: data.status == 2 ? Icons.remove_circle : Icons.check_circle,
                                        color: data.status == 1 ? Colors.green : data.status == 0 ? Colors.yellow : Colors.red,
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
      floatingActionButton: const AddBranchProductReturn(),
    );
  }
}
