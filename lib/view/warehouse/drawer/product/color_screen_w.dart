import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_warehouse.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/res/widget/table/four_table.dart';
import 'package:sofi_shoes/viewmodel/admin/product/color_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Admin/drawer/product/export/color_export.dart';

class WColorScreen extends StatefulWidget {
  const WColorScreen({super.key});

  @override
  State<WColorScreen> createState() => _WColorScreenState();
}

class _WColorScreenState extends State<WColorScreen> {
  Future<void> refresh() async {
    Get.put(ColorViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(ColorViewModel()).getAllColor();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(ColorViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color"),
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
                                  labelText: "Search Color",
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
                                onTap: () => ColorExport().printPdf(),
                              )),
                            ],
                          ),
                        ),
                        FourTable(
                          number: "#",
                          name: "Color Name",
                          heading: true,
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              // Filter colors based on the search criteria
                              final filteredColors = controller.colorList.value.body!.colors!
                                  .where((color) {
                                return controller.search.value.text.isEmpty ||
                                    color.name!.toLowerCase().contains(controller.search.value.text.toLowerCase());
                              }).toList();

                              // Check if there are any filtered colors
                              if (filteredColors.isEmpty) {
                                return NotFoundWidget(title: "Color Not Found");
                              }

                              return ListView.builder(
                                itemCount: filteredColors.length,
                                itemBuilder: (context, index) {
                                  var color = filteredColors[index];
                                  return FourTable(
                                    number: "${index + 1}",
                                    name: color.name ?? "null",
                                    heading: false,
                                    onTapEdit: () {
                                      controller.name.value = TextEditingController(text: color.name);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Update Color"),
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
                                                            labelText: "Color Name",
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
                                                      controller.updateColor(color.id.toString());
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
                                    onTapDelete: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return EditDialog(
                                            reject: () {
                                              Navigator.pop(context);
                                            },
                                            accept: () {
                                              controller.deleteColor(color.id.toString());
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
                title: const Text("Add Color"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: controller.name.value,
                        labelText: 'Color',
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
                          controller.addColor();
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
        label: const Text("Color"),
      ),
    );
  }
}
