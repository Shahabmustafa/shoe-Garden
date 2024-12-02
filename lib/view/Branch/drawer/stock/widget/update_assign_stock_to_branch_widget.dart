import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/viewmodel/branch/assign_stock/assign_stock_to_other_branch_view_model.dart';

import '../../../../../model/admin/all_stock_of_different_branches_model.dart';

class UpdateAssignStockToOtherBranchWidget extends StatelessWidget {
  UpdateAssignStockToOtherBranchWidget(
      {required this.data, required this.id, super.key});
  String id;
  BranchStocks data;

  String? selectBranch;
  String? selectCompany;
  String? selectBrand;
  String? selectProduct;
  String? selectType;
  String? selectColor;
  String? selectSize;
  String? selectQuantity;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssignStockToOtherBranchViewModel());
    return StatefulBuilder(
      builder: (context, setState) {
        // Initialize selected values based on the existing stock data
        selectBranch =
            data.branch != null ? data.branch!.name.toString() : "Null";
        selectProduct =
            data.product != null ? data.product!.name.toString() : "Null";
        selectCompany =
            data.company != null ? data.company!.name.toString() : "Null";
        selectBrand = data.brand != null ? data.brand!.name.toString() : "Null";
        selectType = data.type != null ? data.type!.name.toString() : "Null";
        selectColor = data.color != null ? data.color!.name.toString() : "Null";
        selectSize = data.size != null ? data.size!.number.toString() : "Null";
        selectQuantity =
            data.quantity != null ? data.quantity.toString() : "Null";

        // Update controller values with initial data
        controller.selectProduct.value =
            data.productId != null ? data.productId.toString() : "Null";
        controller.selectCompany.value =
            data.companyId != null ? data.companyId.toString() : "Null";
        controller.selectBrand.value =
            data.brandId != null ? data.brandId.toString() : "Null";
        controller.selectColor.value =
            data.colorId != null ? data.colorId.toString() : "Null";
        controller.selectSize.value =
            data.sizeId != null ? data.sizeId.toString() : "Null";
        controller.selectType.value =
            data.typeId != null ? data.typeId.toString() : "Null";
        controller.selectBranch.value =
            data.branchId != null ? data.branchId.toString() : "Null";
        controller.totalStocks.value.text =
            data.quantity != null ? data.quantity.toString() : "Null";

        return AlertDialog(
          title: const Text("Update Assign Stock to Other Branch"),
          content: Obx(() {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppDropDown(
                    labelText: "Select Branch",
                    selectedItem: selectBranch,
                    items: controller.dropdownItemsBranch.map((branch) {
                      return branch["name"].toString();
                    }).toList(),
                    onChanged: (branchName) async {
                      var selectedBranch =
                          controller.dropdownItemsBranch.firstWhere(
                        (branch) => branch['name'].toString() == branchName,
                        orElse: () => null,
                      );
                      if (selectedBranch != null) {
                        controller.selectBranch.value =
                            selectedBranch['id'].toString();
                        print(
                            'Selected Branch ID: ${controller.selectBranch.value}'); // Debug print
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Product",
                      selectedItem: selectProduct,
                      items: controller.dropdownItemsProduct
                          .map((product) {
                            return product["product"]?["name"]?.toString() ??
                                "Null";
                          })
                          .where((productName) => productName != "Null")
                          .toList(),
                      onChanged: (productName) {
                        var selectedProduct =
                            controller.dropdownItemsProduct.firstWhere(
                          (product) =>
                              product["product"]?["name"]?.toString() ==
                              productName,
                          orElse: () => {},
                        );
                        if (selectedProduct.isNotEmpty) {
                          controller.selectProduct.value =
                              selectedProduct["product"]['id'].toString();
                          print(
                              "Product Name : ${controller.selectProduct.value}");
                          controller.filterCompany();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Company",
                      selectedItem: selectCompany,
                      items: controller.dropdownItemsCompany.map((company) {
                        return company["name"].toString();
                      }).toList(),
                      onChanged: (companyName) async {
                        var selectedCompany =
                            controller.dropdownItemsCompany.firstWhere(
                          (company) =>
                              company['name'].toString() == companyName,
                          orElse: () => {},
                        );
                        if (selectedCompany != null) {
                          controller.selectCompany.value =
                              selectedCompany['id'].toString();
                          controller.filterBrand();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Brand",
                      selectedItem: selectBrand,
                      items: controller.dropdownItemsBrand.map((brand) {
                        return brand["name"].toString();
                      }).toList(),
                      onChanged: (brandName) async {
                        var selectedBrand =
                            controller.dropdownItemsBrand.firstWhere(
                          (brand) => brand['name'].toString() == brandName,
                          orElse: () => null,
                        );
                        if (selectedBrand != null) {
                          controller.selectBrand.value =
                              selectedBrand['id'].toString();
                          controller.filterType();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Type",
                      selectedItem: selectType,
                      items: controller.dropdownItemsType.map((type) {
                        return type["name"].toString();
                      }).toList(),
                      onChanged: (typeName) async {
                        var selectType =
                            controller.dropdownItemsType.firstWhere(
                          (type) => type['name'].toString() == typeName,
                          orElse: () => null,
                        );
                        if (selectType != null) {
                          controller.selectType.value =
                              selectType['id'].toString();
                          controller.filterSize();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Size",
                      selectedItem: selectSize,
                      items: controller.dropdownItemsSize.map((size) {
                        return size["number"].toString();
                      }).toList(),
                      onChanged: (sizeNumber) async {
                        var selectSize =
                            controller.dropdownItemsSize.firstWhere(
                          (size) => size['number'].toString() == sizeNumber,
                          orElse: () => null,
                        );
                        if (selectSize != null) {
                          controller.selectSize.value =
                              selectSize['id'].toString();
                          controller.filterColor();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppDropDown(
                      labelText: "Select Color",
                      selectedItem: selectColor,
                      items: controller.dropdownItemsColor.map((color) {
                        return color["name"].toString();
                      }).toList(),
                      onChanged: (colorName) async {
                        var selectColor =
                            controller.dropdownItemsColor.firstWhere(
                          (color) => color['name'].toString() == colorName,
                          orElse: () => null,
                        );
                        if (selectColor != null) {
                          controller.selectColor.value =
                              selectColor['id'].toString();
                          controller.totalStock();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AppTextField(
                      controller: controller.totalStocks.value,
                      labelText: "Available Quantity",
                      enabled: false,
                      onChanged: (value) {
                        controller.totalStocks.value.text = value;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  AppTextField(
                    labelText: "Assign Quantity",
                    controller: controller.assignStock.value,
                  ),
                ],
              ),
            );
          }),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.isUpdate(id);
                    print('Update triggered for ID: $id'); // Debug print
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
