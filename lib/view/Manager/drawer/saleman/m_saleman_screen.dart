import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/saleman/export/saleman_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/saleman/widget/saleman_widget.dart';
import 'package:sofi_shoes/viewmodel/admin/salesman/salesman_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class MSalesmanScreen extends StatefulWidget {
  const MSalesmanScreen({super.key});

  @override
  State<MSalesmanScreen> createState() => _MSalesmanScreenState();
}

class _MSalesmanScreenState extends State<MSalesmanScreen> {
  Future<void> refreshSalemenList() async {
    Get.put(SalemenViewModel()).refreshApi();
  }

  String? selectBranch;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(SalemenViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salesmen"),
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
                    var filteredStocks = controller.salemenList.value.body!.saleMen!.where((data) {
                      return controller.search.value.text.isEmpty || (data.name != null && data.name!.toString().toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                    }).toList();
                    return RefreshIndicator(
                      onRefresh: refreshSalemenList,
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
                                    labelText: "Search Salesman",
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
                                    onTap: () => SalemanExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SalemanTable(
                            number: "#",
                            name: "Name",
                            phoneNumber: "Phone Number",
                            salary: "Salary",
                            address: "Address",
                            commission: "Commission",
                            branchName: "Branch",
                            heading: true,
                          ),
                          Expanded(
                            child: filteredStocks.isEmpty ?
                            NotFoundWidget(title: "Salesman Not Found") :
                            ListView.builder(
                              itemCount: controller.salemenList.value.body!.saleMen!.length,
                              itemBuilder: (context, index) {
                                var salemen = controller.salemenList.value.body!.saleMen![index];
                                var name = salemen.name.toString();
                                var branchName = controller.findBranchName(salemen.branchId.toString());
                                if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                  return SalemanTable(
                                    number: "${index + 1}",
                                    name: salemen.name?.toString() ?? "Nll",
                                    phoneNumber: salemen.phoneNumber?.toString() ?? "Null",
                                    address: salemen.address?.toString() ?? "Null",
                                    commission: salemen.commission?.toString() ?? "0",
                                    branchName: branchName ?? "Null",
                                    salary: salemen.salary?.toString() ?? "0",
                                    heading: false,
                                    editOnpress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          selectBranch = branchName;
                                          controller.selectBranch.value = salemen.branchId.toString();
                                          controller.name.value = TextEditingController(text: salemen.name);
                                          controller.phoneNumber.value = TextEditingController(text: salemen.phoneNumber);
                                          controller.address.value = TextEditingController(text: salemen.address);
                                          controller.salary.value = TextEditingController(text: salemen.salary.toString());
                                          controller.commission.value = TextEditingController(text: salemen.commission.toString());
                                          return AlertDialog(
                                            title: const Text("Update Salesman"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppTextField(
                                                    controller: controller.name.value,
                                                    labelText: "Name",
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppDropDown(
                                                    labelText: "Branch",
                                                    selectedItem: selectBranch,
                                                    items: controller
                                                        .dropdownItems
                                                        .map<String>((item) =>
                                                        item['name']
                                                            .toString())
                                                        .toSet()
                                                        .toList(),
                                                    onChanged:
                                                        (selectedBranchName) {
                                                      // Find the bank head with the selected name and print its ID
                                                      var selectedBranch =
                                                      controller
                                                          .dropdownItems
                                                          .firstWhere(
                                                            (bank) =>
                                                        bank['name']
                                                            .toString() ==
                                                            selectedBranchName,
                                                        orElse: () => null,
                                                      );
                                                      if (selectedBranch !=
                                                          null) {
                                                        controller.selectBranch
                                                            .value =
                                                            selectedBranch['id']
                                                                .toString();
                                                        print(
                                                            selectedBranch['id']
                                                                .toString());
                                                      } else {
                                                        if (kDebugMode) {
                                                          print(
                                                              'Customer not found');
                                                        }
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    controller: controller
                                                        .phoneNumber.value,
                                                    labelText: "Phone Number",
                                                    onlyNumerical: true,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    controller: controller
                                                        .address.value,
                                                    labelText: "Address",
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    controller:
                                                    controller.salary.value,
                                                    labelText: "Salary",
                                                    onlyNumerical: true,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AppTextField(
                                                    controller: controller
                                                        .commission.value,
                                                    labelText: "Commission",
                                                    // onlyNumerical: true,
                                                  ),
                                                ],
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
                                                      controller.updateSalemen(
                                                          salemen.id
                                                              .toString());
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
                                                controller.deleteSalemen(
                                                    salemen.id.toString());
                                              },
                                            );
                                          });
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
              })),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              controller.clear();
              return AlertDialog(
                title: const Text("Add Salesman"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: controller.name.value,
                        labelText: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppDropDown(
                        labelText: "Branch",
                        items: controller.dropdownItems
                            .map<String>((item) => item['name'].toString())
                            .toList(),
                        onChanged: (selectedBranchName) {
                          // Find the bank head with the selected name and print its ID
                          var selectedBranch =
                              controller.dropdownItems.firstWhere(
                            (bank) =>
                                bank['name'].toString() == selectedBranchName,
                            orElse: () => null,
                          );
                          if (selectedBranch != null) {
                            controller.selectBranch.value =
                                selectedBranch['id'].toString();
                            print(selectedBranch['id'].toString());
                          } else {
                            if (kDebugMode) {
                              print('Customer not found');
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.phoneNumber.value,
                        labelText: "Phone Number",
                        onlyNumerical: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.address.value,
                        labelText: "Address",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.salary.value,
                        labelText: "Salary",
                        onlyNumerical: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        controller: controller.commission.value,
                        labelText: "Commission",
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
                          controller.addSalemen();
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
        label: const Text("Add Salesman"),
      ),
    );
  }
}
