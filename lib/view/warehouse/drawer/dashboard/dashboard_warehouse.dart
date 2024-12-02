import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/list.dart';
import 'package:sofi_shoes/viewmodel/user_preference/local_storage.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_warehouse.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/general_execption_widget.dart';
import '../../../../res/widget/internet_execption_widget.dart';
import '../../../../res/widget/table/dashboard_table.dart';
import '../../../../viewmodel/warehouse/dashboard/w_dashboard_view_model.dart';

class DashBoardScreenWarehouse extends StatefulWidget {
  const DashBoardScreenWarehouse({super.key});

  @override
  State<DashBoardScreenWarehouse> createState() =>
      _DashBoardScreenWarehouseState();
}

class _DashBoardScreenWarehouseState extends State<DashBoardScreenWarehouse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final controller = Get.put(WDashboardViewModel());
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () async {
              await UserPreference().removeUser();
              Get.offAllNamed("/loginScreen");
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      backgroundColor: const Color(0xFFf3f3f3),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetWarehouse(),
            )
          : null,
      body: SafeArea(
        child: Row(
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
                    if (controller.error.value == 'No internet') {
                      return InterNetExceptionWidget(onPress: () {
                        return controller.refreshApi();
                      });
                    } else {
                      return GeneralExceptionWidget(
                          errorMessage: controller.error.value.toString(),
                          onPress: () {
                            controller.refreshApi();
                          });
                    }
                  case Status.COMPLETE:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            height: Theme.of(context).platform ==
                                    TargetPlatform.android
                                ? size.height * 0.23
                                : Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? size.height * 0.23
                                    : Theme.of(context).platform ==
                                            TargetPlatform.macOS
                                        ? size.height * 0.37
                                        : size.height * 0.28,
                            child: GridView.builder(
                              itemCount: listOfNameWarehouse.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: isDesktop ? 2 : 2,
                                      mainAxisExtent: isDesktop ? 110 : 75),
                              itemBuilder: (BuildContext context, int index) {
                                var data = controller.dashboardList.value.body;
                                final list = [
                                  data!.totalProducts == null
                                      ? '0'
                                      : data.totalProducts.toString(),
                                  data.totalBarcodes == null
                                      ? '0'
                                      : data.totalBarcodes.toString(),
                                  data.totalBranches == null
                                      ? '0'
                                      : data.totalBranches.toString(),
                                  data.totalClaims == null
                                      ? '0'
                                      : data.totalClaims.toString(),
                                ];
                                return AppBoxes(
                                  title: listOfNameWarehouse[index],
                                  amount: list[index],
                                  imageUrl: listOfIconWarehouse[index],
                                );
                              },
                            )),
                        Text(
                          "Most Product Sale",
                          style: GoogleFonts.lora(
                            fontSize: Responsive.isDesktop(context)
                                ? 25
                                : Responsive.isTablet(context)
                                    ? 18
                                    : Responsive.isMobile(context)
                                        ? 14
                                        : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DashboardTable(
                          number: "#",
                          artical: "Artical Name",
                          image: "Image",
                          category: "Category",
                          company: "Company",
                          brand: "Brand",
                          heading: true,
                          count: "Quantity",
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.dashboardList.value.body!
                                .mostRepeatedProducts!.length,
                            itemBuilder: (context, index) {
                              var data = controller.dashboardList.value.body!
                                  .mostRepeatedProducts![index];
                              return DashboardTable(
                                number: "${index + 1}",
                                artical: data.product != null ? data.product!.name.toString() : 'Null',
                                image: data.product != null ? data.product!.image.toString() : 'Null',
                                category: data.type != null ? data.type!.name.toString() : 'Null',
                                company: data.company != null ? data.company!.name.toString() : 'Null',
                                brand: data.brand != null ? data.brand!.name.toString() : 'Null',
                                heading: false,
                                count: data.totalQuantity.toString() ?? "0",
                              );
                            },
                          ),
                        ),
                      ],
                    );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
