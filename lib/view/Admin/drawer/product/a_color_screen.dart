import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/res/widget/table/four_table.dart';
import 'package:sofi_shoes/viewmodel/admin/product/color_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import 'export/color_export.dart';

class AColorScreen extends StatefulWidget {
  const AColorScreen({super.key});

  @override
  State<AColorScreen> createState() => _AColorScreenState();
}

class _AColorScreenState extends State<AColorScreen> {
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
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(ColorViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color"),
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
                  var filteredStocks = controller.colorList.value.body!.colors!.where((data) {
                    return controller.search.value.text.isEmpty ||
                        (data.name != null && data.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                  }).toList();
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
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Color Not Found") :
                          ListView.builder(
                            itemCount: controller.colorList.value.body!.colors!.length,
                            itemBuilder: (context, index) {
                              var colors = controller.colorList.value.body!.colors![index];
                              var name = colors.name.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return FourTable(
                                  number: "${index + 1}",
                                  name: colors.name ?? "null",
                                  heading: false,
                                  onTapEdit: () {
                                    controller.name.value =
                                        TextEditingController(
                                            text: colors.name);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Update Color"),
                                            content: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      child: Column(
                                                        children: [
                                                          AppTextField(
                                                            controller:
                                                                controller
                                                                    .name.value,
                                                            labelText:
                                                                "Color Name",
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.updateColor(
                                                          colors.id.toString());
                                                    },
                                                    child: const Text("Update"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
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
                                            controller.deleteColor(
                                                colors.id.toString());
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
        label: const Text("Add Color"),
      ),
    );
  }
}
