import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofi_shoes/res/imageurl/image.dart';

import '../routes/routes_name.dart';
import '../widget/dot_text.dart';

class SideMenuWidgetWarehouse extends StatefulWidget {
  const SideMenuWidgetWarehouse({super.key});

  @override
  State<SideMenuWidgetWarehouse> createState() =>
      _SideMenuWidgetWarehouseState();
}

class _SideMenuWidgetWarehouseState extends State<SideMenuWidgetWarehouse> {
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
                  Get.offNamed(RoutesName.wdashboardScreenWareHouse);
                },
              ),
              // ListTile(
              //   leading: AppIcons(assetName: TImageUrl.iconBarcode),
              //   title: const Text(
              //     "Barcode Generator",
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              //   onTap: () {
              //     Get.offNamed(RoutesName.wgenerateBarcodeWareHouse);
              //   },
              // ),
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
                      Get.offNamed(RoutesName.wBrandScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Color"),
                    onTap: () {
                      Get.offNamed(RoutesName.wColorScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Size"),
                    onTap: () {
                      Get.offNamed(RoutesName.wsizeScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Products"),
                    onTap: () {
                      Get.offNamed(RoutesName.wProductScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Inventory"),
                    onTap: () {
                      Get.offNamed(RoutesName.wStockInventoryScreenWareHouse);
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
                    title: DotText(title: "Assign Stock to My Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.wAssignStockToMyWarehouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Branch"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wAssignStockToBranchScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to another warehouse"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wAssignToAnotherWarehouseWareHouse);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "Sale Invoice",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Sale Invoice"),
                    onTap: () {
                      Get.offNamed(
                        RoutesName.wSaleInvoiceScreen,
                      );
                    },
                  ),
                  // ListTile(
                  //   title: DotText(title: "Sale Invoice View"),
                  //   onTap: () {
                  //     Get.offNamed(
                  //       RoutesName.wSaleInvoiceScreenReport,
                  //     );
                  //   },
                  // ),
                  ListTile(
                    title: DotText(title: "Sale Return Invoice"),
                    onTap: () {
                      Get.offNamed(
                        RoutesName.wSaleReturn,
                      );
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Exchange Product"),
                    onTap: () {
                      Get.offNamed(
                        RoutesName.wExchangeProduct,
                      );
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
                      Get.offNamed(RoutesName.wPurchaseInvoiceScreen);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Purchase Invoice"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnPurchaseInvoiceScreen);
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: AppIcons(assetName: TImageUrl.iconAssignS),
                title: const Text(
                  "Returned Product",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  ListTile(
                    title: DotText(title: "Return Stock to Admin"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnStockToAdminWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Stock to Another Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnStockToAnotherWarehouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock From Warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnedStockFromWarehouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Returned Stock From Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnedStockFromBranch);
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
                    title: DotText(title: "Claims from Branch"),
                    onTap: () {
                      Get.offNamed(RoutesName.wClaimFromBranchWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claim from Another warehouse"),
                    onTap: () {
                      Get.offNamed(RoutesName.wClaimFromWarehouseWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claim to Admin"),
                    onTap: () {
                      Get.offNamed(RoutesName.wCliamToAdminWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claim to Another Warehouse"),
                    onTap: () {
                      Get.toNamed(RoutesName.claimToAnotherWarehouse);
                    },
                  ),
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
                    title: DotText(title: "My Warehouse Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.wMyWarehouseStock);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Warehouse Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.wWarehouseStockScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Branch Stock"),
                    onTap: () {
                      Get.offNamed(RoutesName.wBranchStockScreenWareHouse);
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
                  // ListTile(
                  //   title: DotText(title: "Barcodes report"),
                  //   onTap: () {
                  //     Get.offNamed(RoutesName.wBarcodeReportScreenWareHouse);
                  //   },
                  // ),
                  ListTile(
                    title: DotText(title: "Product report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wProductReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Report of Branches"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wStockBranchReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Report of Warehouse"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wStockWarehouseReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Stock Report of Other Warehouses"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wStockWarehouseOtherReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Branch Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wAssignStockBranchReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Assign Stock to Warehouse Report"),
                    onTap: () {
                      Get.offNamed(RoutesName
                          .wAssignStockWarehouseReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Stock to Admin Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wReturnStockAdminReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claims From Branch Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wClaimsFromBranchReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claims From Warehouse Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wClaimsFromWarhouseReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Claims To Admin Report"),
                    onTap: () {
                      Get.offNamed(
                          RoutesName.wClaimsToAdminReportScreenWareHouse);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wSaleInvoiceScreenReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Sale Return Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wSalReturnReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Exchange Product Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wExchangeProductReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Purchase Invoice Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wPurchaseInvoiceReport);
                    },
                  ),
                  ListTile(
                    title: DotText(title: "Return Purchase Invoice Report"),
                    onTap: () {
                      Get.offNamed(RoutesName.wReturnPurchaseInvoiceReport);
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
