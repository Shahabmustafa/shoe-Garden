import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../../viewmodel/warehouse/claim/claim_to_warehouse_view_model.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/claim_to_warehouse_export.dart';

class ClaimToWarehouseScreenWarehouse extends StatefulWidget {
  const ClaimToWarehouseScreenWarehouse({super.key});

  @override
  State<ClaimToWarehouseScreenWarehouse> createState() =>
      _ClaimToWarehouseScreenWarehouseState();
}

class _ClaimToWarehouseScreenWarehouseState
    extends State<ClaimToWarehouseScreenWarehouse> {
  String? selectType = 'Select Type';
  Future<void> refresh() async {
    Get.put(WClaimToWarehouseViewModel()).refreshApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WClaimToWarehouseViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Claim To Another Warehouse"),
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
                                    labelText: "Search Warehouse",
                                    search: true,
                                    prefixIcon: Icon(Icons.search),
                                    onChanged: (value) {
                                      setState(() {});
                                      controller.searchValue.value = value;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () =>
                                        ClaimFromWarehouuseExport().printPdf(),
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
                                8: FlexColumnWidth(2),
                                9: FlexColumnWidth(2),
                                10: FlexColumnWidth(1.5),
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
                                      text: 'Date',
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
                            child: Builder(
                              builder: (context) {
                                // Filter claims based on the search criteria
                                final filteredClaims = controller.claimList.value.body!.claims!
                                    .where((stock) {
                                  var name = stock.claimTo != null ? stock.claimTo!.name.toString() : "";
                                  return controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                                }).toList();

                                // Check if there are any filtered claims
                                if (filteredClaims.isEmpty) {
                                  return NotFoundWidget(title: "Warehouse Not Found");
                                }

                                return ListView.builder(
                                  itemCount: filteredClaims.length,
                                  itemBuilder: (context, index) {
                                    var stock = filteredClaims[index];

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
                                          9: FlexColumnWidth(2),
                                          10: FlexColumnWidth(1.5),
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
                                                text: stock.claimTo != null ? stock.claimTo!.name : 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: stock.product != null ? stock.product!.name : 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: stock.brand != null ? stock.brand!.name : 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: stock.type != null ? stock.type!.name : 'null',
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
                                                text: stock.quantity != null ? stock.quantity.toString() : 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: stock.description != null ? stock.description.toString() : 'null',
                                                textColor: Colors.black,
                                              ),
                                              CustomTableCell(
                                                text: stock.date != null ? stock.date.toString() : 'null',
                                                textColor: Colors.black,
                                              ),
                                              TableCell(
                                                child: InkWell(
                                                  child: CustomIcon(
                                                    icons: stock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                    color: stock.status == 0 ? Colors.yellow : stock.status == 1 ? Colors.green : Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.clearDropdown();
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Claim For Warehouse"),
                  content: Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        children: [
                          AppDropDown(
                            labelText: "Select Warehouse",
                            items: controller.dropdownItemWarehouse
                                .map((warehouse) {
                              return warehouse["name"].toString();
                            }).toList(),
                            onChanged: (warehouseName) async {
                              var selectWarehouse =
                                  controller.dropdownItemWarehouse.firstWhere(
                                      (warehouse) =>
                                          warehouse['name'].toString() ==
                                          warehouseName,
                                      orElse: () => null);
                              if (selectWarehouse != null) {
                                controller.selectWarehouse.value =
                                    selectWarehouse['id'].toString();
                              }
                            },
                          ),
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
                                  .map((product) {
                                return product["name"].toString();
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
                              items:
                                  controller.dropdownItemsBrand.map((product) {
                                return product["name"].toString();
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
                                  controller.filterSize();
                                }
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
                                  controller.filterType();
                                }
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => AppDropDown(
                              labelText: "Select Type",
                              items: controller.dropdownItemsType.map((color) {
                                return color["name"].toString();
                              }).toList(),
                              onChanged: (typeName) {
                                var selectType = controller.dropdownItemsType
                                    .firstWhere(
                                        (type) =>
                                            type['name'].toString() == typeName,
                                        orElse: () => null);
                                if (selectType != null) {
                                  controller.selectType.value =
                                      selectType['id'].toString();
                                  controller.filterColor();
                                }
                              },
                            ),
                          ),
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
                            controller.addClaim();
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
        label: const Text("Add Claims For Warehouse"),
      ),
    );
  }
}
