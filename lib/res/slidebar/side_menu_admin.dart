import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/imageurl/image.dart';

import '../routes/routes_name.dart';
import '../widget/dot_text.dart';

class SideMenuWidgetAdmin extends StatefulWidget {
  const SideMenuWidgetAdmin({super.key});

  @override
  State<SideMenuWidgetAdmin> createState() => _SideMenuWidgetAdminState();
}

class _SideMenuWidgetAdminState extends State<SideMenuWidgetAdmin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Drawer(
      child: Container(
        height: size.height,
        color: const Color(0xff13132a),
        child: SingleChildScrollView(
          child: Column(
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
                  Get.offNamed(RoutesName.aDashboardScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconUser),
                title: const Text(
                  "User",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.aUserScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconCustomer),
                title: const Text(
                  "Customer",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.aCustomerScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconCompany),
                title: const Text(
                  "Company",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.aCompanyScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "All Sale Invoice",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.adminAllSaleInvoice);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconProduct),
                title: const Text(
                  "Product",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Brands"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBrandScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Color"),
                    onTap: () {
                      Get.offNamed(RoutesName.aColorScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Size"),
                    onTap: () {
                      Get.offNamed(RoutesName.aSizeScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Products"),
                    onTap: () {
                      Get.offNamed(RoutesName.aProductScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Inventory"),
                    onTap: () {
                      Get.offNamed(RoutesName.aStockInventoryScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "Assign Stock",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Assign Stock to Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.aAssignStockToWarehouseScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.aAssignStockToBranchScreen);
                    },
                  ),
                  ListTile(
                      title: DotText(title: "Stock Assigned to Branches"),
                      onTap: () {
                        Get.offNamed(
                            RoutesName.aApproveStockDifferentBranchScreen);
                      }),
                  ListTile(
                    title: DotText(title: "Stock Assigned to Warehouses"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.aApproveStockDifferentWarehouseScreen);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconSalemen),
                title: const Text(
                  "Salesman",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.aSalesmanScreen);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconExpense),
                title: const Text(
                  "Expense",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Expense Head"),
                    onTap: () {
                      Get.offNamed(RoutesName.aExpenseHeadScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Expense Detail"),
                    onTap: () {
                      Get.offNamed(RoutesName.aExpenseDetailScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Expenses"),
                    onTap: () {
                      Get.offNamed(RoutesName.aAllExpenseBranchScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconBank),
                title: const Text(
                  "Bank",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Bank Head"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBankHeadScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Bank Entry"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBankEntryScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "Purchase Invoice",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Purchase Invoice"),
                    onTap: () {
                      Get.offNamed(RoutesName.aPurchaseInvoiceScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Purchase Invoice"),
                    onTap: () {
                      Get.offNamed(RoutesName.aReturnPurchaseInvoiceScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconVoucher),
                title: const Text(
                  "Voucher",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Cash Voucher"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCashVoucherScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Payment Voucher"),
                    onTap: () {
                      Get.offNamed(RoutesName.aPaymentVoucherScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconClaim),
                title: const Text(
                  "Claims",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Warehouse Claim"),
                    onTap: () {
                      Get.offNamed(RoutesName.aWarehouseClaimScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Claim"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchClaimScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.aReturnedStockBranchScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.aReturnedStockWarehouseScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconStockPosition),
                title: const Text(
                  "Salaries",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "View Salaries"),
                    onTap: () {
                      Get.offNamed(RoutesName.aSalariesScreen);
                    },
                  ),
                  // ListTile(
                  //   title: DotText(title: "Set Sale %"),
                  //   onTap: () {
                  //     Get.offNamed(RoutesName.aSetSaleScreen);
                  //   },
                  // ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconStockPosition),
                title: const Text(
                  "Stock Position",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Warehouse Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.aWarehouseStockScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchStockScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconDiscount),
                title: const Text(
                  "Discount",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Product Wise Discount"),
                    onTap: () {
                      Get.offNamed(RoutesName.aProductWiseDiscountScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Wise Discount"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchWiseDiscountScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Target"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchTargetScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconReport),
                title: const Text(
                  "Report",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Purchase Invoice Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aPurchaseInvoiceReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Purchase Invoice Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aReturnPurchaseInvoiceReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "User Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aUserReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Customer Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCustomerReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Company Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCompanyReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "All Product Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aProductReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Inventory Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aStockInventoryReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Warehouse Wise Stock Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aWarehouseWiseStockReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Wise Stock Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchWiseStockReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assigned Stock to Warehouse Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aAssignStockWarehouseReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assigned Stock to Branch Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aAssignStockBranchReport);
                    },
                  ),
                  ListTile(
                    title:
                        DotText(title: "Stock Returned from Warehouse Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.aStockReturnedFromWarehouseReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Returned from Branch Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aStockReturnedFromBranchReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Salesman Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aSalesmanReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Expense Detail Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aExpenseDetailReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Wise Expense Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchExpenseReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Bank Entry Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBankEntryReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Cash Voucher Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCashVoucherReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Payment Voucher Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aPaymentVoucherReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Warehouse Claim Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aWarehouseClaimReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Claim Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchClaimReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Product Wise Discount Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aProductWiseDiscountReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Target Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aBranchTargetReportScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aSaleReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Return Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aSaleReturnReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Profit and Loss Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.aProfitOrLoss);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Company Ledger"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCompanyLadgerReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Customer Ledger"),
                    onTap: () {
                      Get.offNamed(RoutesName.aCustomerLadgerReport);
                    },
                  ),ListTile(
                    title: DotText(title: "Cash Counter Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.adminCashCounterReport);
                    },
                  ),
                  // ListTile(
                  //   title: DotText(title: "Date Wise Sale Report"),
                  //   onTap: () {},
                  // ),
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
