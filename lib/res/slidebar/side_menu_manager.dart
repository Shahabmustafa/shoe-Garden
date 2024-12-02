import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../imageurl/image.dart';
import '../routes/routes_name.dart';
import '../widget/dot_text.dart';

class SideMenuWidgetManager extends StatefulWidget {
  const SideMenuWidgetManager({super.key});

  @override
  State<SideMenuWidgetManager> createState() => _SideMenuWidgetManagerState();
}

class _SideMenuWidgetManagerState extends State<SideMenuWidgetManager> {
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
                  Get.offNamed(RoutesName.mDashboardScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconCustomer),
                title: const Text(
                  "Customer",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.mCustomerScreen);
                },
              ),
              ListTile(
                leading: AppIcons(assetName: TImageUrl.iconCompany),
                title: const Text(
                  "Company",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.offNamed(RoutesName.mCompanyScreen);
                },
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconProduct),
                title: const Text(
                  "Product",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  // ListTile(
                  //   title: DotText(title: "Barcode"),
                  //   onTap: () {
                  //     Get.offNamed(RoutesName.mBarcodeScreen);
                  //   },
                  // ),
                  ListTile(
                    title: DotText(title: "Brands"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBrandScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Color"),
                    onTap: () {
                      Get.offNamed(RoutesName.mColorScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Size"),
                    onTap: () {
                      Get.offNamed(RoutesName.mSizeScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Products"),
                    onTap: () {
                      Get.offNamed(RoutesName.mProductScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Inventory"),
                    onTap: () {
                      Get.offNamed(RoutesName.mStockInventoryScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconProduct),
                title: const Text(
                  "Assign Stock",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Assign Stock to Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.mAssignStockToWarehouseScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.mAssignStockToBranchScreen);
                    },
                  ),
                  ListTile(
                      title: DotText(title: "Stock of Different Branches"),
                      onTap: () {
                        Get.offNamed(
                            RoutesName.mApproveStockDifferentBranchScreen);
                      }),
                  ListTile(
                    title: DotText(title: "Stock of Different Warehouses"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.mApproveStockDifferentWarehouseScreen);
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
                  Get.offNamed(RoutesName.mSalesmanScreen);
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
                      Get.offNamed(RoutesName.mExpenseHeadScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Expense Detail"),
                    onTap: () {
                      Get.offNamed(RoutesName.mExpenseDetailScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Expenses"),
                    onTap: () {
                      Get.offNamed(RoutesName.mAllExpenseBranchScreen);
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
                      Get.offNamed(RoutesName.mBankHeadScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Bank Entry"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBankEntryScreen);
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
                      Get.offNamed(RoutesName.mCashVoucherScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Payment Voucher"),
                    onTap: () {
                      Get.offNamed(RoutesName.mPaymentVoucherScreen);
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
                      Get.offNamed(RoutesName.mWarehouseClaimScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Claim"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBranchClaimScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.mReturnedStockBranchScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.mReturnedStockWarehouseScreen);
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
                      Get.offNamed(RoutesName.mSalariesScreen);
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
                      Get.offNamed(RoutesName.mPurchaseInvoiceScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Purchase Invoice"),
                    onTap: () {
                      Get.offNamed(RoutesName.mReturnPurchaseInvoiceScreen);
                    },
                  ),
                  // ListTile(
                  //   title: DotText(title: "Purchase Invoice View"),
                  //   onTap: () {
                  //     Get.offNamed(RoutesName.mPurchaseInvoiceReport);
                  //   },
                  // ),
                  // ListTile(
                  //   title: DotText(title: "Return Purchase Invoice View"),
                  //   onTap: () {
                  //     Get.offNamed(RoutesName.mReturnPurchaseInvoiceReport);
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
                      Get.offNamed(RoutesName.mWarehouseStockScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBranchStockScreen);
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
                      Get.offNamed(RoutesName.mProductWiseDiscountScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Wise Discount"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBranchWiseDiscountScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Target"),
                    onTap: () {
                      Get.offNamed(RoutesName.mBranchTargetScreen);
                    },
                  ),
                ],
              ),
              // ExpansionTile(
              //   leading: AppIcons(assetName: TImageUrl.iconReport),
              //   title: const Text(
              //     "Report",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   children: [
              //     ListTile(
              //       title: DotText(title: "User Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mUserReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Customer Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mCustomerReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Company Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mCompanyReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "All Product Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mProductReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Stock Inventory Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mStockInventoryReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Warehouse Wise Stock Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mWarehouseWiseStockReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Branch Wise Stock Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mBranchWiseStockReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Assigned Stock to Warehouse Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mAssignStockWarehouseReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Assigned Stock to Branch Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mAssignStockBranchReport);
              //       },
              //     ),
              //     ListTile(
              //       title:
              //       DotText(title: "Stock Returned from Warehouse Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mStockReturnedFromWarehouseReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Stock Returned from Branch Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mStockReturnedFromBranchReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Salesman Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mSalesmanReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Expense Detail Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mExpenseDetailReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Branch Wise Expense Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mBranchExpenseReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Bank Entry Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mBankEntryReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Cash Voucher Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mCashVoucherReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Payment Voucher Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mPaymentVoucherReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Warehouse Claim Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mWarehouseClaimReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Branch Claim Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mBranchClaimReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Product Wise Discount Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mProductWiseDiscountReportScreen);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Branch Target Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mBranchTargetReportScreen);
              //       },
              //     ),
              //     // ListTile(
              //     //   title: DotText(title: "Sale Report"),
              //     //   onTap: () {
              //     //     Get.offNamed(RoutesName.saleReport);
              //     //   },
              //     // ),
              //     // ListTile(
              //     //   title: DotText(title: "Sale Return Report"),
              //     //   onTap: () {
              //     //     Get.offNamed(RoutesName.saleReturnReport);
              //     //   },
              //     // ),
              //     ListTile(
              //       title: DotText(title: "Profit and Loss Report"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mProfitOrLoss);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Company Ledger"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mCompanyLadgerReport);
              //       },
              //     ),
              //     ListTile(
              //       title: DotText(title: "Customer Ledger"),
              //       onTap: () {
              //         Get.offNamed(RoutesName.mCustomerLadgerReport);
              //       },
              //     ),
              //     // ListTile(
              //     //   title: DotText(title: "Date Wise Sale Report"),
              //     //   onTap: () {},
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

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
