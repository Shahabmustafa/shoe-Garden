import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/res/widget/table/four_table.dart';
import 'package:sofi_shoes/viewmodel/admin/product/brand_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Admin/drawer/product/export/brand_export.dart';

class WBrandScreen extends StatefulWidget {
  const WBrandScreen({super.key});

  @override
  State<WBrandScreen> createState() => _WBrandScreenState();
}

class _WBrandScreenState extends State<WBrandScreen> {
  Future<void> refresh() async {
    Get.put(BrandViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(BrandViewModel()).getAllBrand();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(BrandViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brand"),
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
                  return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      });
                case Status.COMPLETE:
                  return RefreshIndicator(
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
                                  labelText: "Search Brand",
                                  prefixIcon: Icon(Icons.search),
                                  search: true,
                                  controller: controller.search.value,
                                  onChanged: (value) {
                                    setState(() {});
                                    controller.searchValue.value = value;
                                  },
                                ),
                              ),
                              Flexible(
                                  child: AppExportButton(
                                icons: Icons.add,
                                onTap: () => BrandExport().printPdf(),
                              )),
                            ],
                          ),
                        ),
                        FourTable(
                          number: "#",
                          name: "Brand Name",
                          heading: true,
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              // Filter brands based on the search criteria
                              final filteredBrands = controller.brandList.value.body!.brands!.where((brand) {
                                return controller.search.value.text.isEmpty || brand.name!.toLowerCase().contains(controller.search.value.text.toLowerCase());
                              }).toList();

                              // Check if there are any filtered brands
                              if (filteredBrands.isEmpty) {
                                return NotFoundWidget(title: "Brand Not Found");
                              }

                              return ListView.builder(
                                itemCount: filteredBrands.length,
                                itemBuilder: (context, index) {
                                  var brand = filteredBrands[index];
                                  return FourTable(
                                    number: "${index + 1}",
                                    name: brand.name ?? "null",
                                    heading: false,
                                    onTapDelete: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return EditDialog(
                                            reject: () {
                                              Navigator.pop(context);
                                            },
                                            accept: () {
                                              controller.deleteBrand(brand.id.toString());
                                            },
                                          );
                                        },
                                      );
                                    },
                                    onTapEdit: () {
                                      controller.name.value = TextEditingController(text: brand.name);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Update Brand"),
                                            content: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      child: Column(
                                                        children: [
                                                          AppTextField(
                                                            controller: controller.name.value,
                                                            labelText: "Brand Name",
                                                          ),
                                                        ],
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
                                                      controller.updateBrand(brand.id.toString());
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
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.name.value.clear();
              return AlertDialog(
                title: const Text("Add Brand"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        labelText: 'Brand Name',
                        controller: controller.name.value,
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
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addBrand();
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
        label: const Text("Add Brand"),
      ),
    );
  }
}
