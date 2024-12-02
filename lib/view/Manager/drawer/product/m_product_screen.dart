import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/export/product_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/widget/product_table.dart';
import 'package:sofi_shoes/viewmodel/admin/product/product_viewmodel.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class MProductScreen extends StatefulWidget {
  const MProductScreen({super.key});

  @override
  State<MProductScreen> createState() => _MProductScreenState();
}

class _MProductScreenState extends State<MProductScreen> {
  Future<void> refreshUserList() async {
    Get.put(ProductViewModel()).refreshForWarehouseApi();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(ProductViewModel()).getForWarehouseProduct();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(ProductViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetManager())
              : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AppTextField(
                          controller: controller.search.value,
                          labelText: "Search Product",
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
                            onTap: () => ProductExport().printPdf(),
                          )),
                    ],
                  ),
                ),
                ProductTable(
                  index: "#",
                  image: "Image",
                  productName: "Article Name",
                  salePrice: "Sale Price",
                  purchasePrice: "Purchase Price",
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
                              controller.refreshForWarehouseApi();
                            });
                      case Status.COMPLETE:
                        var filteredStocks = controller.productList.value.body!.products!.where((data) {
                          return controller.search.value.text.isEmpty ||
                              (data.name != null && data.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                        }).toList();
                        return filteredStocks.isEmpty ?
                        NotFoundWidget(title: "Product Not Found") :
                        ListView.builder(
                          itemCount: controller.productList.value.body!.products!.length,
                          itemBuilder: (context, index) {
                            var product = controller.productList.value.body!.products![index];
                            if (controller.search.value.text.isEmpty || product.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                              return ProductTable(
                                index: "${index + 1}",
                                productName: product.name ?? "null",
                                image: product != null ? product.image.toString() : "https://example.com/placeholder_image.png",
                                salePrice: product.salePrice?.toString() ?? "null",
                                purchasePrice: product.purchasePrice?.toString() ?? "null",
                                editOnpress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProductUpdate(
                                        userId: product.id.toString(),
                                        barcode: product.productCode.toString(),
                                        productName: product.name.toString(),
                                        salePrice: product.salePrice.toString(),
                                        purchasePrice:
                                        product.purchasePrice.toString(),
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
                                          controller.deleteProduct(product.id.toString());
                                        },
                                      );
                                    },
                                  );
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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Product"),
                content: SingleChildScrollView(
                  child: Form(
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: AppTextField(
                              controller: controller.articalName.value,
                              labelText: "Product Name",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: AppTextField(
                              controller: controller.salePrice.value,
                              labelText: "Sale Price",
                              onlyNumerical: true,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: AppTextField(
                              controller: controller.purchasePrice.value,
                              labelText: "Purchase Price",
                              onlyNumerical: true,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.camera_alt),
                                              title: const Text("Camera"),
                                              onTap: () {
                                                controller.getImage(
                                                    ImageSource.camera);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.photo),
                                              title: const Text("Gallery"),
                                              onTap: () {
                                                controller.getImage(
                                                    ImageSource.gallery);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: controller.pickImage.value?.path == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Please select an image',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                : kIsWeb
                                    ? Image.network(
                                        controller.pickImage.value!
                                            .path, // Safe access with !
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(controller.pickImage.value!
                                            .path), // Safe access with !
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                          ),
                        ],
                      ),
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
                          controller.addProducts(context);
                        },
                        child: ValueListenableBuilder<bool>(
                          valueListenable: controller.isLoading,
                          builder: (context, loading, child) {
                            if (loading) {
                              return Center(
                                  child: CircularIndicator.waveSpinkitButton);
                            } else {
                              return Text("Add");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add Product"),
      ),
    );
  }
}

class ProductUpdate extends StatelessWidget {
  ProductUpdate({
    required this.userId,
    required this.barcode,
    required this.productName,
    required this.salePrice,
    required this.purchasePrice,
    super.key,
  });

  String userId;
  String barcode;
  String productName;
  String salePrice;
  String purchasePrice;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductViewModel());
    controller.barcode.value = TextEditingController(text: barcode);
    controller.articalName.value = TextEditingController(text: productName);
    controller.salePrice.value = TextEditingController(text: salePrice);
    controller.purchasePrice.value = TextEditingController(text: purchasePrice);
    return AlertDialog(
      title: const Text("Update  "),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: AppTextField(
                  controller: controller.articalName.value,
                  labelText: "Article Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: AppTextField(
                  controller: controller.salePrice.value,
                  labelText: "Sale Price",
                  onlyNumerical: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: AppTextField(
                  controller: controller.purchasePrice.value,
                  labelText: "Purchase Price",
                  onlyNumerical: true,
                ),
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
                controller.updateProduct(userId);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ],
    );
  }
}
