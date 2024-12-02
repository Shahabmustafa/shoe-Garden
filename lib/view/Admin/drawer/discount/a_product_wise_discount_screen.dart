import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/discount/export/product_wise_discount_export.dart';
import 'package:sofi_shoes/viewmodel/admin/discount/product_wise_discount_viewmodel.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/utils/utils.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class AProductWiseDiscountScreen extends StatefulWidget {
  const AProductWiseDiscountScreen({super.key});

  @override
  State<AProductWiseDiscountScreen> createState() =>
      _AProductWiseDiscountScreenState();
}

class _AProductWiseDiscountScreenState
    extends State<AProductWiseDiscountScreen> {
  Future<void> refresh() async {
    Get.put(ProductWiseDiscountViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(ProductWiseDiscountViewModel()).getAll();
    Get.put(ProductWiseDiscountViewModel()).fetchProductName();
  }

  String? selectProduct;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(ProductWiseDiscountViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Wise Discount"),
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
            child: RefreshIndicator(
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
                            labelText: "Search Name",
                            prefixIcon: const Icon(Icons.search),
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
                          onTap: () => ProductWiseDiscountExport().printPdf(),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(2),
                        5: FlexColumnWidth(2),
                        6: FlexColumnWidth(2),
                        7: FlexColumnWidth(1),
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
                              text: 'Product Name',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Image',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Sale Price',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Purchase Price',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomTableCell(
                              text: 'Discount %',
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
                          var filteredStocks = controller.productWiseDiscountList.value.body!.productsDiscount!.where((data) {
                            return controller.search.value.text.isEmpty ||
                                (data.product != null && data.product!.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                          }).toList();
                          return filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Product Not Found") :
                          ListView.builder(
                            itemCount: controller.productWiseDiscountList.value.body?.productsDiscount?.length ?? 0,
                            itemBuilder: (context, index) {
                              var productWiseDiscount = controller.productWiseDiscountList.value.body!.productsDiscount![index];
                              var name = productWiseDiscount.product?.name?.toString() ?? '';
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
                                      7: FlexColumnWidth(1),
                                      8: FlexColumnWidth(1),
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
                                            text: '${index + 1}',
                                            textColor: Colors.black,
                                            height: 100,
                                            width: 150,
                                          ),
                                          CustomTableCell(
                                            text: productWiseDiscount.product?.name ?? "Null",
                                            textColor: Colors.black,
                                            height: 100,
                                            width: 150,
                                          ),
                                          CachedNetworkImage(
                                            height: 100,
                                            width: 150,
                                            fit: BoxFit.cover,
                                            imageUrl: productWiseDiscount.product?.image?.toString() ?? '',
                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                          CustomTableCell(
                                            text: productWiseDiscount.product?.salePrice?.toString() ?? "Null",
                                            textColor: Colors.black,
                                            height: 100,
                                            width: 150,
                                          ),
                                          CustomTableCell(
                                            text: productWiseDiscount.product?.purchasePrice?.toString() ?? "Null",
                                            textColor: Colors.black,
                                            height: 100,
                                            width: 150,
                                          ),
                                          CustomTableCell(
                                            text: productWiseDiscount.discount?.toString() ?? "Null",
                                            textColor: Colors.black,
                                            height: 100,
                                            width: 150,
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: productWiseDiscount.status == 1 ? Icons.check_circle_rounded : Icons.remove_circle,
                                              color: productWiseDiscount.status == 1 ? Colors.green : Colors.red,
                                            ),
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: CupertinoIcons.eyedropper,
                                              color: Colors.blue,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    selectProduct = productWiseDiscount.product?.name?.toString() ?? "Null";
                                                    controller.selectProduct.value = productWiseDiscount.productId?.toString() ?? "Null";
                                                    controller.discount.value = TextEditingController(text: productWiseDiscount.discount?.toString() ?? '');
                                                    controller.status.value = productWiseDiscount.status == 1;
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Update Product Wise Discount"),
                                                      content: StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                AppDropDown(
                                                                  labelText:
                                                                      "Select Product",
                                                                  selectedItem:
                                                                      selectProduct,
                                                                  items: controller
                                                                      .productDropDownItems
                                                                      .map<String>(
                                                                          (item) =>
                                                                              item['name'].toString())
                                                                      .toSet()
                                                                      .toList(),
                                                                  onChanged:
                                                                      (productWise) {
                                                                    var head = controller
                                                                        .productDropDownItems
                                                                        .firstWhere(
                                                                      (head) =>
                                                                          head['name']
                                                                              .toString() ==
                                                                          productWise,
                                                                      orElse: () =>
                                                                          null,
                                                                    );
                                                                    if (head !=
                                                                        null) {
                                                                      controller
                                                                          .selectProduct
                                                                          .value = head[
                                                                              'id']
                                                                          .toString();
                                                                    } else {
                                                                      print(
                                                                          'Product not found');
                                                                    }
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                AppTextField(
                                                                  controller:
                                                                      controller
                                                                          .discount
                                                                          .value,
                                                                  labelText:
                                                                      "Discount %",
                                                                  onlyNumerical:
                                                                      true,
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Obx(() {
                                                                  return SwitchListTile(
                                                                    title: const Text(
                                                                        "Status"),
                                                                    value: controller
                                                                        .status
                                                                        .value,
                                                                    onChanged:
                                                                        (value) {
                                                                      controller
                                                                          .status
                                                                          .value = value;
                                                                    },
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
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
                                                                double
                                                                    discountValue =
                                                                    double.parse(controller
                                                                        .discount
                                                                        .value
                                                                        .text);
                                                                if (discountValue >
                                                                        0.0 &&
                                                                    discountValue <
                                                                        99.0) {
                                                                  controller.updates(
                                                                      productWiseDiscount
                                                                          .id
                                                                          .toString());
                                                                } else {
                                                                  Utils.ErrorToastMessage(
                                                                      "Please add 0 to 99 Discount");
                                                                }
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
                                            ),
                                          ),
                                          TableCell(
                                            child: CustomIcon(
                                              icons: CupertinoIcons.delete,
                                              color: Colors.red,
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return EditDialog(
                                                      reject: () {
                                                        Navigator.pop(context);
                                                      },
                                                      accept: () {
                                                        controller.delete(
                                                            productWiseDiscount
                                                                .id
                                                                .toString());
                                                      },
                                                    );
                                                  },
                                                );
                                              },
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
          controller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Text("Add Product Wise Discount"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppDropDown(
                            labelText: "Select Product",
                            items: controller.productDropDownItems
                                .map<String>((item) => item['name'].toString())
                                .toSet()
                                .toList(),
                            onChanged: (prodcutWise) {
                              var head =
                                  controller.productDropDownItems.firstWhere(
                                (head) =>
                                    head['name'].toString() == prodcutWise,
                                orElse: () => null,
                              );
                              if (head != null) {
                                controller.selectProduct.value =
                                    head['id'].toString();
                              } else {
                                if (kDebugMode) {
                                  print('Expense Head not found');
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                            controller: controller.discount.value,
                            labelText: "Discount %",
                            onlyNumerical: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return SwitchListTile(
                              title: const Text("Status"),
                              value: controller.status.value,
                              onChanged: (value) {
                                controller.status.value = value;
                                print(controller.status.value);
                              },
                            );
                          }),
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
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              double discountValue =
                                  double.parse(controller.discount.value.text);

                              if (discountValue > 0.0 && discountValue < 99.0) {
                                controller.add();
                              } else {
                                Utils.ErrorToastMessage(
                                    "Please add 0 to 99 Discount");
                              }
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
        label: const Text("Add Product Wise Discount"),
      ),
    );
  }
}
