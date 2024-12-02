import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/internet_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/view_assign_stock.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock/export/assign_stock_to_other_branch_export.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock/widget/add_assign_stock_to_other_branch_widget.dart';
import 'package:sofi_shoes/viewmodel/branch/assign_stock/assign_stock_to_other_branch_view_model.dart';

import '../../../../date/response/status.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class BAssignStockToBranchScreen extends StatefulWidget {
  const BAssignStockToBranchScreen({super.key});

  @override
  State<BAssignStockToBranchScreen> createState() =>
      _BAssignStockToBranchScreenState();
}

class _BAssignStockToBranchScreenState
    extends State<BAssignStockToBranchScreen> {
  final controller = Get.put(AssignStockToOtherBranchViewModel());
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
    // TODO: implement dispose
    controller.barcodeController.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Stock to Other Branch"),
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
                        child: Obx(() {
                          print("Search text: ${controller.search.value.text}");
                          print("Search value: ${controller.searchValue.value}");
                          return AppTextField(
                            controller: controller.search.value, // Make sure this is the correct controller
                            labelText: "Search Name",
                            search: true,
                            prefixIcon: const Icon(Icons.search),
                            onChanged: (value) {
                              controller.searchValue.value = value;
                              setState(() {});
                            },
                          );
                        }),
                      ),
                      Flexible(
                        child: AppExportButton(
                          icons: Icons.add,
                          onTap: () {
                            AssignStockToOtherBranchExport().printAssignStockPdf();
                          },
                        ),
                      )
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
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(2),
                      8: FlexColumnWidth(2),
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
                            text: 'Branch',
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
                Expanded(child: Obx(() {
                  switch (controller.rxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularIndicator.waveSpinkit);
                    case Status.ERROR:
                      if (controller.error.value == 'No internet') {
                        return InterNetExceptionWidget(onPress: () {
                          return controller.refreshApi();
                        });
                      } else {
                        return GeneralExceptionWidget(onPress: () {
                          controller.refreshApi();
                        });
                      }
                    case Status.COMPLETE:
                      var filteredStocks = controller.assignStockToOtherBranchList.value.body!.branchStocks!.where((data) {
                        return controller.search.value.text.isEmpty || (data.branch != null && data.branch!.name.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                      }).toList();
                      return controller.assignStockToOtherBranchList.value.body!.branchStocks!.isNotEmpty ?
                      filteredStocks.isEmpty ?
                      NotFoundWidget(title: "Branch Not Found") :
                      ListView.builder(
                        itemCount: controller.assignStockToOtherBranchList.value.body!.branchStocks!.length,
                        itemBuilder: (context, index) {
                          final data = controller.assignStockToOtherBranchList.value.body!.branchStocks![index];
                          var name = data.branch != null ? data.branch!.name!.toString() : "Null";
                          if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
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
                                  6: FlexColumnWidth(2),
                                  7: FlexColumnWidth(2),
                                  8: FlexColumnWidth(2),
                                  9: FlexColumnWidth(2),
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
                                        text: "${index + 1}",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.branch != null ? data.branch!.name.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.product == null ? "Null" : data.product!.name.toString(),
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
                                                title: 'Assign Stock to Branch Detail',
                                                barcode: data.barcode == null ? "Null" : data.barcode.toString(),
                                                productName: data.product == null ? "Null" : data.product!.name.toString(),
                                                purchasePrice: "",
                                                salePrice: data.product == null
                                                    ? "Null"
                                                    : data.product!.salePrice
                                                        .toString(),
                                                assignBy:
                                                    data.assignedBy == null
                                                        ? "Null"
                                                        : data.assignedBy!.name
                                                            .toString(),
                                                name: data.branch == null
                                                    ? "Null"
                                                    : data.branch!.name
                                                        .toString(),
                                                brand: data.brand == null
                                                    ? "Null"
                                                    : data.brand!.name
                                                        .toString(),
                                                company: data.company == null
                                                    ? "Null"
                                                    : data.company!.name
                                                        .toString(),
                                                color: data.color == null
                                                    ? "Null"
                                                    : data.color!.name
                                                        .toString(),
                                                size: data.size == null
                                                    ? "Null"
                                                    : data.size!.number
                                                        .toString(),
                                                type: data.type == null
                                                    ? "Null"
                                                    : data.type!.name
                                                        .toString(),
                                                quantity: data.quantity == null
                                                    ? "Null"
                                                    : data.quantity!.toString(),
                                                remaningQuantity: data
                                                        .remainingQuantity
                                                        .toString() ??
                                                    "",
                                              );
                                            },
                                          );
                                        },
                                        child: const CustomIcon(
                                          icons: Icons.visibility,
                                          color: Colors.green,
                                        ),
                                      ),
                                      CustomIcon(
                                        icons: data.status == 0 ? Icons.remove_circle : Icons.check_circle,
                                        color: data.status == 0 ? Colors.yellow : data.status == 1 ? Colors.green : Colors.red,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.clearValue();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  // Initialize selected values based on the existing stock data
                                                  selectBranch =
                                                      data.branch != null
                                                          ? data.branch!.name
                                                              .toString()
                                                          : "Null";
                                                  selectProduct =
                                                      data.product != null
                                                          ? data.product!.name
                                                              .toString()
                                                          : "Null";
                                                  selectCompany =
                                                      data.company != null
                                                          ? data.company!.name
                                                              .toString()
                                                          : "Null";
                                                  selectBrand =
                                                      data.brand != null
                                                          ? data.brand!.name
                                                              .toString()
                                                          : "Null";
                                                  selectType = data.type != null
                                                      ? data.type!.name
                                                          .toString()
                                                      : "Null";
                                                  selectColor =
                                                      data.color != null
                                                          ? data.color!.name
                                                              .toString()
                                                          : "Null";
                                                  selectSize = data.size != null
                                                      ? data.size!.number
                                                          .toString()
                                                      : "Null";
                                                  selectQuantity =
                                                      data.quantity != null
                                                          ? data.quantity
                                                              .toString()
                                                          : "Null";

                                                  // Update controller values with initial data
                                                  controller.selectBranch.value = data.branchId != null ? data.branchId!.toString() : "Null";
                                                  controller.selectBrand.value = data.brandId != null ? data.brandId!.toString() : "Null";
                                                  controller.selectProduct.value = data.productId != null ? data.productId!.toString() : "Null";
                                                  controller.selectCompany.value = data.companyId != null ? data.companyId!.toString() : "Null";
                                                  controller.selectType.value = data.typeId != null ? data.typeId!.toString() : "Null";
                                                  controller.selectSize.value = data.sizeId != null ? data.sizeId!.toString() : "Null";
                                                  controller.selectColor.value = data.colorId != null ? data.colorId!.toString() : "Null";
                                                  controller.totalStocks.value.text = data.quantity != null ? data.quantity!.toString() : "Null";

                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Update Assign Stock to Other Branch"),
                                                    content: Obx(() {
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            AppDropDown(
                                                              labelText:
                                                                  "Select Branch",
                                                              selectedItem:
                                                                  selectBranch,
                                                              items: controller
                                                                  .dropdownItemsBranch
                                                                  .map(
                                                                      (branch) {
                                                                return branch[
                                                                        "name"]
                                                                    .toString();
                                                              }).toList(),
                                                              onChanged:
                                                                  (branchName) async {
                                                                var selectedBranch =
                                                                    controller
                                                                        .dropdownItemsBranch
                                                                        .firstWhere(
                                                                  (branch) =>
                                                                      branch['name']
                                                                          .toString() ==
                                                                      branchName,
                                                                  orElse: () =>
                                                                      null,
                                                                );
                                                                if (selectedBranch !=
                                                                    null) {
                                                                  controller
                                                                      .selectBranch
                                                                      .value = selectedBranch[
                                                                          'id']
                                                                      .toString();
                                                                  print(
                                                                      'Selected Branch ID: ${controller.selectBranch.value}'); // Debug print
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Product",
                                                                selectedItem:
                                                                    selectProduct,
                                                                items: controller
                                                                    .dropdownItemsProduct
                                                                    .map(
                                                                        (product) {
                                                                      return product["name"]
                                                                              .toString() ??
                                                                          "Null";
                                                                    })
                                                                    .where((productName) =>
                                                                        productName !=
                                                                        "Null")
                                                                    .toList(),
                                                                onChanged:
                                                                    (productName) {
                                                                  var selectedProduct =
                                                                      controller
                                                                          .dropdownItemsProduct
                                                                          .firstWhere(
                                                                    (product) =>
                                                                        product["name"]
                                                                            ?.toString() ==
                                                                        productName,
                                                                    orElse:
                                                                        () =>
                                                                            {},
                                                                  );
                                                                  if (selectedProduct
                                                                      .isNotEmpty) {
                                                                    controller
                                                                        .selectProduct
                                                                        .value = selectedProduct[
                                                                            'id']
                                                                        .toString();
                                                                    print(
                                                                        "Product Name : ${controller.selectProduct.value}");
                                                                    controller
                                                                        .filterCompany();
                                                                  }
                                                                },
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Company",
                                                                selectedItem:
                                                                    selectCompany,
                                                                items: controller
                                                                    .dropdownItemsCompany
                                                                    .map(
                                                                        (company) {
                                                                  return company[
                                                                          "name"]
                                                                      .toString();
                                                                }).toList(),
                                                                onChanged:
                                                                    (companyName) async {
                                                                  var selectedCompany =
                                                                      controller
                                                                          .dropdownItemsCompany
                                                                          .firstWhere(
                                                                    (company) =>
                                                                        company['name']
                                                                            .toString() ==
                                                                        companyName,
                                                                    orElse:
                                                                        () =>
                                                                            {},
                                                                  );
                                                                  if (selectedCompany !=
                                                                      null) {
                                                                    controller
                                                                        .selectCompany
                                                                        .value = selectedCompany[
                                                                            'id']
                                                                        .toString();
                                                                    controller
                                                                        .filterBrand();
                                                                  }
                                                                },
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Brand",
                                                                selectedItem:
                                                                    selectBrand,
                                                                items: controller
                                                                    .dropdownItemsBrand
                                                                    .map(
                                                                        (brand) {
                                                                  return brand[
                                                                          "name"]
                                                                      .toString();
                                                                }).toList(),
                                                                onChanged:
                                                                    (brandName) async {
                                                                  var selectedBrand =
                                                                      controller
                                                                          .dropdownItemsBrand
                                                                          .firstWhere(
                                                                    (brand) =>
                                                                        brand['name']
                                                                            .toString() ==
                                                                        brandName,
                                                                    orElse: () =>
                                                                        null,
                                                                  );
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
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Type",
                                                                selectedItem:
                                                                    selectType,
                                                                items: controller
                                                                    .dropdownItemsType
                                                                    .map(
                                                                        (type) {
                                                                  return type[
                                                                          "name"]
                                                                      .toString();
                                                                }).toList(),
                                                                onChanged:
                                                                    (typeName) async {
                                                                  var selectType =
                                                                      controller
                                                                          .dropdownItemsType
                                                                          .firstWhere(
                                                                    (type) =>
                                                                        type['name']
                                                                            .toString() ==
                                                                        typeName,
                                                                    orElse: () =>
                                                                        null,
                                                                  );
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
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Size",
                                                                selectedItem:
                                                                    selectSize,
                                                                items: controller
                                                                    .dropdownItemsSize
                                                                    .map(
                                                                        (size) {
                                                                  return size[
                                                                          "number"]
                                                                      .toString();
                                                                }).toList(),
                                                                onChanged:
                                                                    (sizeNumber) async {
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
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppDropDown(
                                                                labelText:
                                                                    "Select Color",
                                                                selectedItem:
                                                                    selectColor,
                                                                items: controller
                                                                    .dropdownItemsColor
                                                                    .map(
                                                                        (color) {
                                                                  return color[
                                                                          "name"]
                                                                      .toString();
                                                                }).toList(),
                                                                onChanged:
                                                                    (colorName) async {
                                                                  var selectColor =
                                                                      controller
                                                                          .dropdownItemsColor
                                                                          .firstWhere(
                                                                    (color) =>
                                                                        color['name']
                                                                            .toString() ==
                                                                        colorName,
                                                                    orElse: () =>
                                                                        null,
                                                                  );
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
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            Obx(() {
                                                              return AppTextField(
                                                                controller:
                                                                    controller
                                                                        .totalStocks
                                                                        .value,
                                                                labelText:
                                                                    "Available Quantity",
                                                                enabled: false,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .totalStocks
                                                                      .value
                                                                      .text = value;
                                                                },
                                                              );
                                                            }),
                                                            const SizedBox(
                                                                height: 10),
                                                            AppTextField(
                                                              labelText:
                                                                  "Assign Quantity",
                                                              controller:
                                                                  controller
                                                                      .assignStock
                                                                      .value,
                                                              onlyNumerical:
                                                                  true,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Cancel"),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              controller
                                                                  .isUpdate(data
                                                                      .id
                                                                      .toString());
                                                              print(
                                                                  'Update triggered for ID: ${data.id}'); // Debug print
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
                                          );
                                        },
                                        child: const CustomIcon(
                                          icons: Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EditDialog(
                                                accept: () {
                                                  controller.delete(
                                                      data.id.toString());
                                                },
                                                reject: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: const CustomIcon(
                                          icons: CupertinoIcons.delete,
                                          color: Colors.red,
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
                          "Assign Stock to Branch is Empty",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      );
                  }
                })),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const AddAssignStockToOtherBranchWidget(),
    );
  }
}
