import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/model/admin/dashboard_model.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/viewmodel/admin/dashboard/dashboard_viewmodel.dart';
import 'package:sofi_shoes/viewmodel/user_preference/local_storage.dart';

import '../../../../date/repository/admin/dashboard/dashboard_repository.dart';
import '../../../../res/list.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_manager.dart';
import '../../../../res/widget/app_boxes.dart';
import '../../../../res/widget/table/dashboard_table.dart';

class MDashBoardScreen extends StatefulWidget {
  const MDashBoardScreen({super.key});

  @override
  State<MDashBoardScreen> createState() => _MDashBoardScreenState();
}

class _MDashBoardScreenState extends State<MDashBoardScreen> {
  Future<void> refreshUserList() async {
    Get.put(DashboardViewModel()).refreshApi();
  }

  @override
  void initState() {
    super.initState();
    // UserPreference().getUser().then((value) {
    //   AdminApiUrl.accessToken = value.token;
    // });
    Get.put(DashboardViewModel()).getDashboard();
  }

  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(DashboardViewModel());
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: ()async{
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
              child: SideMenuWidgetManager(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            isDesktop
                ? const Expanded(flex: 2, child: SideMenuWidgetManager())
                : Container(),
            Expanded(
              flex: 8,
              child: FutureBuilder<ADashboardModel>(
                future: DashboardRepository().getAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                            itemCount: listOfNameA.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount:
                                  Responsive.isDesktop(context) ? 3 : 2,
                              mainAxisExtent: Responsive.isDesktop(context)
                                  ? 110
                                  : Responsive.isTablet(context)
                                      ? 90
                                      : Responsive.isMobile(context)
                                          ? 65
                                          : 65,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              var list = [
                                snapshot.data!.body!.totalProducts == null ? "0" : snapshot.data!.body!.totalProducts.toString(),
                                snapshot.data!.body!.totalSaleInvoices == null ? "0" : snapshot.data!.body!.totalSaleInvoices.toString(),
                                snapshot.data!.body!.totalPurchaseInvoices == null ? "0" : snapshot.data!.body!.totalPurchaseInvoices.toString(),
                                snapshot.data!.body!.totalWarehouses == null ? "0" : snapshot.data!.body!.totalWarehouses.toString(),
                                snapshot.data!.body!.totalBranches == null ? "0" : snapshot.data!.body!.totalBranches.toString(),
                                snapshot.data!.body!.totalSale == null ? "0" : snapshot.data!.body!.totalSale!.toStringAsFixed(2),
                              ];
                              return AppBoxes(
                                title: listOfNameA[index],
                                amount: list[index],
                                imageUrl: listOfIconA[index],
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
                        const SizedBox(
                          height: 15,
                        ),
                        DashboardTable(
                          number: "#",
                          artical: "Product Name",
                          image: "Image",
                          category: "Category",
                          company: "Company",
                          brand: "Brand",
                          heading: true,
                          count: "Quantity",
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot
                                .data!.body!.mostRepeatedProducts!.length,
                            itemBuilder: (context, index) {
                              var data = snapshot
                                  .data!.body!.mostRepeatedProducts![index];
                              var number = data.count != null
                                  ? data.count!.toString()
                                  : "null";
                              var artical = data.product != null
                                  ? data.product!.name.toString()
                                  : "null";
                              var code = data.product != null
                                  ? data.product!.productCode.toString()
                                  : "null";
                              var image = data.product != null
                                  ? data.product!.image.toString()
                                  : "null";
                              var category = data.type != null
                                  ? data.type!.name.toString()
                                  : "null";
                              var company = data.company != null
                                  ? data.company!.name.toString()
                                  : "null";
                              var brand = data.brand != null
                                  ? data.brand!.name.toString()
                                  : "null";
                              return DashboardTable(
                                number: "${index + 1}",
                                artical: artical,
                                image: image,
                                category: category,
                                company: company,
                                brand: brand,
                                heading: false,
                                count: data.count.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularIndicator.waveSpinkit);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData icons;
  final Color color;
  final VoidCallback? onTap;

  const CustomIcon({
    super.key,
    required this.icons,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Icon(
          icons,
          color: color,
          size: 15,
        )),
      ),
    );
  }
}
