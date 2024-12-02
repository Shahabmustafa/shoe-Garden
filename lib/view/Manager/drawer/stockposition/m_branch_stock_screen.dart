import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/stockposition/export/branch_stock_export.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';

class MBranchStockScreen extends StatefulWidget {
  const MBranchStockScreen({super.key});

  @override
  State<MBranchStockScreen> createState() => _MBranchStockScreenState();
}

class _MBranchStockScreenState extends State<MBranchStockScreen> {
  String selectBranch = "Select Branch";
  var controller = Get.put(AllBranchStockViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllBranchStock();
    controller.branchDropDown();
  }
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var controller = Get.put(AllBranchStockViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Stock"),
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
                      controller.refreshMyBranchStockApi();
                    },
                  );
                case Status.COMPLETE:
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Obx(() {
                                return AppDropDown(
                                  labelText: "Select Branch",
                                  selectedItem: selectBranch,
                                  items: controller.dropdownItemsBranch.value.map<String>((item) => item['name'].toString()).toList(),
                                  onChanged: (branchName) {
                                    var selectedBranch = controller.dropdownItemsBranch.value.firstWhere((item) => item['name'].toString() == branchName, orElse: () => null,);
                                    if (selectedBranch != null) {
                                      controller.selectBranch.value = selectedBranch['id'].toString();
                                      selectBranch = selectedBranch['name'].toString();
                                      controller.getSpecificBranchStock();
                                      if (kDebugMode) {
                                        print(selectedBranch['id'].toString());
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print('Warehouse not found');
                                      }
                                    }
                                  },
                                );
                              }),
                            ),
                            Flexible(
                              child: AppExportButton(
                                icons: Icons.add,
                                onTap: () => BranchStockExport().printPdf(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.selectBranch.value.isEmpty ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: AppBoxes(
                                title: "Total Quantity",
                                amount: controller.branchStockList.value.body?.sumOfQuantity.toString() ?? "0",
                                imageUrl: TImageUrl.imgProductT,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Purchase",
                                amount: controller.branchStockList.value.body?.sumOfPurchasePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgPurchaseI,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Sale",
                                amount: controller.myBranchStockList.value.body?.sumOfSalePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgsaleI,
                              ),
                            ),
                          ],
                        ),
                      ) :
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: AppBoxes(
                                title: "Total Quantity",
                                amount: controller.specificBranchStock.value.body?.sumOfQuantity.toString() ?? "0",
                                imageUrl: TImageUrl.imgProductT,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Purchase",
                                amount: controller.specificBranchStock.value.body?.sumOfPurchasePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgPurchaseI,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Sale",
                                amount: controller.myBranchStockList.value.body?.sumOfSalePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgsaleI,
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
                            7: FlexColumnWidth(2),
                            8: FlexColumnWidth(2),
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
                                  text: 'Company',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Brand',
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
                                  text: 'Re.Quantity',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.selectBranch.value.isEmpty ?
                        ListView.builder(
                          itemCount: controller.branchStockList.value.body!.branchStocks!.length,
                          itemBuilder: (context, index) {
                            var branchStock = controller.branchStockList.value.body!.branchStocks![index];
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
                                        text: branchStock.branch?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.product?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.company?.name?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.brand?.name?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.color?.name ?? "Null" ,
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.size?.number.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.type?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.remainingQuantity?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ) :
                        controller.specificBranchStock.value.body!.branchStock!.isEmpty ?
                        NotFoundWidget(title: "Product Not Found") :
                        ListView.builder(
                          itemCount: controller.specificBranchStock.value.body!.branchStock!.length,
                          itemBuilder: (context, index) {
                            var branchStock = controller.specificBranchStock.value.body!.branchStock![index];
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
                                        text: branchStock.branch?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.product?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.company?.name?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.brand?.name?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.color?.name ?? "Null" ,
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.size?.number.toString() ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.type?.name ?? "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: branchStock.remainingQuantity?.toString() ?? "null",
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
