import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';

import '../../../../res/imageurl/image.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/tabletext/table_text.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../viewmodel/branch/target/branch_target_viewmodel.dart';

class TargetScreenBranch extends StatefulWidget {
  const TargetScreenBranch({super.key});

  @override
  State<TargetScreenBranch> createState() => _TargetScreenBranchState();
}

class _TargetScreenBranchState extends State<TargetScreenBranch> {
  TextEditingController datePicker = TextEditingController();
  DateTime? selectedDate;
  String selectValue = "";
  TextEditingController search = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        datePicker.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }


  double twoSumSubtract(String value1, double value2) {
    // Remove commas from the string and parse it as a double
    double value1Double = double.tryParse(value1.replaceAll(',', '')) ?? 0.0;

    // Perform the subtraction and return the result as a double
    return value2 - value1Double;
  }

  String _calculateRemainingAmount(String? targetAmount, double? totalSale) {
    // Step 1: Check for null values and parse the targetAmount safely
    if (targetAmount == null || targetAmount.isEmpty) {
      return "0"; // If targetAmount is null or empty, return "0"
    }

    // Step 2: Try to parse targetAmount as double
    double targetAmountParsed = 0.0;
    try {
      targetAmountParsed = double.parse(targetAmount.replaceAll(',', ''));  // Removing commas if any
    } catch (e) {
      return "0"; // If parsing fails, return "0"
    }

    // Step 3: Handle the tatalSale value
    double totalSaleParsed = totalSale ?? 0.0; // If totalSale is null, default to 0.0

    // Step 4: Compare and calculate the remaining amount
    if (targetAmountParsed <= totalSaleParsed) {
      return "0";  // If targetAmount is less than or equal to totalSale, return "0"
    } else {
      // Calculate the difference and format to 2 decimal places
      double remainingAmount = totalSaleParsed - targetAmountParsed;
      return remainingAmount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(BranchTargetViewModel());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetBranch(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: AppBoxes(
                            title: "Total Sale",
                            amount: controller.branchTargetList.value.body?.totalSale?.toStringAsFixed(0) ?? "0",
                            imageUrl: TImageUrl.imgProductT,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: AppBoxes(
                            title: "Total Target",
                            amount: controller.branchTargetList.value.body?.totalTarget.toString() ?? "0",
                            imageUrl: TImageUrl.imgsaleI,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(3),
                    },
                    border: TableBorder.all(
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
                            text: 'Date',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Target Amount',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Total Sale',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Target Remaining',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomTableCell(
                            text: 'Target Achieve',
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.LOADING:
                        return const Center(child: CircularIndicator.waveSpinkit);
                      case Status.ERROR:
                        return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshApi();
                          },
                        );
                      case Status.COMPLETE:
                        return controller.branchTargetList.value.body != null ?
                        ListView.builder(
                          itemCount: controller.branchTargetList.value.body!.dateList!.length,
                          itemBuilder: (context, index) {
                            var data = controller.branchTargetList.value.body!.dateList![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                  4: FlexColumnWidth(3),
                                  5: FlexColumnWidth(3),
                                },
                                border: TableBorder.all(
                                  color: Colors.grey.shade200,
                                ),
                                defaultColumnWidth: const FlexColumnWidth(0.5),
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    children: [
                                      CustomTableCell(
                                        text: '${index + 1}',
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.date != null ? data.date.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.targetAmount != null ? data.targetAmount.toString() : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: data.tatalSale != null? data.tatalSale?.toStringAsFixed(0) : "Null",
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: _calculateRemainingAmount(data.targetAmount, data.tatalSale),
                                        textColor: Colors.black,
                                      ),
                                      CustomTableCell(
                                        text: double.parse(data.tatalSale.toString().replaceAll(',', '')) <= double.parse(data.targetAmount.toString().replaceAll(',', '')) ? "Not Achieved" : "Achieved",
                                        textColor: double.parse(data.tatalSale.toString().replaceAll(',', '')) <= double.parse(data.targetAmount.toString().replaceAll(',', '')) ?
                                        Colors.red :
                                        Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ) :
                        Center(
                          child: Text(
                            "The admin has not assigned a monthly target to the branch.",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


