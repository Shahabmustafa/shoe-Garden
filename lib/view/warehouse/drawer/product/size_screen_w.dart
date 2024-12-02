import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/widget/size_table.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/product/size_viewmodel.dart';
import '../../../Admin/drawer/product/export/size_export.dart';

class WSizeScreen extends StatefulWidget {
  const WSizeScreen({super.key});

  @override
  State<WSizeScreen> createState() => _WSizeScreenState();
}

class _WSizeScreenState extends State<WSizeScreen> {
  Future<void> refresh() async {
    Get.put(SizeViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(SizeViewModel()).getAllSize();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(SizeViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Size"),
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
                                  controller: controller.search.value,
                                  labelText: "Search Size",
                                  prefixIcon: Icon(Icons.search),
                                  onlyNumerical: true,
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
                                  onTap: () => SizeExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeTable(
                          number: "#",
                          size: "Size Number",
                          heading: true,
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              // Filter sizes based on the search criteria
                              final filteredSizes = controller.sizeList.value.body!.sizes!
                                  .where((size) {
                                var sizeValue = size.number.toString();
                                return controller.searchValue.value.isEmpty ||
                                    sizeValue.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase());
                              }).toList();

                              // Check if there are any filtered sizes
                              if (filteredSizes.isEmpty) {
                                return NotFoundWidget(title: "Size Not Found");
                              }

                              return ListView.builder(
                                itemCount: filteredSizes.length,
                                itemBuilder: (context, index) {
                                  var size = filteredSizes[index];
                                  return SizeTable(
                                    size: size.number.toString(),
                                    number: "${index + 1}",
                                    editOnpress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          controller.name.value =
                                              TextEditingController(text: size.number.toString());
                                          return AlertDialog(
                                            title: const Text("Edit Size"),
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
                                                            labelText: "Size Number",
                                                            onlyNumerical: true,
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
                                                      controller.updateSize(size.id.toString());
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
                                              controller.deleteSize(size.id.toString());
                                            },
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
                title: const Text("Add Size"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        labelText: 'Size Number',
                        controller: controller.name.value,
                        onlyNumerical: true,
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
                          controller.addSize();
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
        label: const Text("Add Size"),
      ),
    );
  }
}

class SizeController extends GetxController {
  RxString size = "".obs;
}
