import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/utils/utils.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/Stock Position/wadmin_stock_viewmodel.dart';
import '../../../Branch/drawer/stock position/view_branch_stock.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../stockposition/export/admin_stock_w_export.dart';

class WAssignStockToMyWarehouse extends StatefulWidget {
  const WAssignStockToMyWarehouse({super.key});

  @override
  State<WAssignStockToMyWarehouse> createState() =>
      _WAssignStockToMyWarehouseState();
}

class _WAssignStockToMyWarehouseState
    extends State<WAssignStockToMyWarehouse> {
  Future<void> refresh() async {
    Get.put(WAdminStockViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WAdminStockViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to this Warehouse"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetWarehouse(),) : null,
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
                  return GeneralExceptionWidget(
                    errorMessage: controller.error.value.toString(),
                    onPress: () {
                      controller.refreshApi();
                      },
                  );
                case Status.COMPLETE:
                  final filteredProducts = controller.stockList.value.body!.warehouseStocks!.where((product) {
                    return controller.search.value.text.isEmpty || product.product!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                  }).toList();
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Product",
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
                                  onTap: () => AdminStockWExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Row(
                            children: [
                              // Flexible(
                              //   child: AppBoxes(
                              //     title: "Total Remaining Quantity",
                              //     amount: controller.stockList.value.body?.sumOfQuantity.toString() ?? "0",
                              //     imageUrl: TImageUrl.imgProductT,
                              //   ),
                              // ),
                              // SizedBox(width: 20,),
                              Flexible(
                                child: AppBoxes(
                                  title: "Total Purchase Prices",
                                  amount: controller.stockList.value.body?.sumOfPurchasePrice.toString() ?? "0",
                                  imageUrl: TImageUrl.imgPurchaseI,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Flexible(
                                child: AppBoxes(
                                  title: "Total Sale Prices",
                                  amount: controller.stockList.value.body?.sumOfSalePrice.toString() ?? "0",
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
                          child: filteredProducts.isEmpty ?
                          NotFoundWidget(title: "Product Not Found") :
                          ListView.builder(
                            itemCount: controller.stockList.value.body!.warehouseStocks!.length,
                            itemBuilder: (context, index) {
                              var stock = controller.stockList.value.body!.warehouseStocks![index];
                              if (controller.search.value.text.isEmpty || stock.product!.name.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
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
                                            text: stock.product != null ? stock.product!.name : 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stock.color != null ? stock.color!.name : 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stock.size != null ? stock.size!.number.toString() : 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stock.type?.name?.toString() ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stock.quantity?.toString() ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomIcon(
                                            icons: stock.approvedByWarehouse == 1 ? Icons.check_circle : Icons.remove_circle,
                                            color: stock.approvedByWarehouse == 0 ? Colors.yellow :
                                            stock.approvedByWarehouse == 1 ? Colors.green : Colors.red,
                                            onTap: (){
                                              stock.approvedByWarehouse == 0 ? showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return EditDialog(
                                                    title: "Do you want to Approve",
                                                    accept: () {
                                                      controller.updateStatus('1', stock.id.toString());
                                                      Get.back();
                                                    },
                                                    reject: () {
                                                      controller.updateStatus('2', stock.id.toString());
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ) : Utils.ErrorToastMessage('do not change status');
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ViewBranchStock(
                                                    title: 'Admin Stock Detail',
                                                    assignBy: stock.assignedBy == null ? "Null" : stock.assignedBy!.name.toString(),
                                                    product: stock.product == null ? "Null" : stock.product!.name.toString(),
                                                    brand: stock.brand == null ? "Null" : stock.brand!.name.toString(),
                                                    company: stock.company == null ? "Null" : stock.company!.name.toString(),
                                                    color: stock.color == null ? "Null" : stock.color!.name.toString(),
                                                    size: stock.size == null ? "Null" : stock.size!.number.toString(),
                                                    type: stock.type == null ? "Null" : stock.type!.name.toString(),
                                                    quantity: stock.quantity == null ? "Null" : stock.quantity!.toString(),
                                                    barcode: stock.barcode != null ? stock.barcode.toString() : "Null",
                                                    purchase: stock.product != null ? stock.product!.purchasePrice.toString() : "Null",
                                                    salePrice: stock.product != null ? stock.product!.salePrice.toString() : "Null",
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
            }),
          ),
        ],
      ),
    );
  }
}
