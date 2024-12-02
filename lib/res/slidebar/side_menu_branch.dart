import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../imageurl/image.dart';
import '../routes/routes_name.dart';
import '../widget/dot_text.dart';

class SideMenuWidgetBranch extends StatefulWidget {
  const SideMenuWidgetBranch({super.key});

  @override
  State<SideMenuWidgetBranch> createState() => _SideMenuWidgetBranchState();
}

class _SideMenuWidgetBranchState extends State<SideMenuWidgetBranch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: const Color(0xff13132a),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    "Safi Shoes",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconDashboard),
                title: const Text(
                  "Dashboard",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.bDashboard);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconCustomer),
                title: const Text(
                  "Customer",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.bCustomer);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "Assign Stock",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Assigned Stock to this Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.bAssignSockToMyBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to other Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.bAssignStockToBranch);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconProduct),
                title: const Text(
                  "Product Return",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Return Product to Admin"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnProductToAdmin);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Product to Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnProductToWarehouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Product to Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnProductToBranch);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconSaleInvoice),
                title: const Text(
                  "Claims",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Claim to Admin"),
                    onTap: () {
                      Get.offNamed(RoutesName.adminClaimScreenBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claim to Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.branchClaimScreenBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claim to Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.warehouseClaimScreenBranch);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconSaleInvoice),
                title: const Text(
                  "Sale Invoice",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Sale Invoice"),
                    onTap: () {
                      Get.offNamed(RoutesName.saleScreenBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Return"),
                    onTap: () {
                      Get.offNamed(RoutesName.saleReturnScreenBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Exchange Product"),
                    onTap: () {
                      Get.offNamed(RoutesName.bExchangeProduct);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconTarget),
                title: const Text(
                  "Target",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.targetScreenBranch);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconExpense),
                title: const Text(
                  "Expense",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.branchExpensesScreenBranch);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconSalaries),
                title: const Text(
                  "Salesmen Salaries",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.salariesScreenBranch);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconStockPosition),
                title: Text(
                  "Stock Position",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Different Branches Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.branchStockScreenBranch);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "My Branch Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.bMyBranchStock);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconExpense),
                title: Text("Counter Cash",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Get.offNamed(RoutesName.bSaleExpenseGrossReport);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconReport),
                title: const Text(
                  "Report",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Sale Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bSaleReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Return Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bSaleReturnReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Exchange Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bExchangeProductReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Inventory Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bStockInventoryReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Branch Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.bAssignStockToAnotherBranchReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Stock to Admin Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnStockAdminReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Stock to Warehouse Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnStockWarehouseReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Stock to Branch Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bReturnStockBranchReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Admin Claim Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bAdminClaimReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Warehouse Claim Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bWarehouseClaimReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Claim Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bBranchClaimReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Target Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bTargetReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Expense Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bExpenseBranchReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Salaries Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bSalariesReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Salesman Sales Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.bSalemanSalariesReport);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppIcons extends StatelessWidget {
  AppIcons({required this.assetName, super.key});
  String assetName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: Colors.blue,
      ),
      child: Center(
        child: SvgPicture.asset(
          assetName,
          color: Colors.white,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}
