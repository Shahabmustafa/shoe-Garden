import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/customer/export/customer_export.dart';
import 'package:sofi_shoes/view/Admin/drawer/customer/widget/customer_company_table.dart';
import 'package:sofi_shoes/viewmodel/admin/customer/customer_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/dialog/edit_dialog.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../Admin/drawer/customer/widget/view_customer.dart';

class MCustomerScreen extends StatefulWidget {
  const MCustomerScreen({super.key});

  @override
  State<MCustomerScreen> createState() => _MCustomerScreenState();
}

class _MCustomerScreenState extends State<MCustomerScreen> {
  Future<void> refreshCustomerList() async {
    Get.put(CustomerViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    Get.put(CustomerViewModel()).getAllCustomer();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerViewModel());
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetManager(),
            )
          : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetManager()) : Container(),
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
                  var filteredStocks = controller.customerList.value.body!.customers!.where((data) {
                    return controller.search.value.text.isEmpty ||
                        (data.name != null && data.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                  }).toList();
                  return RefreshIndicator(
                    onRefresh: refreshCustomerList,
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
                                  labelText: "Search Customer",
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
                                    onTap: () => CustomerExport().printPdf(),
                                  )),
                            ],
                          ),
                        ),
                        TableRowWidget(
                          number: "#",
                          one: "Name",
                          two: "Email",
                          three: "Last Balance",
                          heading: true,
                        ),
                        Expanded(
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "Customer Not Found") :
                          ListView.builder(
                            itemCount: controller.customerList.value.body!.customers!.length,
                            itemBuilder: (context, index) {
                              var customer = controller.customerList.value.body!.customers![index];
                              var name = customer.name.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.search.value.text.trim().toLowerCase())) {
                                return TableRowWidget(
                                  number: "${index + 1}",
                                  one: customer.name != null ? customer.name.toString() : "null",
                                  two: customer.email != null ? customer.email.toString() : "null",
                                  three: customer.openingBalance != null ? customer.openingBalance.toString() : "null",
                                  view: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ViewCustomer(
                                          title: "Customer Detail",
                                          customerName: customer.name != null ? customer.name.toString() : "null",
                                          email: customer.email != null ? customer.email.toString() : "null",
                                          phoneNumber: customer.phoneNumber != null ? customer.phoneNumber.toString() : "null",
                                          address: customer.address != null ? customer.address.toString() : "null",
                                          opBalance: customer.openingBalance != null ? customer.openingBalance.toString() : "null",
                                          date: customer.currentDate != null ? customer.currentDate.toString() : "null",
                                        );
                                      },
                                    );
                                  },
                                  heading: false,
                                  editOnpress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        controller.name.value =
                                            TextEditingController(
                                                text: customer.name);
                                        controller.email.value =
                                            TextEditingController(
                                                text: customer.email);
                                        controller.phoneNumber.value =
                                            TextEditingController(
                                                text: customer.phoneNumber);
                                        controller.address.value =
                                            TextEditingController(
                                                text: customer.address);
                                        controller.openBalance.value =
                                            TextEditingController(
                                                text: customer.openingBalance
                                                    .toString());
                                        return AlertDialog(
                                          title: const Text("Edit Customer"),
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
                                                          labelText:
                                                          "Opening Balance",
                                                          onlyNumerical: true,
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
                                                    controller.updateCustomer(
                                                        customer.id.toString());
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
                                            controller.deleteCustomer(
                                                customer.id.toString());
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
                title: const Text(
                  "Add Customer",
                ),
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
                        const SizedBox(
                          height: 10,
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
                          controller.addCustomer();
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddCompany()));
        },
        label: const Text("Add Customer"),
      ),
    );
  }
}
