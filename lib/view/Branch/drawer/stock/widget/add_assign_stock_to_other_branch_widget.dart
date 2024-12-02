import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/viewmodel/branch/assign_stock/assign_stock_to_other_branch_view_model.dart';

class AddAssignStockToOtherBranchWidget extends StatelessWidget {
  const AddAssignStockToOtherBranchWidget({super.key});

  List<T> removeDuplicates<T>(List<T> list) {
    return LinkedHashSet<T>.from(list).toList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssignStockToOtherBranchViewModel());
    return FloatingActionButton.extended(
      onPressed: () {
        controller.clearDropdown();
        controller.clearValue();
        controller.barcodeController.value.addListener(controller.onBarcodeScanned);
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
                          var selectedProduct = controller.dropdownItemsProduct
                              .firstWhere(
                                  (product) =>
                                      product['name'].toString() == productName,
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
                          var selectedCompany = controller.dropdownItemsCompany
                              .firstWhere(
                                  (product) =>
                                      product['name'].toString() == companyName,
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
                                  (type) => type['name'].toString() == typeName,
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
    );
  }
}
