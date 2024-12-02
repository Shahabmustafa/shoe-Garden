import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/export/stock_export.dart';
import 'package:sofi_shoes/viewmodel/admin/product/stock_inventory_viewmodel.dart';

import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../product/widget/view_stock_inventory.dart';

class AdminStockInventoryReport extends StatefulWidget {
  const AdminStockInventoryReport({super.key});

  @override
  State<AdminStockInventoryReport> createState() =>
      _AdminStockInventoryReportState();
}

class _AdminStockInventoryReportState extends State<AdminStockInventoryReport> {
  Future<void> refreshCustomerList() async {
    Get.put(StockInventoryViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(StockInventoryViewModel()).getAllStockInventory();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockInventoryViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Inventory Report"),
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
                        });
                  case Status.COMPLETE:
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search?.value ?? TextEditingController(),
                                  labelText: "Search Product",
                                  prefixIcon: Icon(Icons.search),
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
                                  onTap: () => StockExport().printPdf(),
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
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(1),
                              6: FlexColumnWidth(1),
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
                                    text: 'Product Name',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Size',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Color',
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
                                    text: 'print',
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
                            itemCount: controller.stockInventoryList.value.body!.productStock?.length ?? 0,
                            itemBuilder: (context, index) {
                              var stockInventory = controller.stockInventoryList.value.body!.productStock![index];
                              var name = stockInventory.product?.name ?? '';
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(2),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(2),
                                      4: FlexColumnWidth(2),
                                      5: FlexColumnWidth(1),
                                      6: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                      color: Colors.grey.shade300,
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
                                            text: stockInventory.product?.name ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stockInventory.color?.name ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stockInventory.size?.number.toString() ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: stockInventory.quantity?.toString() ?? 'null',
                                            textColor: Colors.black,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ViewStockInventory(
                                                    title: "Stock Inventory Detail",
                                                    barcode: stockInventory.barcode?.toString() ?? "Null",
                                                    productName: stockInventory.product?.name ?? "Null",
                                                    purchasePrice: stockInventory.product?.purchasePrice?.toString() ?? "Null",
                                                    salePrice: stockInventory.product?.salePrice?.toString() ?? "Null",
                                                    brand: stockInventory.brand?.name ?? "Null",
                                                    company: stockInventory.company?.name ?? "Null",
                                                    color: stockInventory.color?.name ?? "Null",
                                                    size: stockInventory.size?.number?.toString() ?? "Null",
                                                    type: stockInventory.type?.name ?? "Null",
                                                    quantity: stockInventory.quantity?.toString() ?? "Null",
                                                    remquantity: stockInventory.remainingQuantity?.toString() ?? "Null",
                                                  );
                                                },
                                              );
                                            },
                                            child: const CustomIcon(
                                              icons: Icons.visibility,
                                              color: Colors.green,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.printBarcode(
                                                context,
                                                stockInventory.barcode,
                                                stockInventory.product?.name,
                                                stockInventory.color?.name,
                                                stockInventory.size?.number.toString(),
                                              );
                                            },
                                            child: const CustomIcon(
                                              icons: Icons.print,
                                              color: Colors.black,
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
