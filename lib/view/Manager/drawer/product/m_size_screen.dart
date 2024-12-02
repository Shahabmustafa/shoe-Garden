import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/export/size_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/widget/size_table.dart';

import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/product/size_viewmodel.dart';

class MSizeScreen extends StatefulWidget {
  const MSizeScreen({super.key});

  @override
  State<MSizeScreen> createState() => _MSizeScreenState();
}

class _MSizeScreenState extends State<MSizeScreen> {
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
    // final size = MediaQuery.sizeOf(context);
    final controller = Get.put(SizeViewModel());
    print("build All widget");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Size"),
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
                  var filteredStocks = controller.sizeList.value.body!.sizes!.where((data) {
                    return controller.search.value.text.isEmpty ||
                        (data.number != null && data.number!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
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
                                  labelText: "Search Size",
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
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Size Not Found") :
                          ListView.builder(
                            itemCount: controller.sizeList.value.body!.sizes!.length,
                            itemBuilder: (context, index) {
                              var size = controller.sizeList.value.body!.sizes![index];
                              var sizeVale = controller.sizeList.value.body!.sizes![index].number.toString();
                              if (controller.searchValue.value.isEmpty || sizeVale.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return SizeTable(
                                  size: size.number.toString(),
                                  number: "${index + 1}",
                                  editOnpress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          controller.name.value =
                                              TextEditingController(
                                                  text: size.number.toString());
                                          return AlertDialog(
                                            title: const Text("Edit Size"),
                                            content: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
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
                                        });
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
                                            controller
                                                .deleteSize(size.id.toString());
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
              return AlertDialog(
                title: const Text("Add Size"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        labelText: 'Size Number',
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
