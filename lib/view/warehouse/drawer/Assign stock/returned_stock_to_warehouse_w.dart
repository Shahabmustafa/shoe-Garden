import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/Assign Stock/returned_stock_to_another_warehouse_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/returned_stock_to_warehouse_export.dart';

class WReturnStockToAnotherWarehouseScreen extends StatefulWidget {
  const WReturnStockToAnotherWarehouseScreen({super.key});

  @override
  State<WReturnStockToAnotherWarehouseScreen> createState() =>
      _WReturnStockToAnotherWarehouseScreenState();
}

class _WReturnStockToAnotherWarehouseScreenState
    extends State<WReturnStockToAnotherWarehouseScreen> {
  String? selectType = 'Select Type';
  Future<void> refresh() async {
    Get.put(WReturnedStockToAnotherWarehouseViewModle()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WReturnedStockToAnotherWarehouseViewModle());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Stock To another Warehouse"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetWarehouse())
              : Container(),
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
                    final filteredProducts = controller.stockList.value.body!.returnProducts!
                        .where((product) {
                      return controller.search.value.text.isEmpty ||
                          product.product!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
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
                                    labelText: "Search Product",
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
                                    onTap: () => ReturnedStockToWarehouseExport().printPdf(),
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
                                6: FlexColumnWidth(2),
                                7: FlexColumnWidth(2),
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
                                      text: 'Article',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Brand',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Type',
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
                                      text: 'Quantity',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Description',
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
                            child: controller.stockList.value.body!.returnProducts!.isNotEmpty ?
                            filteredProducts.isEmpty ?
                             NotFoundWidget(title: "Product Not Found") :
                            ListView.builder(
                              itemCount: controller.stockList.value.body!.returnProducts!.length,
                              itemBuilder: (context, index) {
                                var stock = controller.stockList.value.body!.returnProducts![index];
                                var name = stock.product!.name.toString();
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
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
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.product != null
                                                    ? stock.product!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.brand != null ? stock.brand!.name : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.type != null ? stock.type!.name : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.color != null
                                                    ? stock.color!.name
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.size != null
                                                    ? stock.size!.number
                                                        .toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.quantity != null
                                                    ? stock.quantity.toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            CustomTableCell(
                                                text: stock.description != null
                                                    ? stock.description
                                                        .toString()
                                                    : 'null',
                                                textColor: Colors.black),
                                            TableCell(
                                              child: InkWell(
                                                child: CustomIcon(
                                                  icons: stock.status == 2
                                                      ? Icons.remove_circle
                                                      : Icons
                                                          .check_circle_rounded,
                                                  color: stock.status == 0
                                                      ? Colors.yellow
                                                      : stock.status == 1
                                                          ? Colors.green
                                                          : Colors.red,
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
                            ) :
                            Center(
                              child: Text(
                                "Return Stock to Warehouse is Empty",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.clearDropdown();
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Returned Stock to Another Warehouse"),
                  content: Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Warehouse",
                              items: controller.dropdownItemsWarehouse
                                  .map((warehouse) {
                                return warehouse["name"].toString();
                              }).toList(),
                              onChanged: (warehouseName) async {
                                var selectWarehouse = controller
                                    .dropdownItemsWarehouse
                                    .firstWhere(
                                        (warehouse) =>
                                            warehouse['name'].toString() ==
                                            warehouseName,
                                        orElse: () => null);
                                if (selectWarehouse != null) {
                                  controller.selectWarehouse.value =
                                      selectWarehouse['id'].toString();
                                  controller.filterCompany();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Product",
                              items: controller.dropdownItemsProduct
                                  .map((product) {
                                return product["name"].toString();
                              }).toList(),
                              onChanged: (productName) async {
                                var selectedProduct =
                                    controller.dropdownItemsProduct.firstWhere(
                                        (product) =>
                                            product['name'].toString() ==
                                            productName,
                                        orElse: () => null);
                                if (selectedProduct != null) {
                                  controller.selectProduct.value =
                                      selectedProduct['id'].toString();
                                  controller.filterCompany();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Company",
                              items: controller.dropdownItemsCompany
                                  .map((company) {
                                return company["name"].toString();
                              }).toList(),
                              onChanged: (companyName) async {
                                var selectedCompany =
                                    controller.dropdownItemsCompany.firstWhere(
                                        (product) =>
                                            product['name'].toString() ==
                                            companyName,
                                        orElse: () => null);
                                if (selectedCompany != null) {
                                  controller.selectCompany.value =
                                      selectedCompany['id'].toString();
                                  controller.filterBrand();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Brand",
                              items: controller.dropdownItemsBrand.map((brand) {
                                return brand["name"].toString();
                              }).toList(),
                              onChanged: (brandName) async {
                                var selectedBrand =
                                    controller.dropdownItemsBrand.firstWhere(
                                        (product) =>
                                            product['name'].toString() ==
                                            brandName,
                                        orElse: () => null);
                                if (selectedBrand != null) {
                                  controller.selectBrand.value =
                                      selectedBrand['id'].toString();
                                  controller.filterType();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Type",
                              items: controller.dropdownItemsType.map((type) {
                                return type["name"].toString();
                              }).toList(),
                              selectedItem: selectType,
                              onChanged: (value) {
                                if (value == 'Male') {
                                  controller.selectType.value = '1';
                                } else if (value == 'Female') {
                                  controller.selectType.value = '2';
                                } else if (value == 'Kids') {
                                  controller.selectType.value = '3';
                                }
                                controller.filterSize();
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Size",
                              items: controller.dropdownItemsSize.map((size) {
                                return size["number"].toString();
                              }).toList(),
                              onChanged: (sizeNumber) async {
                                var selectSize = controller.dropdownItemsSize
                                    .firstWhere(
                                        (size) =>
                                            size['number'].toString() ==
                                            sizeNumber,
                                        orElse: () => null);
                                if (selectSize != null) {
                                  controller.selectSize.value =
                                      selectSize['id'].toString();
                                  controller.filterColor();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppDropDown(
                              labelText: "Select Color",
                              items: controller.dropdownItemsColor.map((color) {
                                return color["name"].toString();
                              }).toList(),
                              onChanged: (colorName) async {
                                var selectColor = controller.dropdownItemsColor
                                    .firstWhere(
                                        (color) =>
                                            color['name'].toString() ==
                                            colorName,
                                        orElse: () => null);
                                if (selectColor != null) {
                                  controller.selectColor.value =
                                      selectColor['id'].toString();
                                  controller.totalStock();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => AppTextField(
                              controller: controller.totalStocks.value,
                              labelText: "Total Stock",
                              enabled: false,
                              onChanged: (value) {
                                controller.totalStocks.value.text = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            controller: controller.quantiy.value,
                            labelText: "Quantity",
                            onlyNumerical: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            controller: controller.description.value,
                            labelText: "Description",
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.addReturnedStock();
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    ),
                  ],
                );
              });
            },
          );
        },
        label: const Text("Returned Stock To Warehouse"),
      ),
    );
  }
}
