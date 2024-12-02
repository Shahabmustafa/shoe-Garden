import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/export/stock_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/widget/stock_inventory_table.dart';
import 'package:sofi_shoes/viewmodel/admin/product/stock_inventory_viewmodel.dart';
import 'package:sofi_shoes/viewmodel/warehouse/barcode/barcode_view_model.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';

class AStockInventoryScreen extends StatefulWidget {
  const AStockInventoryScreen({super.key});

  @override
  State<AStockInventoryScreen> createState() => _AStockInventoryScreenState();
}

class _AStockInventoryScreenState extends State<AStockInventoryScreen> {
  Future<void> refresh() async {
    Get.put(StockInventoryViewModel()).refreshApi();
  }

  String? selectCompany;
  String? selectBarCode;
  String? selectBrand;
  String? selectProduct;
  String? selectType;
  String? selectColor;
  String? selectSize;
  String? selectQuantity;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(StockInventoryViewModel());
    final barcode = Get.put(BarcodViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Inventory"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetAdmin()) : Container(),
          Expanded(
            flex: 8,
            child: RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppTextField(
                            labelText: "Search Name",
                            search: true,
                            controller: controller.search.value,
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
                          onTap: () => StockExport().printPdf(),
                        )),
                      ],
                    ),
                  ),
                  StockInventoryTable(
                    number: "#",
                    product: "Article",
                    barcode: "Barcode",
                    color: "Color",
                    size: "Size",
                    quantity: "Re.Quantity",
                    type: 'Type',
                    brand: 'Brand',
                    company: 'Company',
                    heading: true,
                  ),
                  Expanded(
                    child: Obx(() {
                      switch (controller.rxRequestStatus.value) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularIndicator.waveSpinkit);
                        case Status.ERROR:
                          return GeneralExceptionWidget(
                              errorMessage: controller.error.value.toString(),
                              onPress: () {
                                controller.refreshApi();
                              });
                        case Status.COMPLETE:
                          var filteredStocks = controller.stockInventoryList.value.body!.productStock!.where((data) {
                            return controller.search.value.text.isEmpty || (data.product != null && data.product!.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Product Not Found") :
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: controller.stockInventoryList.value.body!.productStock!.length,
                            itemBuilder: (context, index) {
                              var stockInventory = controller.stockInventoryList.value.body!.productStock![index];
                              var name = stockInventory.product != null ? stockInventory.product!.name.toString() : '';
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.toLowerCase())) {
                                return StockInventoryTable(
                                  number: "${index + 1}",
                                  barcode: stockInventory.barcode ?? "0",
                                  product: stockInventory.product != null ? stockInventory.product!.name.toString() : "null",
                                  color: stockInventory.color != null ? stockInventory.color!.name.toString() : "Null",
                                  size: stockInventory.size != null ? stockInventory.size!.number.toString() : "Null" ,
                                  quantity: stockInventory.remainingQuantity != null ? stockInventory.remainingQuantity.toString() : "null",
                                  type: stockInventory.type?.name ?? "Null",
                                  brand: stockInventory.brand?.name ?? "Null",
                                  company: stockInventory.company?.name ?? "Null",
                                  heading: false,
                                  print: () {
                                    controller.printBarcode(context, stockInventory.barcode, stockInventory.product!.name, stockInventory.color!.name, stockInventory.size!.number.toString());
                                  },
                                  editOnpress: () {
                                    showDialog(
                                      useSafeArea: false,
                                      context: context,
                                      builder: (context) {
                                        selectBarCode = stockInventory.barcode != null ? stockInventory.barcode.toString() : "Null";
                                        selectProduct = stockInventory.product != null ? stockInventory.product!.name.toString() : "Null";
                                        selectCompany = stockInventory.company != null ? stockInventory.company!.name.toString() : "null";
                                        selectBrand = stockInventory.brand != null ? stockInventory.brand!.name.toString() : "null";
                                        selectType = stockInventory.type != null? stockInventory.type!.name.toString(): "null";
                                        selectColor = stockInventory.color != null ? stockInventory.color!.name.toString() : "null";
                                        selectSize = stockInventory.size != null? stockInventory.size!.number.toString(): "null";

                                        controller.company.value = stockInventory.companyId != null ? stockInventory.companyId.toString() : "null";
                                        controller.brand.value = stockInventory.brandId != null ? stockInventory.brandId.toString() : "null";
                                        controller.size.value = stockInventory.sizeId != null ? stockInventory.sizeId.toString() : "null";
                                        controller.color.value = stockInventory.colorId != null ? stockInventory.colorId.toString() : "null";
                                        controller.product.value = stockInventory.productId != null ? stockInventory.productId.toString() : "null";
                                        controller.type.value = stockInventory.typeId != null ? stockInventory.typeId.toString() : "null";
                                        controller.quantity.value.text = stockInventory.quantity != null ? stockInventory.quantity.toString() : "null";
                                        controller.barcode.value.text = stockInventory.barcode != null ? stockInventory.barcode.toString() : "null";
                                        return AlertDialog(
                                          title: const Text("Update Stock"),
                                          content: SingleChildScrollView(
                                            child: Form(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  AppTextField(
                                                    labelText: "Barcode",
                                                    controller: controller
                                                        .barcode.value,
                                                    enabled: false,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppDropDown(
                                                    labelText: "Select Product",
                                                    items: controller.productDropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                    selectedItem: selectProduct,
                                                    onChanged: (selectBrand) {
                                                      var product = controller.productDropdownItems.firstWhere((head) => head['name'].toString() == selectBrand, orElse: () => null,);
                                                      if (product != null) {
                                                        controller.product.value = product['id'].toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print('Expense Product not found');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppDropDown(
                                                    labelText: "Select Company",
                                                    items: controller.companyDropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                    selectedItem: selectCompany,
                                                    onChanged: (newSelectCompany) {
                                                      var company = controller.companyDropdownItems.firstWhere((head) => head['name'].toString() == newSelectCompany, orElse: () => null,);
                                                      if (company != null) {
                                                        controller.company.value = company['id'].toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print('Expense Company not found');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // brand
                                                  AppDropDown(
                                                    labelText: 'Select Brand',
                                                    items: controller.brandDropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                    selectedItem: selectBrand,
                                                    onChanged: (selectBrand) {
                                                      var brand = controller.brandDropdownItems.firstWhere((head) => head['name'].toString() == selectBrand, orElse: () => null,);
                                                      if (brand != null) {
                                                        controller.brand.value = brand['id'].toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print('Expense Brand not found');
                                                        }
                                                      }
                                                    },
                                                  ),

                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // type
                                                  AppDropDown(
                                                    labelText: 'Select Type',
                                                    items: const [
                                                      "Male",
                                                      "Female",
                                                      "Kids"
                                                    ],
                                                    selectedItem: selectType,
                                                    onChanged: (value) {
                                                      if (value == 'Male') {
                                                        '1';
                                                      } else if (value == 'Female') {
                                                        '2';
                                                      } else if (value == 'Kids') {
                                                        '3';
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // color
                                                  AppDropDown(
                                                    labelText: "Select Color",
                                                    items: controller.colorDropdownItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                                    selectedItem: selectColor,
                                                    onChanged: (selectColor) {
                                                      var color = controller.colorDropdownItems.firstWhere((head) => head['name'].toString() == selectColor, orElse: () => null,);
                                                      if (color != null) {
                                                        controller.color.value = color['id'].toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print('Expense Color not found');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppDropDown(
                                                    labelText: "Select Size",
                                                    items: controller.sizeDropdownItems.map<String>((item) => item['number'].toString()).toSet().toList(),
                                                    selectedItem: selectSize,
                                                    onChanged: (selectSize) {
                                                      var size = controller.sizeDropdownItems.firstWhere((head) => head['number'].toString() == selectSize, orElse: () => null,);
                                                      if (size != null) {
                                                        controller.size.value = size['id'].toString();
                                                      } else {
                                                        if (kDebugMode) {
                                                          print('Expense Size not found');
                                                        }
                                                        ;
                                                      }
                                                      ;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // quantity
                                                  AppTextField(
                                                    labelText: "Quantity",
                                                    controller: controller.quantity.value,
                                                    enabled: false,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    labelText: "AssignQuantity",
                                                    controller: controller.addNewQuantity.value,
                                                    onlyNumerical: true,
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
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.updateStockInventory(stockInventory.id.toString());
                                                  },
                                                  child: const Text("Update"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  deleteOnpress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return EditDialog(
                                            reject: () {
                                              Navigator.pop(context);
                                            },
                                            accept: () {
                                              controller.deleteStockInventory(stockInventory.id.toString());
                                            },
                                          );
                                        });
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.clearDropDown();
              return AlertDialog(
                title: const Text("Add Stock"),
                content: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppDropDown(
                          labelText: "Select Article",
                          items: controller.productDropdownItems
                              .map<String>((item) => item['name'].toString())
                              .toSet()
                              .toList(),
                          onChanged: (selectBrand) {
                            var product =
                                controller.productDropdownItems.firstWhere(
                              (head) => head['name'].toString() == selectBrand,
                              orElse: () => null,
                            );
                            if (product != null) {
                              controller.product.value =
                                  product['id'].toString();
                            } else {
                              if (kDebugMode) {
                                print('Expense Product not found');
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppDropDown(
                          labelText: "Select Company",
                          items: controller.companyDropdownItems
                              .map<String>((item) => item['name'].toString())
                              .toSet()
                              .toList(),
                          onChanged: (selectCompany) {
                            var company =
                                controller.companyDropdownItems.firstWhere(
                              (head) =>
                                  head['name'].toString() == selectCompany,
                              orElse: () => null,
                            );
                            if (company != null) {
                              controller.company.value =
                                  company['id'].toString();
                            } else {
                              if (kDebugMode) {
                                print('Expense Company not found');
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // brand
                        AppDropDown(
                          labelText: 'Select Brand',
                          items: controller.brandDropdownItems
                              .map<String>((item) => item['name'].toString())
                              .toSet()
                              .toList(),
                          onChanged: (selectBrand) {
                            var brand =
                                controller.brandDropdownItems.firstWhere(
                              (head) => head['name'].toString() == selectBrand,
                              orElse: () => null,
                            );
                            if (brand != null) {
                              controller.brand.value = brand['id'].toString();
                            } else {
                              if (kDebugMode) {
                                print('Expense Brand not found');
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            barcode.generateBarcode();
                          },
                          child: Obx(() {
                            // Directly observing the generatedBarcode observable
                            controller.barcode.value.text =
                                barcode.generatedBarcode.value;
                            return AppTextField(
                              labelText: "Barcode",
                              enabled: false,
                              suffixIcon:
                                  const Icon(Icons.generating_tokens_sharp),
                              controller: controller.barcode.value,
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppDropDown(
                          labelText: 'Select Type',
                          items: const ["Male", "Female", "Kids"],
                          onChanged: (value) {
                            if (value == 'Male') {
                              controller.type.value = '1';
                            } else if (value == 'Female') {
                              controller.type.value = '2';
                            } else if (value == 'Kids') {
                              controller.type.value = '3';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // color
                        AppDropDown(
                          labelText: "Select Color",
                          items: controller.colorDropdownItems
                              .map<String>((item) => item['name'].toString())
                              .toSet()
                              .toList(),
                          onChanged: (selectColor) {
                            var color =
                                controller.colorDropdownItems.firstWhere(
                              (head) => head['name'].toString() == selectColor,
                              orElse: () => null,
                            );
                            if (color != null) {
                              controller.color.value = color['id'].toString();
                            } else {
                              if (kDebugMode) {
                                print('Expense Color not found');
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // size
                        AppDropDown(
                            labelText: "Select Size",
                            items: controller.sizeDropdownItems
                                .map<String>(
                                    (item) => item['number'].toString())
                                .toSet()
                                .toList(),
                            onChanged: (selectSize) {
                              var size =
                                  controller.sizeDropdownItems.firstWhere(
                                (head) =>
                                    head['number'].toString() == selectSize,
                                orElse: () => null,
                              );
                              if (size != null) {
                                controller.size.value = size['id'].toString();
                              } else {
                                if (kDebugMode) {
                                  print('Expense Size not found');
                                }
                                ;
                              }
                              ;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        // quantity
                        AppTextField(
                          labelText: "Quantity",
                          controller: controller.quantity.value,
                          onlyNumerical: true,
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
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addStockInventory();
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
        label: const Text("Add Stock Inventory"),
      ),
    );
  }
}
