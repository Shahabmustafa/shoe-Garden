import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/date/repository/branch/dashboard/branch_dashboard_repository.dart';
import 'package:sofi_shoes/viewmodel/user_preference/local_storage.dart';

import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/list.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_branch.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/table/dashboard_table.dart';

class BDashBoardScreen extends StatefulWidget {
  const BDashBoardScreen({super.key});

  @override
  State<BDashBoardScreen> createState() => _BDashBoardScreenState();
}

class _BDashBoardScreenState extends State<BDashBoardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
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
              child: SideMenuWidgetBranch(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetBranch()) : Container(),
            Expanded(
                flex: 8,
                child: FutureBuilder(
                  future: BranchDashboardRepository().getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While the data is loading
                      return const Center(child: CircularIndicator.waveSpinkit);
                    } else if (snapshot.hasError) {
                      // When there's an error
                      return Center(
                        child: Text(
                          'An error occurred: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.body == null ||
                        snapshot.data!.body!.mostRepeatedProducts == null ||
                        snapshot.data!.body!.mostRepeatedProducts!.isEmpty) {
                      var data = snapshot.data!.body!;
                      var list = [
                        data.totalProducts?.toString() ?? "0",
                        data.totalSaleInvoices?.toString() ?? "0",
                        data.todaySale?.toString() ?? "0",
                        data.todayTarget?.toString() ?? "0",
                        data.totalSaleman?.toString() ?? "0",
                        data.totalClaims?.toString() ?? "0",
                      ];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: Responsive.isDesktop(context) ? size.height * 0.36 : Responsive.isTablet(context) ? size.height * 0.44 : Responsive.isMobile(context) ? size.height * 0.32 : size.height * 0.34,
                            child: GridView.builder(
                              itemCount: listOfNameBranch.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: isDesktop ? 3 : 2, mainAxisExtent: isDesktop ? 110 : 75),
                              itemBuilder: (BuildContext context, int index) {
                                return AppBoxes(
                                  title: listOfNameBranch[index],
                                  amount: list[index],
                                  imageUrl: listOfIconBranch[index],
                                );
                              },
                            ),
                          ),
                          Text(
                            "Most Product Sale",
                            style: GoogleFonts.lora(
                              fontSize: Responsive.isDesktop(context) ? 25 : Responsive.isTablet(context) ? 18 : Responsive.isMobile(context) ? 14 : 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DashboardTable(
                            number: "#",
                            artical: "Article Name",
                            image: "Image",
                            category: "Category",
                            company: "Company",
                            brand: "Brand",
                            count: "Quantity",
                            heading: true,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.mostRepeatedProducts!.length,
                              itemBuilder: (context, index) {
                                var product = data.mostRepeatedProducts![index];
                                return DashboardTable(
                                  number: "${index + 1}",
                                  artical: product.product?.name.toString() ?? "Null",
                                  image: product.product?.image.toString() ?? "Null",
                                  category: product.type?.name.toString() ?? "Null",
                                  company: product.company?.name.toString() ?? "Null",
                                  brand: product.brand?.name.toString() ?? "Null",
                                  count: product.totalQuantity.toString(),
                                  heading: false,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      // When data exists
                      var data = snapshot.data!.body!;
                      var list = [
                        data.totalProducts?.toString() ?? "0",
                        data.totalSaleInvoices?.toString() ?? "0",
                        data.todaySale?.toString() ?? "0",
                        data.todayTarget?.toString() ?? "0",
                        data.totalSaleman?.toString() ?? "0",
                        data.totalClaims?.toString() ?? "0",
                      ];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: Responsive.isDesktop(context)
                                ? size.height * 0.36
                                : Responsive.isTablet(context)
                                    ? size.height * 0.44
                                    : Responsive.isMobile(context)
                                        ? size.height * 0.32
                                        : size.height * 0.34,
                            child: GridView.builder(
                              itemCount: listOfNameBranch.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: isDesktop ? 3 : 2,
                                      mainAxisExtent: isDesktop ? 110 : 75),
                              itemBuilder: (BuildContext context, int index) {
                                return AppBoxes(
                                  title: listOfNameBranch[index],
                                  amount: list[index],
                                  imageUrl: listOfIconBranch[index],
                                );
                              },
                            ),
                          ),
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
                          SizedBox(
                            height: 15,
                          ),
                          DashboardTable(
                            number: "#",
                            artical: "Article Name",
                            image: "Image",
                            category: "Category",
                            company: "Company",
                            brand: "Brand",
                            count: "Quantity",
                            heading: true,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.mostRepeatedProducts!.length,
                              itemBuilder: (context, index) {
                                var product = data.mostRepeatedProducts![index];
                                return DashboardTable(
                                  number: "${index + 1}",
                                  artical: product.product?.name.toString() ?? "Null",
                                  image: product.product?.image.toString() ??
                                      "Null",
                                  category:
                                      product.type?.name.toString() ?? "Null",
                                  company: product.company?.name.toString() ??
                                      "Null",
                                  brand:
                                      product.brand?.name.toString() ?? "Null",
                                  heading: false,
                                  count: product.totalQuantity.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
