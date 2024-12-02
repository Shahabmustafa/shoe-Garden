import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/slidebar/side_menu_admin.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/viewmodel/report/company_customer_ladger.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/imageurl/image.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/date_time_picker.dart';
import 'export/company_ledger_export.dart';

class CompanyLedgerReport extends StatefulWidget {
  const CompanyLedgerReport({super.key});

  @override
  State<CompanyLedgerReport> createState() => _CompanyLedgerReportState();
}

class _CompanyLedgerReportState extends State<CompanyLedgerReport> {
  Future<void> refresh() async {
    Get.put(LedgerViewModel()).refreshCompanyApi();
  }

  @override
  void initState() {
    Get.put(LedgerViewModel()).getCompanyLedger();
    super.initState();
  }

  String companyName = "Select Company Name";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LedgerViewModel());
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Ledger Report"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetAdmin()) : Container(),
          Expanded(
              flex: 8,
              child: Obx(() {
                switch (controller.rxCompanyRequestStatus.value) {
                  case Status.LOADING:
                    return const Center(child: CircularIndicator.waveSpinkit);
                  case Status.ERROR:
                    return GeneralExceptionWidget(
                        errorMessage: controller.error.value.toString(),
                        onPress: () {
                          controller.refreshCompanyApi();
                        });
                  case Status.COMPLETE:
                    return RefreshIndicator(
                      onRefresh: refresh,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DateTimePicker(
                                    hintText: 'From Date',
                                    onTap: () {
                                      controller.selectDateCompany(context, true);
                                    },
                                    controller: controller.startDate.value,
                                  ),
                                ),
                                const SizedBox(width: 10), // Spacer between the DateTimePickers
                                Expanded(
                                  child: DateTimePicker(
                                    hintText: 'To Date',
                                    onTap: () {
                                      controller.selectDateCompany(context, false);
                                    },
                                    controller: controller.endDate.value,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Obx((){
                                    return AppDropDown(
                                      labelText: "Select Company",
                                      selectedItem: companyName,
                                      items: controller.dropdownCompanyItems.map<String>((item) => item['name'].toString()).toSet().toList(),
                                      onChanged: (selectedCustomerName) {
                                        var selectedCustomer = controller.dropdownCompanyItems.firstWhere((bank) => bank['name'].toString() == selectedCustomerName, orElse: () => null,);
                                        if (selectedCustomer != null) {
                                          controller.selectCompany.value = selectedCustomer['id'].toString();
                                          companyName = selectedCustomer['id'].toString();
                                          controller.getCompanyLedger();
                                        } else {
                                          if (kDebugMode) {
                                            print('Customer not found');
                                          }
                                        }
                                      },
                                    );
                                  }),
                                ),
                                Flexible(
                                  child: AppExportButton(
                                    icons: Icons.add,
                                    onTap: () => CompanyLedgerExport().printPdf(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Flexible(
                                  child: AppBoxes(
                                    title: "Total First Balance",
                                    amount: controller.ledgerCompanyList.value.body?.overallFirstBalance.toString() ?? "0",
                                    imageUrl: TImageUrl.imgProductT,
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Flexible(
                                  child: AppBoxes(
                                    title: "Total Opening Balance",
                                    amount: controller.ledgerCompanyList.value.body?.overallOpeningBalance.toString() ?? "0",
                                    imageUrl: TImageUrl.imgPurchaseI,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.ledgerCompanyList.value.body!.companies!.length,
                                itemBuilder: (context, index) {
                                  var company = controller.ledgerCompanyList.value.body!.companies![index];
                                  return Card(
                                    elevation: 5,
                                    child: ExpansionTile(
                                      leading: Text("${index + 1}",style: TextStyle(color: Colors.black),),
                                      title: Text(company.name.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                      subtitle: Text(company.address?.toString() ?? "Null",style: TextStyle(fontSize: 14,color: Colors.grey),),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("First Balance   "+company.firstBalance.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: Colors.grey)),
                                          Text("Opening Balance   "+company.openingBalance.toString() ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: Colors.grey),),
                                        ],
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(2),
                                              2: FlexColumnWidth(2),
                                              3: FlexColumnWidth(2),
                                              4: FlexColumnWidth(2),
                                              5: FlexColumnWidth(2),
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
                                                    text: 'Description',
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomTableCell(
                                                    text: 'Date',
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomTableCell(
                                                    text: 'Payment Amount',
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomTableCell(
                                                    text: 'Purchase Amount',
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomTableCell(
                                                    text: 'Return Amount',
                                                    textColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),


                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(), // Prevent scrolling conflict
                                          itemCount: company.detail!.length,
                                          itemBuilder: (context, detailIndex) {
                                            final detail = company.detail![detailIndex];
                                            String dateString = detail.createdAt.toString();
                                            DateTime dateTime = DateTime.parse(dateString);
                                            DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm a');
                                            String formattedDate = formatter.format(dateTime.toLocal());
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                              child: Table(
                                                columnWidths: const {
                                                  0: FlexColumnWidth(1),
                                                  1: FlexColumnWidth(2),
                                                  2: FlexColumnWidth(2),
                                                  3: FlexColumnWidth(2),
                                                  4: FlexColumnWidth(2),
                                                  5: FlexColumnWidth(2),
                                                },
                                                border: TableBorder.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                defaultColumnWidth: const FlexColumnWidth(0.5),
                                                children: [
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    children: [
                                                      CustomTableCell(
                                                        text: "${detailIndex + 1}",
                                                        textColor: Colors.black,
                                                      ),
                                                      CustomTableCell(
                                                        text: detail.description.toString(),
                                                        textColor: Colors.black,
                                                      ),
                                                      CustomTableCell(
                                                        text: formattedDate,
                                                        textColor: Colors.black,
                                                      ),
                                                      CustomTableCell(
                                                        text: detail.payment.toString(),
                                                        textColor: Colors.black,
                                                      ),
                                                      CustomTableCell(
                                                        text: detail.purchase.toString(),
                                                        textColor: Colors.black,
                                                      ),
                                                      CustomTableCell(
                                                        text: detail.returnAmount.toString(),
                                                        textColor: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                }
              })),
        ],
      ),
    );
  }
}
