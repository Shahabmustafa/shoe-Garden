import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/view_assign_stock.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/warehouse/Assign Stock/assign_branch_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';
import 'export/assign_stock_to_branch_export.dart';

class AssignStockToBranchScreenWarehouse extends StatefulWidget {
  const AssignStockToBranchScreenWarehouse({super.key});

  @override
  State<AssignStockToBranchScreenWarehouse> createState() =>
      _AssignStockToBranchScreenWarehouseState();
}

class _AssignStockToBranchScreenWarehouseState
    extends State<AssignStockToBranchScreenWarehouse> {
  var controller = Get.put(WAssignStockBranchViewModel());
  Future<void> refresStock() async {
    controller.refreshApi();
  }

  void onBarcodeScanned() {
    final barcode = controller.barcodeController.value.text;

    // Check if input is from the scanner gun (ends with Enter or newline)
    if (barcode.isNotEmpty && barcode.endsWith('\n')) {
      // Clean up the barcode (trim newline or extra spaces)
      final cleanedBarcode = barcode.trim();

      // Trigger the method with the scanned barcode
      controller.barcodeMethod(cleanedBarcode);

      // Clear the text field for the next scan
      controller.barcodeController.value.clear();
    }
  }

  String? selectBranch;
  String? selectCompany;
  String? selectBrand;
  String? selectProduct;
  String? selectType;
  String? selectColor;
  String? selectSize;
  String? selectQuantity;

  @override
  void dispose() {
    controller.barcodeController.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to Branch"),
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
                    final filteredProducts = controller.assignStockBranchList.value.body!.branchStocks!
                        .where((product) {
                      return controller.search.value.text.isEmpty ||
                          product.branch!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase());
                    }).toList();
                    return RefreshIndicator(
                      onRefresh: refresStock,
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
                                    labelText: "Search Branch",
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
                                    onTap: () => AssignStockToBranchExport().printPdf(),
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
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(3),
                                4: FlexColumnWidth(3),
                                5: FlexColumnWidth(3),
                                6: FlexColumnWidth(1.5),
                                7: FlexColumnWidth(1.5),
                                8: FlexColumnWidth(1.5),
                                9: FlexColumnWidth(1.5),
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
                                      text: 'Products',
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
                                      text: 'Status',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'View',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Edit',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomTableCell(
                                      text: 'Delete',
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child:  controller.assignStockBranchList.value.body!.branchStocks!.isNotEmpty ?
                            filteredProducts.isEmpty ?
                            NotFoundWidget(title: "Branch Not Found") :
                            ListView.builder(
                              itemCount: controller.assignStockBranchList.value.body!.branchStocks!.length,
                              itemBuilder: (context, index) {
                                var assignStock = controller.assignStockBranchList.value.body!.branchStocks![index];
                                var name = assignStock.branch != null ? assignStock.branch!.name.toString() : "NUll" ;
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
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
                                        6: FlexColumnWidth(1.5),
                                        7: FlexColumnWidth(1.5),
                                        8: FlexColumnWidth(1.5),
                                        9: FlexColumnWidth(1.5),
                                      },
                                      border: TableBorder.all(
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
                                              text: assignStock.branch != null ? assignStock.branch!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.product != null ? assignStock.product!.name : 'null',
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.color?.name?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.size?.number?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            CustomTableCell(
                                              text: assignStock.quantity?.toString() ?? "0",
                                              textColor: Colors.black,
                                            ),
                                            TableCell(
                                              child: CustomIcon(
                                                icons: assignStock.status == 2 ? Icons.remove_circle : Icons.check_circle_rounded,
                                                color: assignStock.status == 0 ? Colors.yellow : assignStock.status == 1 ? Colors.green : Colors.red,
                                              ),
                                            ),
                                            TableCell(
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewAssignStock(
                                                        title:
                                                        "Assign Stock To Branch",
                                                        barcode: assignStock.barcode == null ? "Null" : assignStock.barcode.toString(),
                                                        productName: assignStock.product == null ? "Null" : assignStock.product!.name.toString(),
                                                        purchasePrice: assignStock.product == null ? "Null" : assignStock.product!.purchasePrice.toString(),
                                                        salePrice: assignStock.product == null ? "Null" : assignStock.product!.salePrice.toString(),
                                                        assignBy: assignStock.assignedBy == null ? "Null" : assignStock.assignedBy!.name.toString(),
                                                        name: assignStock.branch == null ? "Null" : assignStock.branch!.name.toString(),
                                                        brand: assignStock.brand == null ? "Null" : assignStock.brand!.name.toString(),
                                                        company: assignStock.company == null ? "Null" : assignStock.company!.name.toString(),
                                                        color: assignStock.color == null ? "Null" : assignStock.color!.name.toString(),
                                                        size: assignStock.size == null ? "Null" : assignStock.size!.number.toString(),
                                                        type: assignStock.type == null ? "Null" : assignStock.type!.name.toString(),
                                                        quantity: assignStock.quantity == null ? "Null" : assignStock.quantity!.toString(),
                                                        remaningQuantity: assignStock.remainingQuantity?.toString() ?? "0",
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                  icons: Icons.visibility,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      // Initialize selected values based on the existing stock data
                                                      selectBranch = assignStock.branch != null ? assignStock.branch!.name.toString() : "Null";
                                                      selectProduct = assignStock.product != null ? assignStock.product!.name.toString() : "Null";
                                                      selectCompany = assignStock.company != null ? assignStock.company!.name.toString() : "Null";
                                                      selectBrand = assignStock.brand != null ? assignStock.brand!.name.toString() : "Null";
                                                      selectType = assignStock.type != null ? assignStock.type!.name.toString() : "Null";
                                                      selectColor = assignStock.color != null ? assignStock.color!.name.toString() : "Null";
                                                      selectSize = assignStock.size != null ? assignStock.size!.number.toString() : "Null";
                                                      selectQuantity = assignStock.remainingQuantity != null ? assignStock.remainingQuantity.toString() : "Null";

                                                      // Assign initial values to controller
                                                      controller.selectBranch.value = assignStock.branchId != null ? assignStock.branchId!.toString() : "Null";
                                                      controller.selectBrand.value = assignStock.brandId != null ? assignStock.brandId!.toString() : "Null";
                                                      controller.selectProduct.value = assignStock.productId != null ? assignStock.productId!.toString() : "Null";
                                                      controller.selectCompany.value = assignStock.companyId != null ? assignStock.companyId!.toString() : "Null";
                                                      controller.selectType.value = assignStock.typeId != null ? assignStock.typeId!.toString() : "Null";
                                                      controller.selectSize.value = assignStock.sizeId != null ? assignStock.sizeId!.toString() : "Null";
                                                      controller.selectColor.value = assignStock.colorId != null ? assignStock.colorId!.toString() : "Null";
                                                      controller.totalStocks.value.text = assignStock.quantity != null ? assignStock.quantity!.toString() : "Null";
                                                      return AlertDialog(
                                                        title: const Text(
                                                          "Edit Assign Stock",
                                                        ),
                                                        content:
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Obx(() => AppDropDown(
                                                                labelText:
                                                                "Select Branch",
                                                                items: controller.dropdownItemsBranch.map((branch) {
                                                                  return branch["name"].toString();
                                                                }).toSet().toList(),
                                                                selectedItem: selectBranch,
                                                                onChanged: (productName) async {
                                                                  var selectedProduct = controller.dropdownItemsBranch.firstWhere((branch) =>
                                                                      branch['name'].toString() == productName, orElse: () => null);
                                                                  if (selectedProduct != null) {
                                                                    controller.selectBranch.value = selectedProduct['id'].toString();
                                                                  }
                                                                  controller.filterCompany();
                                                                },
                                                              ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(() =>
                                                                  AppDropDown(
                                                                    labelText: "Select Product",
                                                                      items: controller.dropdownItemsProduct.map((product) {
                                                                        return product["name"].toString();
                                                                      }).toSet().toList(),
                                                                    selectedItem: selectProduct,
                                                                    onChanged: (productName) {
                                                                        var selectedProduct = controller.dropdownItemsProduct.firstWhere((product) =>
                                                                        product['name'].toString() == productName,
                                                                          orElse: () => null,
                                                                        );
                                                                        if (selectedProduct != null) {
                                                                          controller.selectProduct.value = selectedProduct['id'].toString();
                                                                          print(controller.selectProduct.value);
                                                                          controller.filterCompany();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(() =>
                                                                  AppDropDown(
                                                                    labelText:
                                                                    "Select Company",
                                                                    selectedItem: selectCompany,
                                                                      items: controller.dropdownItemsCompany.map((product) {return product["name"].toString();}).toSet().toList(),
                                                                      onChanged: (companyName) {
                                                                        controller.companyN.value = companyName.toString();
                                                                        var selectedCompany = controller.dropdownItemsCompany.firstWhere((product) =>
                                                                        product['name'].toString() == companyName, orElse: () => null);
                                                                        if (selectedCompany != null) {
                                                                          controller.selectCompany.value = selectedCompany['id'].toString();
                                                                          controller.filterBrand();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(() =>
                                                                  AppDropDown(
                                                                    labelText: "Select Brand",
                                                                      selectedItem: selectBrand,
                                                                      items: controller.dropdownItemsBrand.map((brand) {return brand["name"].toString();}).toSet().toList(),
                                                                      onChanged: (brandName) {
                                                                      controller.brandN.value = brandName.toString();
                                                                        var selectedBrand = controller.dropdownItemsBrand.firstWhere((product) =>
                                                                        product['name'].toString() == brandName, orElse: () =>
                                                                        null);
                                                                        if (selectedBrand !=
                                                                            null) {
                                                                          controller
                                                                              .selectBrand
                                                                              .value = selectedBrand[
                                                                          'id']
                                                                              .toString();

                                                                          controller
                                                                              .filterType();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(
                                                                    () =>
                                                                    AppDropDown(
                                                                      labelText:
                                                                      "Select Type",
                                                                      selectedItem: selectType,
                                                                      items: controller
                                                                          .dropdownItemsType
                                                                          .map(
                                                                              (color) {
                                                                            return color["name"]
                                                                                .toString();
                                                                          })
                                                                          .toSet()
                                                                          .toList(),
                                                                      onChanged:
                                                                          (typeName) {
                                                                        controller
                                                                            .typeN
                                                                            .value =
                                                                            typeName
                                                                                .toString();
                                                                        var selectType = controller.dropdownItemsType.firstWhere(
                                                                                (type) =>
                                                                            type['name'].toString() ==
                                                                                typeName,
                                                                            orElse: () =>
                                                                            null);
                                                                        if (selectType !=
                                                                            null) {
                                                                          controller
                                                                              .selectType
                                                                              .value = selectType[
                                                                          'id']
                                                                              .toString();

                                                                          controller
                                                                              .filterSize();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(
                                                                    () =>
                                                                    AppDropDown(
                                                                      labelText:
                                                                      "Select Size",
                                                                      selectedItem: selectSize,
                                                                      items: controller
                                                                          .dropdownItemsSize
                                                                          .map(
                                                                              (size) {
                                                                            return size["number"]
                                                                                .toString();
                                                                          })
                                                                          .toSet()
                                                                          .toList(),
                                                                      onChanged:
                                                                          (sizeNumber) {
                                                                        controller
                                                                            .sizeN
                                                                            .value =
                                                                            sizeNumber
                                                                                .toString();
                                                                        var selectSize =
                                                                        controller
                                                                            .dropdownItemsSize
                                                                            .firstWhere(
                                                                              (size) =>
                                                                          size['number']
                                                                              .toString() ==
                                                                              sizeNumber,
                                                                          orElse: () =>
                                                                          null,
                                                                        );
                                                                        if (selectSize !=
                                                                            null) {
                                                                          controller
                                                                              .selectSize
                                                                              .value = selectSize[
                                                                          'id']
                                                                              .toString();
                                                                          controller
                                                                              .filterColor();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(
                                                                    () =>
                                                                    AppDropDown(
                                                                      labelText:
                                                                      "Select Color",
                                                                      selectedItem: selectColor,
                                                                      items: controller
                                                                          .dropdownItemsColor
                                                                          .map(
                                                                              (color) {
                                                                            return color["name"]
                                                                                .toString();
                                                                          })
                                                                          .toSet()
                                                                          .toList(),
                                                                      onChanged:
                                                                          (colorName) {
                                                                        controller
                                                                            .colorN
                                                                            .value =
                                                                            colorName
                                                                                .toString();
                                                                        var selectColor = controller.dropdownItemsColor.firstWhere(
                                                                                (color) =>
                                                                            color['name'].toString() ==
                                                                                colorName,
                                                                            orElse: () =>
                                                                            null);
                                                                        if (selectColor !=
                                                                            null) {
                                                                          controller
                                                                              .selectColor
                                                                              .value = selectColor[
                                                                          'id']
                                                                              .toString();

                                                                          controller
                                                                              .totalStock();
                                                                        }
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(
                                                                    () =>
                                                                    AppTextField(
                                                                      controller:
                                                                      controller
                                                                          .totalStocks
                                                                          .value,
                                                                      labelText:
                                                                      "Total Stock",
                                                                      enabled:
                                                                      false,
                                                                      onChanged:
                                                                          (value) {
                                                                        controller
                                                                            .totalStocks
                                                                            .value
                                                                            .text = value;
                                                                      },
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Obx(
                                                                    () =>
                                                                    AppTextField(
                                                                      controller:
                                                                      controller
                                                                          .assignStock
                                                                          .value,
                                                                      onlyNumerical:
                                                                      true,
                                                                      labelText:
                                                                      "Assign Stock",
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: const Text(
                                                                    "Cancel"),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  controller.updateAssignStockBranch(
                                                                      assignStock
                                                                          .id
                                                                          .toString());
                                                                },
                                                                child: const Text(
                                                                    "Update"),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const CustomIcon(
                                                    icons: CupertinoIcons
                                                        .eyedropper,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            TableCell(
                                                child: InkWell(
                                                    child: const CustomIcon(
                                                        icons: CupertinoIcons
                                                            .delete,
                                                        color: Colors.red),
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return EditDialog(
                                                            accept: () {
                                                              controller
                                                                  .deleteBranch(
                                                                  assignStock
                                                                      .id
                                                                      .toString());
                                                            },
                                                            reject: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    })),
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
                                "Assign Stock to Branch is Empty",
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
          controller.clearDropdown();
          controller.barcodeController.value.addListener(onBarcodeScanned);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Assign Stock"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Branch",
                          items: controller.dropdownItemsBranch
                              .map((branch) {
                                return branch["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          onChanged: (branchName) async {
                            var selectBranch = controller.dropdownItemsBranch
                                .firstWhere(
                                    (branch) =>
                                        branch['name'].toString() == branchName,
                                    orElse: () => null);
                            if (selectBranch != null) {
                              controller.selectBranch.value =
                                  selectBranch['id'].toString();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppTextField(
                          controller: controller.barcodeController.value,
                          labelText: "Bar Code",
                          enabled: true,
                          onFieldSubmitted: (barcode) {
                            controller.barcodeMethod(barcode);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Product",
                          items: controller.dropdownItemsProduct
                              .map((product) {
                                return product["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.productN.value.isEmpty
                              ? null
                              : controller.productN.value,
                          onChanged: (productName) {
                            controller.barcodeController.value.clear();
                            var selectedProduct =
                                controller.dropdownItemsProduct.firstWhere(
                                    (product) =>
                                        product['name'].toString() ==
                                        productName,
                                    orElse: () => null);
                            if (selectedProduct != null) {
                              controller.selectProduct.value =
                                  selectedProduct['id'].toString();
                              print(controller.selectProduct.value);
                              controller.filterCompany();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Company",
                          items: controller.dropdownItemsCompany
                              .map((product) {
                                return product["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.companyN.value.isEmpty
                              ? null
                              : controller.companyN.value,
                          onChanged: (companyName) {
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
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Brand",
                          items: controller.dropdownItemsBrand
                              .map((brand) {
                                return brand["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.brandN.value.isEmpty
                              ? null
                              : controller.brandN.value,
                          onChanged: (brandName) {
                            var selectedBrand = controller.dropdownItemsBrand
                                .firstWhere(
                                    (product) =>
                                        product['name'].toString() == brandName,
                                    orElse: () => null);
                            if (selectedBrand != null) {
                              controller.selectBrand.value =
                                  selectedBrand['id'].toString();

                              controller.filterType();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Type",
                          items: controller.dropdownItemsType
                              .map((color) {
                                return color["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.typeN.value.isEmpty
                              ? null
                              : controller.typeN.value,
                          onChanged: (typeName) {
                            var selectType = controller.dropdownItemsType
                                .firstWhere(
                                    (type) =>
                                        type['name'].toString() == typeName,
                                    orElse: () => null);
                            if (selectType != null) {
                              controller.selectType.value =
                                  selectType['id'].toString();

                              controller.filterSize();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Size",
                          items: controller.dropdownItemsSize
                              .map((size) {
                                return size["number"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.sizeN.value.isEmpty
                              ? null
                              : controller.sizeN.value,
                          onChanged: (sizeNumber) {
                            var selectSize = controller.dropdownItemsSize
                                .firstWhere(
                                    (size) =>
                                        size['number'].toString() == sizeNumber,
                                    orElse: () => null);
                            if (selectSize != null) {
                              controller.selectSize.value =
                                  selectSize['id'].toString();

                              controller.filterColor();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => AppDropDown(
                          labelText: "Select Color",
                          items: controller.dropdownItemsColor
                              .map((color) {
                                return color["name"].toString();
                              })
                              .toSet()
                              .toList(),
                          selectedItem: controller.colorN.value.isEmpty
                              ? null
                              : controller.colorN.value,
                          onChanged: (colorName) {
                            var selectColor = controller.dropdownItemsColor
                                .firstWhere(
                                    (color) =>
                                        color['name'].toString() == colorName,
                                    orElse: () => null);
                            if (selectColor != null) {
                              controller.selectColor.value =
                                  selectColor['id'].toString();

                              controller.totalStock();
                            }
                          },
                        ),
                      ),
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
                      Obx(
                        () => AppTextField(
                          controller: controller.assignStock.value,
                          labelText: "Assign Stock",
                          onlyNumerical: true,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();

                          controller.barcodeController.value
                              .removeListener(() {});
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addBranch();
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Assign Stock"),
      ),
    );
  }
}
