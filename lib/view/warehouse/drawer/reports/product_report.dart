import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/admin/product/product_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Admin/drawer/product/export/product_export.dart';
import '../../../Admin/drawer/reports/widget/product_report_table.dart';

class WProductReportScreen extends StatefulWidget {
  const WProductReportScreen({super.key});

  @override
  State<WProductReportScreen> createState() => _WProductReportScreenState();
}

class _WProductReportScreenState extends State<WProductReportScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Report"),
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
                    return GeneralExceptionWidget(
                        errorMessage: controller.error.value.toString(),
                        onPress: () {
                          controller.refreshForWarehouseApi();
                        });
                  case Status.COMPLETE:
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Product",
                                  prefixIcon: Icon(Icons.search),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductReportTable(
                          index: "#",
                          image: "Company Name",
                          productName: "Product Name",
                          salePrice: "Sale Price",
                          purchasePrice: "Purchase Price",
                          heading: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller
                                .productList.value.body!.products!.length,
                            itemBuilder: (context, index) {
                              var product = controller
                                  .productList.value.body!.products![index];
                              var name = product.name!.toString();
                              if (controller.search.value.text.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .search.value.text
                                      .trim()
                                      .toLowerCase())) {
                                return ProductReportTable(
                                  index: "${index + 1}",
                                  image: product.image != null
                                      ? product.image.toString()
                                      : "null",
                                  productName: product.name != null
                                      ? product.name.toString()
                                      : "null",
                                  salePrice:
                                      product.salePrice.toString() ?? "null",
                                  purchasePrice:
                                      product.purchasePrice.toString() ??
                                          "null",
                                  heading: false,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                }
              })),
        ],
      ),
    );
  }
}