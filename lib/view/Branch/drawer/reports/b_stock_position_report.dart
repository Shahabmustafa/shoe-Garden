import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock%20position/export/all_branch_stock_export.dart';
import 'package:sofi_shoes/viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../stock position/view_branch_stock.dart';

class BStockPositionReport extends StatefulWidget {
  const BStockPositionReport({super.key});

  @override
  State<BStockPositionReport> createState() => _BStockPositionReportState();
}

class _BStockPositionReportState extends State<BStockPositionReport> {

  final controller = Get.put(AllBranchStockViewModel());

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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Branch Stock inventory Report"),
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
                                  items: controller.dropdownItemsBranch.map<String>((item) => item['name'].toString()).toList(),
                                  onChanged: (branchName) {
                                    setState(() {});
                                    var selectbranch = controller.dropdownItemsBranch.firstWhere((items) => items['name'].toString() == branchName, orElse: () => null,);
                                    if (selectbranch != null) {
                                      controller.selectBranch.value = selectbranch['id'].toString();
                                      controller.getBranchById(controller.selectBranch.value);
                                      if (kDebugMode) {
                                        print(selectbranch['id'].toString());
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print('Branch not found');
                                      }
                                    }
                                  },
                                );
                              }),
                            ),
                            Flexible(
                              child: AppExportButton(
                                icons: Icons.add,
                                onTap: () {
                                  AllBranchStockExport().printPdf();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: AppBoxes(
                                title: "Total Remaining Quantity",
                                amount: controller.branchStockList.value.body?.sumOfQuantity.toString() ?? "0",
                                imageUrl: TImageUrl.imgProductT,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Purchase Prices",
                                amount: controller.branchStockList.value.body?.sumOfPurchasePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgPurchaseI,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: AppBoxes(
                                title: "Total Sale Prices",
                                amount: controller.branchStockList.value.body?.sumOfSalePrice.toString() ?? "0",
                                imageUrl: TImageUrl.imgSale,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(3),
                            2: FlexColumnWidth(3),
                            3: FlexColumnWidth(3),
                            4: FlexColumnWidth(3),
                            5: FlexColumnWidth(3),
                            6: FlexColumnWidth(1),
                            7: FlexColumnWidth(1),
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
                                  text: 'Branch Name',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Product',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Remaining Quantity',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Total Purchase',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTableCell(
                                  text: 'Total Sale',
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
                        child: controller.selectBranch.value.isEmpty ?
                        ListView.builder(
                            itemCount: controller.branchStockList.value.body!.branchStocks!.length,
                            itemBuilder: (context, index) {
                              var branchStock = controller.branchStockList.value.body!.branchStocks![index];
                              if (controller.selectBranch.value.isEmpty || branchStock.branchId.toString().toLowerCase().contains(controller.selectBranch.value.toLowerCase())) {
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
                                      6: FlexColumnWidth(1),
                                      7: FlexColumnWidth(1),
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
                                            text: branchStock.branch != null ? branchStock.branch!.name.toString() : "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchStock.product != null ? branchStock.product!.name.toString() : "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchStock.remainingQuantity != null ? branchStock.remainingQuantity!.toString() : "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchStock.totalPurchasePrice != null ? branchStock.totalPurchasePrice!.toString() : "Null",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: branchStock.totalSalePrice != null ? branchStock.totalSalePrice!.toString() : "Null",
                                            textColor: Colors.black,
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: branchStock.status.toString() != "1" ? Icons.remove_circle : Icons.check_circle,
                                              color: branchStock.status.toString() != "1" ? Colors.red : Colors.green,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ViewBranchStock(
                                                    title: 'All Branch Stock Detail',
                                                    assignBy: branchStock.assignedBy == null ? "Null" : branchStock.assignedBy!.name.toString(),
                                                    barcode: branchStock.barcode == null ? "Null" : branchStock.barcode.toString(),
                                                    product: branchStock.product == null ? "Null" : branchStock.product!.name.toString(),
                                                    purchase: branchStock.product == null ? "Null" : branchStock.product!.purchasePrice.toString(),
                                                    salePrice: branchStock.product == null ? "Null" : branchStock.product!.salePrice.toString(),
                                                    brand: branchStock.brand == null ? "Null" : branchStock.brand!.name.toString(),
                                                    company: branchStock.company == null ? "Null" : branchStock.company!.name.toString(),
                                                    color: branchStock.color == null ? "Null" : branchStock.color!.name.toString(),
                                                    size: branchStock.size == null ? "Null" : branchStock.size!.number.toString(),
                                                    type: branchStock.type == null ? "Null" : branchStock.type!.name.toString(),
                                                    quantity: branchStock.quantity == null ? "Null" : branchStock.quantity!.toString(),
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
                              } else {
                                return Container();
                              }
                            }) :
                        ListView.builder(
                            itemCount: controller.specificBranchStock.value.body!.branchStock!.length,
                            itemBuilder: (context, index) {
                              var branchStock = controller.specificBranchStock.value.body!.branchStock![index];
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
                                    6: FlexColumnWidth(1),
                                    7: FlexColumnWidth(1),
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
                                          text: branchStock.branch != null ? branchStock.branch!.name.toString() : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: branchStock.product != null ? branchStock.product!.name.toString() : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: branchStock.remainingQuantity != null ? branchStock.remainingQuantity!.toString() : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: branchStock.totalPurchasePrice != null ? branchStock.totalPurchasePrice!.toString() : "Null",
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: branchStock.totalSalePrice != null ? branchStock.totalSalePrice!.toString() : "Null",
                                          textColor: Colors.black,
                                        ),
                                        TableCell(
                                          child: CustomIcon(
                                            icons: branchStock.status.toString() != "1" ? Icons.remove_circle : Icons.check_circle,
                                            color: branchStock.status.toString() != "1" ? Colors.red : Colors.green,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ViewBranchStock(
                                                  title: 'All Branch Stock Detail',
                                                  assignBy: branchStock.assignedBy == null ? "Null" : branchStock.assignedBy!.name.toString(),
                                                  barcode: branchStock.barcode == null ? "Null" : branchStock.barcode.toString(),
                                                  product: branchStock.product == null ? "Null" : branchStock.product!.name.toString(),
                                                  purchase: branchStock.product == null ? "Null" : branchStock.product!.purchasePrice.toString(),
                                                  salePrice: branchStock.product == null ? "Null" : branchStock.product!.salePrice.toString(),
                                                  brand: branchStock.brand == null ? "Null" : branchStock.brand!.name.toString(),
                                                  company: branchStock.company == null ? "Null" : branchStock.company!.name.toString(),
                                                  color: branchStock.color == null ? "Null" : branchStock.color!.name.toString(),
                                                  size: branchStock.size == null ? "Null" : branchStock.size!.number.toString(),
                                                  type: branchStock.type == null ? "Null" : branchStock.type!.name.toString(),
                                                  quantity: branchStock.quantity == null ? "Null" : branchStock.quantity!.toString(),
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
                            }),

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
