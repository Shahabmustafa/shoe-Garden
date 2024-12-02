import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/viewmodel/branch/product/return_product_to_admin_view_model.dart';

class AddAdminProductReturn extends StatelessWidget {
  const AddAdminProductReturn({super.key});

  List<T> removeDuplicates<T>(List<T> list) {
    return LinkedHashSet<T>.from(list).toList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BReturnProductToAdminViewModel());
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            controller.clearDropdown();
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Add Return Stock to Admin"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return AppDropDown(
                            labelText: "Select Product",
                            items: controller.dropdownItemsProduct
                                .map((product) {
                                  return product["product"] != null &&
                                          product["product"]["name"] != null
                                      ? product["product"]["name"].toString()
                                      : "Null";
                                })
                                .where((productName) => productName != "Null")
                                .toList(),
                            onChanged: (productName) {
                              var selectedProduct =
                                  controller.dropdownItemsProduct.firstWhere(
                                      (product) =>
                                          product["product"] != null &&
                                          product["product"]["name"] != null &&
                                          product["product"]["name"]
                                                  .toString() ==
                                              productName,
                                      orElse: () => {});
                              if (selectedProduct != null &&
                                  selectedProduct.isNotEmpty) {
                                controller.selectProduct.value =
                                    selectedProduct["product"]['id'].toString();
                                print(
                                    "Product Name : ${controller.selectProduct.value}");
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
                            items:
                                controller.dropdownItemsCompany.map((product) {
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
                            items: controller.dropdownItemsBrand.map((brand) {
                              return brand["name"].toString();
                            }).toList(),
                            onChanged: (brandName) async {
                              var selectedBrand = controller.dropdownItemsBrand
                                  .firstWhere(
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
                            items: controller.dropdownItemsType.map((color) {
                              return color["name"].toString();
                            }).toList(),
                            onChanged: (typeName) async {
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
                                          color['name'].toString() == colorName,
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
                        Obx(() {
                          return AppTextField(
                            controller: controller.totalStocks.value,
                            labelText: "Avalible Quantity",
                            enabled: false,
                            onChanged: (value) {
                              controller.totalStocks.value.text = value;
                            },
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                          labelText: "Assign Quantity",
                          controller: controller.assignStock.value,
                          onlyNumerical: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                          labelText: "Description",
                          controller: controller.description.value,
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
                            Navigator.pop(context);
                            controller.clearDropdown();
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.add();
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
        );
      },
      label: const Text("Add Return Stock To Admin"),
    );
  }
}
