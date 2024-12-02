import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/view/Admin/drawer/company/widget/view_company.dart';
import 'package:sofi_shoes/view/Admin/drawer/customer/export/customer_export.dart';

import '../../../../date/response/status.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import '../../../../viewmodel/admin/customer/customer_viewmodel.dart';
import '../../../Manager/drawer/dashboard/dashboard_screen_a.dart';

class AdminCustomerReport extends StatefulWidget {
  const AdminCustomerReport({super.key});

  @override
  State<AdminCustomerReport> createState() => _AdminCustomerReportState();
}

class _AdminCustomerReportState extends State<AdminCustomerReport> {
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
        title: const Text("Customer Report"),
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
                                  labelText: "Search Customer",
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
                                  onTap: () => CustomerExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(3),
                              2: FlexColumnWidth(3),
                              3: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(
                              // borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade300,
                            ),
                            defaultColumnWidth: const FlexColumnWidth(0.5),
                            children: const [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Color(0xff13132a),
                                ),
                                children: [
                                  CustomTableCell(
                                    text: "#",
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Customer Name',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'Opening Balance',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTableCell(
                                    text: 'View',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller
                                .customerList.value.body!.customers!.length,
                            itemBuilder: (context, index) {
                              var customer = controller
                                  .customerList.value.body!.customers![index];
                              var name = customer.name!.toString();
                              if (controller.search.value.text.isEmpty ||
                                  name.toLowerCase().contains(controller
                                      .search.value.text
                                      .trim()
                                      .toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(3),
                                      2: FlexColumnWidth(3),
                                      3: FlexColumnWidth(1),
                                      4: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                      // borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                    defaultColumnWidth:
                                        const FlexColumnWidth(0.5),
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          CustomTableCell(
                                            text: "${index + 1}",
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: customer.name.toString(),
                                            textColor: Colors.black,
                                          ),
                                          CustomTableCell(
                                            text: customer.openingBalance
                                                .toString(),
                                            textColor: Colors.black,
                                          ),
                                          TableCell(
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewCustomer(
                                                      title: "Customer Detail",
                                                      companyName:
                                                          customer.name != null
                                                              ? customer.name
                                                                  .toString()
                                                              : "Null",
                                                      email:
                                                          customer.email != null
                                                              ? customer.email
                                                                  .toString()
                                                              : "Null",
                                                      phoneNumber: customer
                                                                  .phoneNumber !=
                                                              null
                                                          ? customer.phoneNumber
                                                              .toString()
                                                          : "Null",
                                                      address:
                                                          customer.address !=
                                                                  null
                                                              ? customer.address
                                                                  .toString()
                                                              : "Null",
                                                      opBalance: customer
                                                                  .openingBalance !=
                                                              null
                                                          ? customer
                                                              .openingBalance
                                                              .toString()
                                                          : "Null",
                                                      date: customer
                                                                  .currentDate !=
                                                              null
                                                          ? customer.currentDate
                                                              .toString()
                                                          : "Null",
                                                    );
                                                  },
                                                );
                                              },
                                              child: CustomIcon(
                                                icons: Icons.visibility,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
