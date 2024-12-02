import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_branch.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/textfield/app_text_field.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/customer_report_table.dart';
import 'package:sofi_shoes/view/Branch/drawer/customer/export/customer_export.dart';
import 'package:sofi_shoes/viewmodel/admin/customer/customer_viewmodel.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/widget/not_found/not_found_widget.dart';

class BCustomerScreen extends StatefulWidget {
  const BCustomerScreen({super.key});

  @override
  State<BCustomerScreen> createState() => _BCustomerScreenState();
}

class _BCustomerScreenState extends State<BCustomerScreen> {
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
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(CustomerViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
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
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Name",
                                  search: true,
                                  prefixIcon: Icon(Icons.search),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.searchValue.value = value;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: AppExportButton(
                                  icons: Icons.add,
                                  onTap: () {
                                    PdfService().printPdf();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomerReportTable(
                          number: "#",
                          name: "Customer Name",
                          email: "Email",
                          phoneNUmber: "Phone Number",
                          address: "Address",
                          opBalance: "Opening Balance",
                          date: "Date",
                          heading: true,
                        ),
                        Expanded(
                          child: Obx(() {
                            // Get the list of customers
                            var customers = controller.customerList.value.body!.customers!;
                            // Filter customers based on the search input
                            var filteredCustomers = customers.where((customer) {
                              var name = customer.name!.toString().toLowerCase();
                              return controller.search.value.text.isEmpty || name.contains(controller.search.value.text.trim().toLowerCase());
                            }).toList();

                            // If no customers match the search, show the "Customer Not Found" message
                            if (filteredCustomers.isEmpty) {
                              return NotFoundWidget(
                                title: "Customer not Found",
                              );
                            }

                            // If there are matching customers, show the list
                            return ListView.builder(
                              itemCount: filteredCustomers.length,
                              itemBuilder: (context, index) {
                                var customer = filteredCustomers[index];
                                return CustomerReportTable(
                                  number: "${index + 1}",
                                  name: customer.name.toString(),
                                  email: customer.email.toString(),
                                  phoneNUmber: customer.phoneNumber.toString(),
                                  address: customer.address.toString(),
                                  opBalance: customer.openingBalance.toString(),
                                  date: customer.currentDate.toString(),
                                  heading: false,
                                );
                              },
                            );
                          }),
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

