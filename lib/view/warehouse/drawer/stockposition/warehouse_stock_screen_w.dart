import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../viewmodel/warehouse/Stock Position/my_warehouse_stock_view_model.dart';
import 'export/warehouse_stock_w_export.dart';

class WarehouseStockScreenWarehouse extends StatefulWidget {
  const WarehouseStockScreenWarehouse({super.key});

  @override
  State<WarehouseStockScreenWarehouse> createState() =>
      _WarehouseStockScreenWarehouseState();
}

class _WarehouseStockScreenWarehouseState extends State<WarehouseStockScreenWarehouse> {
  Future<void> refresh() async {
    Get.put(MyWarehouseStockViewModel()).refreshApi();
  }

  final controller = Get.put(MyWarehouseStockViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllWarehouseStock();
    controller.fetchWarehouse();
  }
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(MyWarehouseStockViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Different Warehouse Stock"),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppDropDown(
                                  labelText: "Select Warehouse",
                                  items: controller.dropdownItemsWarehouse.map<String>((item) => item['name'].toString()).toList(),
                                  onChanged: (branchName) {
                                    setState(() {});
                                    var selectbranch = controller.dropdownItemsWarehouse.firstWhere((items) =>
                                    items['name'].toString() == branchName,
                                      orElse: () => null,
                                    );
                                    if (selectbranch != null) {
                                      controller.selectWarehouse.value = selectbranch['id'].toString();
                                      controller.getSpecificWarehouseStock();
                                      if (kDebugMode) {
                                        print(selectbranch['id'].toString());
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print('Warehouse not found');
                                      }
                                    }
                                  },
                                ),
                              ),
                              Flexible(
                                child: AppExportButton(
                                  icons: Icons.add,
                                  onTap: () => WarehouseStockWExport().printPdf(),
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
                                  amount: controller.myWarehouseStockList.value.body?.sumOfQuantity.toString() ?? "0",
                                  imageUrl: TImageUrl.imgProductT,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Flexible(
                                child: AppBoxes(
                                  title: "Total Purchase",
                                  amount: controller.myWarehouseStockList.value.body?.sumOfPurchasePrice.toString() ?? "0",
                                  imageUrl: TImageUrl.imgPurchaseI,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Flexible(
                                child: AppBoxes(
                                  title: "Total Sale",
                                  amount: controller.myWarehouseStockList.value.body?.sumOfSalePrice.toString() ?? "0",
                                  imageUrl: TImageUrl.imgsaleI,
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
                              5: FlexColumnWidth(2),
                              6: FlexColumnWidth(1.5),
                              7: FlexColumnWidth(1.5),
                              8: FlexColumnWidth(1.5),
                              9: FlexColumnWidth(2),
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
                          child: controller.myWarehouseStockList.value.body!.warehouseStocks!.isNotEmpty ?
                          ListView.builder(
                            itemCount: controller.myWarehouseStockList.value.body!.warehouseStocks!.length,
                            itemBuilder: (context, index) {
                              var stock = controller.myWarehouseStockList.value.body!.warehouseStocks![index];
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
                                    6: FlexColumnWidth(1.5),
                                    7: FlexColumnWidth(1.5),
                                    8: FlexColumnWidth(1.5),
                                    9: FlexColumnWidth(2),
                                  },
                                  border: TableBorder.all(
                                    // borderRadius: BorderRadius.circular(5),
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
                                          text: stock.warehouse?.name ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.product?.name ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.product?.salePrice.toString() ?? '0',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.company?.name?.toString() ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.brand?.name?.toString() ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.color?.name ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.size?.number.toString() ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.type?.name.toString() ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                        CustomTableCell(
                                          text: stock.remainingQuantity?.toString() ?? 'Null',
                                          textColor: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ) :
                          NotFoundWidget(title: "This Warehouse Product Not Found"),
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
