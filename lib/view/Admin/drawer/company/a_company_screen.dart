import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/company/export/company_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/company/widget/company_table.dart';
import 'package:sofi_shoes/viewmodel/admin/company/company_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../customer/widget/view_customer.dart';

class ACompanyScreen extends StatefulWidget {
  const ACompanyScreen({super.key});

  @override
  State<ACompanyScreen> createState() => _ACompanyScreenState();
}

class _ACompanyScreenState extends State<ACompanyScreen> {
  Future<void> refresh() async {
    Get.put(CompanyViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(CompanyViewModel()).getAllCompany();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyViewModel());
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Company"),
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
                  var filteredStocks = controller.companyList.value.body!.companies!.where((data) {
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
                                  labelText: "Search Company",
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
                                onTap: () => CompanyExport().printPdf(),
                              ))
                            ],
                          ),
                        ),
                        CompanyTable(
                          number: "#",
                          name: "Name",
                          email: "Email",
                          phoneNumber: "Last Balance",
                          heading: true,
                        ),
                        Expanded(
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Company Not Found") :
                          ListView.builder(
                            itemCount: controller.companyList.value.body!.companies!.length,
                            itemBuilder: (context, index) {
                              var company = controller.companyList.value.body!.companies![index];
                              var name = company.name.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return CompanyTable(
                                  number: "${index + 1}",
                                  name: company.name != null ? company.name.toString() : "null",
                                  email: company.email != null ? company.email.toString() : "null",
                                  phoneNumber: company.openingBalance != null ? company.openingBalance.toString() : "null",
                                  view: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ViewCustomer(
                                          title: "Company Detail",
                                          customerName: company.name != null ? company.name.toString() : "null",
                                          email: company.email != null
                                              ? company.email.toString()
                                              : "null",
                                          phoneNumber: company.phoneNumber !=
                                                  null
                                              ? company.phoneNumber.toString()
                                              : "null",
                                          address: company.address != null
                                              ? company.address.toString()
                                              : "null",
                                          opBalance:
                                              company.openingBalance != null
                                                  ? company.openingBalance
                                                      .toString()
                                                  : "null",
                                          date: company.currentDate != null
                                              ? company.currentDate.toString()
                                              : "null",
                                        );
                                      },
                                    );
                                  },
                                  heading: false,
                                  editOnpress: () {
                                    controller.name.value =
                                        TextEditingController(
                                            text: company.name);
                                    controller.address.value =
                                        TextEditingController(
                                            text: company.address);
                                    controller.phoneNumber.value =
                                        TextEditingController(
                                            text: company.phoneNumber);
                                    controller.email.value =
                                        TextEditingController(
                                            text: company.email);
                                    controller.openBalance.value =
                                        TextEditingController(
                                            text: company.openingBalance
                                                .toString());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Edit Company"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Form(
                                                    child: Column(
                                                  children: [
                                                    AppTextField(
                                                      controller:
                                                          controller.name.value,
                                                      labelText: "Name",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    AppTextField(
                                                      controller: controller
                                                          .email.value,
                                                      labelText: "Email",
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
                                                      controller: controller
                                                          .openBalance.value,
                                                      onlyNumerical: true,
                                                      labelText:
                                                          "Opening Balance",
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.updateCompany(
                                                        company.id.toString());
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
                                            controller.deleteCompany(
                                                company.id.toString());
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
              controller.clearField();
              return AlertDialog(
                title: const Text("Add Company"),
                content: Form(
                  child: SingleChildScrollView(
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
                        AppTextField(
                          controller: controller.email.value,
                          labelText: "Email",
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
                          controller: controller.openBalance.value,
                          labelText: "Opening Balance",
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
                          controller.addCompany();
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
        label: const Text("Add Company"),
      ),
    );
  }
}
