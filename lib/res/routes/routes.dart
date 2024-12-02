import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sofi_shoes/res/routes/routes_name.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/a_all_stock_of_different_branches.dart';
import 'package:sofi_shoes/view/Admin/drawer/asignstock/a_all_stock_of_different_warehouse.dart';
import 'package:sofi_shoes/view/Admin/drawer/claim/a_returned_stock_branch_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/claim/a_returned_stock_warehouse_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/product/a_barcode_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_assigned_stock_to_warehouse_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_branch_claims_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_branch_target_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_branch_wise_stock_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_cash_counter_report_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_cash_voucher_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_company_ledger.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_expense_detail_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_payment_voucher.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_product_wise_discount_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_profit_and_Loss_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_salesman_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_stock_inventory_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_stock_returned_from_branch_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_stock_returned_from_warehouse_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_user_report_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/admin_warehouse_claims_report.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/sale_report_screen.dart';
import 'package:sofi_shoes/view/Admin/drawer/sale_invoice/admin_all_sale_invoice.dart';
import 'package:sofi_shoes/view/Branch/drawer/customer/branch_customer_screen.dart';
import 'package:sofi_shoes/view/Branch/drawer/product/b_return_product_to_admin.dart';
import 'package:sofi_shoes/view/Branch/drawer/product/b_return_product_to_branch.dart';
import 'package:sofi_shoes/view/Branch/drawer/product/b_return_product_to_warehouse.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_category_wise_sale_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_return_stock_warehouse_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_salaries_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_sale_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_sale_return_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_saleman_sale_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_stock_inventory_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/b_target_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/exchange_product_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/reports/sale_expense_gross_report.dart';
import 'package:sofi_shoes/view/Branch/drawer/saleinvoice/exchange_product_screen.dart';
import 'package:sofi_shoes/view/Branch/drawer/stock%20position/my_branch_stock_screen.dart';
import 'package:sofi_shoes/view/Manager/drawer/product/m_barcode_screen.dart';
import 'package:sofi_shoes/view/warehouse/drawer/purchase%20invoice/w_purchase_invoice_screen.dart';
import 'package:sofi_shoes/view/warehouse/drawer/reports/w_sale_report.dart';
import 'package:sofi_shoes/view/warehouse/drawer/saleinvoice/saleReturn/w_sale_return.dart';

import '../../view/Admin/drawer/asignstock/a_asign_stock_warehouse_screen_a.dart';
import '../../view/Admin/drawer/asignstock/a_assign_stock_to_branch_screen.dart';
import '../../view/Admin/drawer/bank/a_bank_entry_screen.dart';
import '../../view/Admin/drawer/bank/a_bank_head_screen.dart';
import '../../view/Admin/drawer/claim/a_branch_claim_screen.dart';
import '../../view/Admin/drawer/claim/a_warehouse_claim_screen.dart';
import '../../view/Admin/drawer/company/a_company_screen.dart';
import '../../view/Admin/drawer/customer/a_customer_screen.dart';
import '../../view/Admin/drawer/dashboard/a_dashboard_screen.dart';
import '../../view/Admin/drawer/discount/a_branch_target_screen.dart';
import '../../view/Admin/drawer/discount/a_branch_wise_discount_screen.dart';
import '../../view/Admin/drawer/discount/a_product_wise_discount_screen.dart';
import '../../view/Admin/drawer/expense/a_branch_expense_screen.dart';
import '../../view/Admin/drawer/expense/a_expense_detail_screen.dart';
import '../../view/Admin/drawer/expense/a_expense_head_screen.dart';
import '../../view/Admin/drawer/product/a_brand_screen.dart';
import '../../view/Admin/drawer/product/a_color_screen.dart';
import '../../view/Admin/drawer/product/a_product_screen.dart';
import '../../view/Admin/drawer/product/a_size_screen.dart';
import '../../view/Admin/drawer/product/a_stock_screen.dart';
import '../../view/Admin/drawer/purchase invoice/admin_purchase_invoice_screen.dart';
import '../../view/Admin/drawer/purchase invoice/admin_return_purchase_invoice_screen.dart';
import '../../view/Admin/drawer/reports/admin_all_prdouct_report.dart';
import '../../view/Admin/drawer/reports/admin_assigned_stock_to_branch_report.dart';
import '../../view/Admin/drawer/reports/admin_bank_entry_report.dart';
import '../../view/Admin/drawer/reports/admin_branch_wise_expense_report.dart';
import '../../view/Admin/drawer/reports/admin_company_report.dart';
import '../../view/Admin/drawer/reports/admin_customer_ledger.dart';
import '../../view/Admin/drawer/reports/admin_customer_report.dart';
import '../../view/Admin/drawer/reports/admin_purchase_invoice_report.dart';
import '../../view/Admin/drawer/reports/admin_return_purchase_invoice_report.dart';
import '../../view/Admin/drawer/reports/admin_warehouse_wise_report.dart';
import '../../view/Admin/drawer/reports/sale_return_report_screen.dart';
import '../../view/Admin/drawer/salaries/a_set_sale_screen.dart';
import '../../view/Admin/drawer/salaries/a_view_salaries_screen.dart';
import '../../view/Admin/drawer/saleman/a_saleman_screen.dart';
import '../../view/Admin/drawer/stockposition/a_branch_stock_screen.dart';
import '../../view/Admin/drawer/stockposition/a_warehouse_stock_screen_a.dart';
import '../../view/Admin/drawer/user/a_user_screen.dart';
import '../../view/Admin/drawer/voucher/a_cash_voucher_screen.dart';
import '../../view/Admin/drawer/voucher/a_payment_voucher_screen.dart';
import '../../view/Branch/drawer/assign_stock/asign_stock_to_branch_screen.dart';
import '../../view/Branch/drawer/assign_stock/assign_stock_to_my_branch.dart';
import '../../view/Branch/drawer/claims/adminclaim/b_admin_claim_screen.dart';
import '../../view/Branch/drawer/claims/branchclaim/b_branch_claim_screen.dart';
import '../../view/Branch/drawer/claims/warehouseclaim/b_warehouse_claims_screen.dart';
import '../../view/Branch/drawer/dashboard/dashboard_branch.dart';
import '../../view/Branch/drawer/expense/branch_expense_screen.dart';
import '../../view/Branch/drawer/reports/b_admin_claim_report.dart';
import '../../view/Branch/drawer/reports/b_assign_stock_to_another_branch_report.dart';
import '../../view/Branch/drawer/reports/b_branch_claim_report.dart';
import '../../view/Branch/drawer/reports/b_expense_branch_report.dart';
import '../../view/Branch/drawer/reports/b_return_stock_admin_report.dart';
import '../../view/Branch/drawer/reports/b_return_stock_branch_report.dart';
import '../../view/Branch/drawer/reports/b_stock_position_report.dart';
import '../../view/Branch/drawer/reports/b_warehouse_claim_report.dart';
import '../../view/Branch/drawer/salaries/view_salary_screen_branch.dart';
import '../../view/Branch/drawer/saleinvoice/sale_return_screen_branch.dart';
import '../../view/Branch/drawer/saleinvoice/sale_screen.dart';
import '../../view/Branch/drawer/stock position/branch_stock_screen_branch.dart';
import '../../view/Branch/drawer/stock/stock_inventory_screen_branch.dart';
import '../../view/Branch/drawer/target/set_target_screen_branch.dart';
import '../../view/Manager/drawer/asignstock/m_all_stock_of_different_branches.dart';
import '../../view/Manager/drawer/asignstock/m_all_stock_of_different_warehouse.dart';
import '../../view/Manager/drawer/asignstock/m_asign_stock_warehouse_screen.dart';
import '../../view/Manager/drawer/asignstock/m_assign_stock_to_branch_screen.dart';
import '../../view/Manager/drawer/bank/m_bank_entry_screen.dart';
import '../../view/Manager/drawer/bank/m_bank_head_screen.dart';
import '../../view/Manager/drawer/claim/m_branch_claim_screen.dart';
import '../../view/Manager/drawer/claim/m_returned_stock_branch_screen.dart';
import '../../view/Manager/drawer/claim/m_returned_stock_warehouse_screen.dart';
import '../../view/Manager/drawer/claim/m_warehouse_claim_screen.dart';
import '../../view/Manager/drawer/company/m_company_screen.dart';
import '../../view/Manager/drawer/customer/m_customer_screen.dart';
import '../../view/Manager/drawer/dashboard/dashboard_screen_a.dart';
import '../../view/Manager/drawer/discount/m_branch_target_screen.dart';
import '../../view/Manager/drawer/discount/m_branch_wise_discount_screen.dart';
import '../../view/Manager/drawer/discount/m_product_wise_discount_screen.dart';
import '../../view/Manager/drawer/expense/m_branch_expense_screen.dart';
import '../../view/Manager/drawer/expense/m_expense_detail_screen.dart';
import '../../view/Manager/drawer/expense/m_expense_head_screen.dart';
import '../../view/Manager/drawer/product/m_brand_screen.dart';
import '../../view/Manager/drawer/product/m_color_screen.dart';
import '../../view/Manager/drawer/product/m_product_screen.dart';
import '../../view/Manager/drawer/product/m_size_screen.dart';
import '../../view/Manager/drawer/product/m_stock_screen.dart';
// import '../../view/Manager/drawer/reports/m_bank_entry_report.dart';
// import '../../view/Manager/drawer/reports/m_branch_claims_report.dart';
// import '../../view/Manager/drawer/reports/m_branch_target_report.dart';
// import '../../view/Manager/drawer/reports/m_branch_wise_expense_report.dart';
// import '../../view/Manager/drawer/reports/m_branch_wise_stock_report.dart';
// import '../../view/Manager/drawer/reports/m_cash_voucher_report.dart';
// import '../../view/Manager/drawer/reports/m_company_ledger.dart';
// import '../../view/Manager/drawer/reports/m_customer_ledger.dart';
// import '../../view/Manager/drawer/reports/m_expense_detail_report.dart';
// import '../../view/Manager/drawer/reports/m_payment_voucher.dart';
// import '../../view/Manager/drawer/reports/m_product_wise_discount_report.dart';
// import '../../view/Manager/drawer/reports/m_profit_and_Loss_report.dart';
// import '../../view/Manager/drawer/reports/m_salesman_report.dart';
// import '../../view/Manager/drawer/reports/m_stock_inventory_report.dart';
// import '../../view/Manager/drawer/reports/m_stock_returned_from_branch_report.dart';
// import '../../view/Manager/drawer/reports/m_stock_returned_from_warehouse_report.dart';
// import '../../view/Manager/drawer/reports/m_warehouse_claims_report.dart';
// import '../../view/Manager/drawer/reports/m_warehouse_wise_report.dart';
import '../../view/Manager/drawer/purchase invoice/m_purchase_invoice_screen.dart';
import '../../view/Manager/drawer/purchase invoice/m_return_purchase_invoice_screen.dart';
import '../../view/Manager/drawer/salaries/m_set_sale_screen.dart';
import '../../view/Manager/drawer/salaries/m_view_salaries_screen.dart';
import '../../view/Manager/drawer/saleman/m_saleman_screen.dart';
import '../../view/Manager/drawer/stockposition/m_branch_stock_screen.dart';
import '../../view/Manager/drawer/stockposition/m_warehouse_stock_screen_a.dart';
import '../../view/Manager/drawer/voucher/m_cash_voucher_screen_a.dart';
import '../../view/Manager/drawer/voucher/m_payment_voucher_screen_a.dart';
import '../../view/auth/login_screen.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/warehouse/drawer/Assign stock/assign_stock_to_branch_screen_w.dart';
import '../../view/warehouse/drawer/Assign stock/assign_stock_to_my_warehouse.dart';
import '../../view/warehouse/drawer/Assign stock/assign_stock_to_warehouse_w.dart';
import '../../view/warehouse/drawer/Assign stock/returned_stock_from_branch_screen_w.dart';
import '../../view/warehouse/drawer/Assign stock/returned_stock_from_warehouse_screen_w.dart';
import '../../view/warehouse/drawer/Assign stock/returned_stock_to_warehouse_w.dart';
import '../../view/warehouse/drawer/Assign stock/stock_return_stock_admin_w.dart';
import '../../view/warehouse/drawer/barcode/generate_barcode.dart';
import '../../view/warehouse/drawer/claim/claim_from_branch_screen_w.dart';
import '../../view/warehouse/drawer/claim/claim_from_warehouse_w.dart';
import '../../view/warehouse/drawer/claim/claim_to_admin_w.dart';
import '../../view/warehouse/drawer/claim/claim_to_warehouse_w.dart';
import '../../view/warehouse/drawer/dashboard/dashboard_warehouse.dart';
import '../../view/warehouse/drawer/product/brand_screen_w.dart';
import '../../view/warehouse/drawer/product/color_screen_w.dart';
import '../../view/warehouse/drawer/product/product_screen_w.dart';
import '../../view/warehouse/drawer/product/size_screen_w.dart';
import '../../view/warehouse/drawer/product/stock_screen_w.dart';
import '../../view/warehouse/drawer/purchase invoice/w_return_purchase_invoice_screen.dart';
import '../../view/warehouse/drawer/reports/assign_stock_branch_report_screen.dart';
import '../../view/warehouse/drawer/reports/assign_stock_warehouse_report_screen.dart';
import '../../view/warehouse/drawer/reports/claims_from_branch_report_screen.dart';
import '../../view/warehouse/drawer/reports/claims_from_warehouse_report_screen.dart';
import '../../view/warehouse/drawer/reports/claims_to_admin_report_screen.dart';
import '../../view/warehouse/drawer/reports/my_stock_warehouse_report_screen.dart';
import '../../view/warehouse/drawer/reports/product_report.dart';
import '../../view/warehouse/drawer/reports/return_stock_admin_report_screen.dart';
import '../../view/warehouse/drawer/reports/stock_branch_report_screen.dart';
import '../../view/warehouse/drawer/reports/stock_warehouse_other_report_screen.dart';
import '../../view/warehouse/drawer/reports/w_exchange_product_report.dart';
import '../../view/warehouse/drawer/reports/w_purchase_invoice_report.dart';
import '../../view/warehouse/drawer/reports/w_returned_purchase_invoice_report.dart';
import '../../view/warehouse/drawer/reports/w_sale_return_report.dart';
import '../../view/warehouse/drawer/saleinvoice/exchangeProduct/wexchange_product_view.dart';
import '../../view/warehouse/drawer/saleinvoice/saleinvoice/warehouse_add_sale_screen.dart';
import '../../view/warehouse/drawer/stockposition/branch_stock_screen_w.dart';
import '../../view/warehouse/drawer/stockposition/my_warehouse_stock.dart';
import '../../view/warehouse/drawer/stockposition/warehouse_stock_screen_w.dart';

class Routes {
  static adminRoutes() => [
    /* this Routes for Authentication and Splash screen */

    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => const LoginScreen(),
    ),

    /* this Routes for Admin side */
    /// Admin Routes // Admin Routes // Admin Routes // Admin Routes // Admin Routes
    /// Admin Routes // Admin Routes // Admin Routes // Admin Routes // Admin Routes
    /// Admin Routes // Admin Routes // Admin Routes // Admin Routes // Admin Routes
    /// Admin Routes // Admin Routes // Admin Routes // Admin Routes // Admin Routes
    ///
    GetPage(
      name: RoutesName.aDashboardScreen,
      page: () => const ADashBoardScreen(),
    ),
    GetPage(
      name: RoutesName.aUserScreen,
      page: () => const AUserScreen(),
    ),
    GetPage(
      name: RoutesName.aCustomerScreen,
      page: () => const ACustomerScreen(),
    ),
    GetPage(
      name: RoutesName.aCompanyScreen,
      page: () => const ACompanyScreen(),
    ),
    GetPage(
      name: RoutesName.aBarcodeScreen,
      page: () => const BarcodeScreenAdmin(),
    ),

    GetPage(
      name: RoutesName.aBrandScreen,
      page: () => const ABrandScreen(),
    ),
    GetPage(
      name: RoutesName.aColorScreen,
      page: () => const AColorScreen(),
    ),
    GetPage(
      name: RoutesName.aSizeScreen,
      page: () => const ASizeScreen(),
    ),
    GetPage(
      name: RoutesName.aProductScreen,
      page: () => const AProductScreen(),
    ),
    GetPage(
      name: RoutesName.aStockInventoryScreen,
      page: () => const AStockInventoryScreen(),
    ),
    GetPage(
      name: RoutesName.aAssignStockToWarehouseScreen,
      page: () => const AAssignStockToWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.aAssignStockToBranchScreen,
      page: () => const AAssignStockToBranchScreen(),
    ),
    GetPage(
      name: RoutesName.aApproveStockDifferentWarehouseScreen,
      page: () => const AApproveStockDifferentWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.aApproveStockDifferentBranchScreen,
      page: () => const AApproveStockDifferentBranchScreen(),
    ),

    GetPage(
      name: RoutesName.aSalesmanScreen,
      page: () => const ASalesmanScreen(),
    ),
    GetPage(
      name: RoutesName.aExpenseHeadScreen,
      page: () => const AExpenseHeadScreen(),
    ),
    GetPage(
      name: RoutesName.aExpenseDetailScreen,
      page: () => const AExpenseDetailScreen(),
    ),
    GetPage(
      name: RoutesName.aAllExpenseBranchScreen,
      page: () => const AAllBranchExpensesScreen(),
    ),
    GetPage(
      name: RoutesName.aBankHeadScreen,
      page: () => const ABankHeadScreen(),
    ),
    GetPage(
      name: RoutesName.aBankEntryScreen,
      page: () => const ABankEntryScreen(),
    ),
    GetPage(
      name: RoutesName.aCashVoucherScreen,
      page: () => const ACashVoucherScreen(),
    ),
    GetPage(
      name: RoutesName.aPaymentVoucherScreen,
      page: () => const APaymentVoucherScreen(),
    ),
    GetPage(
      name: RoutesName.aWarehouseClaimScreen,
      page: () => const AWarehouseClaimScreen(),
    ),
    GetPage(
      name: RoutesName.aBranchClaimScreen,
      page: () => const ABranchClaimScreen(),
    ),
    GetPage(
      name: RoutesName.aReturnedStockWarehouseScreen,
      page: () => const AReturnedStockWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.aReturnedStockBranchScreen,
      page: () => const AReturnedStockBranchScreen(),
    ),

    GetPage(
      name: RoutesName.aSalariesScreen,
      page: () => const ASalariesScreen(),
    ),
    GetPage(
      name: RoutesName.aSetSaleScreen,
      page: () => const ASetSaleScreen(),
    ),
    GetPage(
      name: RoutesName.aWarehouseStockScreen,
      page: () => const AWarehouseStockScreen(),
    ),
    GetPage(
      name: RoutesName.aBranchStockScreen,
      page: () => const ABranchStockScreen(),
    ),
    GetPage(
      name: RoutesName.aProductWiseDiscountScreen,
      page: () => const AProductWiseDiscountScreen(),
    ),
    GetPage(
      name: RoutesName.aBranchWiseDiscountScreen,
      page: () => const ABranchWiseDiscountScreen(),
    ),
    GetPage(
      name: RoutesName.aBranchTargetScreen,
      page: () => const ABranchTargetScreen(),
    ),

    GetPage(
      name: RoutesName.aUserReportScreen,
      page: () => const UserReport(),
    ),

    GetPage(
      name: RoutesName.aCustomerReportScreen,
      page: () => const AdminCustomerReport(),
    ),

    GetPage(
      name: RoutesName.aCompanyReportScreen,
      page: () => const AdminCompanyReport(),
    ),

    GetPage(
      name: RoutesName.aProductReportScreen,
      page: () => const AdminProductReport(),
    ),
    GetPage(
      name: RoutesName.aStockInventoryReportScreen,
      page: () => const AdminStockInventoryReport(),
    ),
    GetPage(
      name: RoutesName.aSalesmanReportScreen,
      page: () => const AdminSalesmanReport(),
    ),
    GetPage(
      name: RoutesName.aExpenseDetailReportScreen,
      page: () => const AdminExpenseDetailReport(),
    ),
    GetPage(
      name: RoutesName.aBranchExpenseReportScreen,
      page: () => const AdminBranchExpenseReport(),
    ),
    GetPage(
      name: RoutesName.aBankEntryReportScreen,
      page: () => const AdminBankEntryReport(),
    ),
    GetPage(
      name: RoutesName.aCashVoucherReportScreen,
      page: () => const AdminCashVoucherReport(),
    ),

    GetPage(
      name: RoutesName.aPaymentVoucherReportScreen,
      page: () => const AdminPaymentVoucherReport(),
    ),

    GetPage(
      name: RoutesName.aProductWiseDiscountReportScreen,
      page: () => const AdminProductWiseDiscountReport(),
    ),
    GetPage(
      name: RoutesName.aBranchWiseDiscountReportScreen,
      page: () => const AdminProductWiseDiscountReport(),
    ),
    GetPage(
      name: RoutesName.aBranchTargetReportScreen,
      page: () => const AdminBranchTargetReport(),
    ),
    GetPage(
      name: RoutesName.aAssignStockBranchReport,
      page: () => const AdminAssignStockBranchReport(),
    ),
    GetPage(
      name: RoutesName.aAssignStockWarehouseReport,
      page: () => const AdminAssignStockWarehouseReport(),
    ),

    GetPage(
      name: RoutesName.aWarehouseClaimReport,
      page: () => const AWarehouseCliamReport(),
    ),
    GetPage(
      name: RoutesName.aBranchClaimReport,
      page: () => const ABranchClaimReport(),
    ),

    GetPage(
      name: RoutesName.aWarehouseWiseStockReport,
      page: () => const AWarehouseWiseStockReport(),
    ),
    GetPage(
      name: RoutesName.aBranchWiseStockReport,
      page: () => const ABranchWiseStockReport(),
    ),

    GetPage(
      name: RoutesName.aStockReturnedFromWarehouseReport,
      page: () => const AReturnedStockWarehouseReportScreen(),
    ),
    GetPage(
      name: RoutesName.aStockReturnedFromBranchReport,
      page: () => const AReturnedStockBranchReportScreen(),
    ),
    GetPage(
      name: RoutesName.aCustomerLadgerReport,
      page: () => const CustomerLegerReport(),
    ),
    GetPage(
      name: RoutesName.aCompanyLadgerReport,
      page: () => const CompanyLedgerReport(),
    ),

    GetPage(
      name: RoutesName.aCompanyLadgerReport,
      page: () => const CompanyLedgerReport(),
    ),

    GetPage(
      name: RoutesName.aProfitOrLoss,
      page: () => const ProfitOrLossReport(),
    ),
    //purchase sale
    GetPage(
      name: RoutesName.aPurchaseInvoiceScreen,
      page: () => const AdminPurchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.aReturnPurchaseInvoiceScreen,
      page: () => const AdminReturnPuchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.aPurchaseInvoiceReport,
      page: () => const APurchaseInvoiceReport(),
    ),
    GetPage(
      name: RoutesName.aReturnPurchaseInvoiceReport,
      page: () => const AReturnedPurchaseInvoiceReport(),
    ),

    GetPage(
      name: RoutesName.aSaleReport,
      page: () => const SaleReportScreen(),
    ),

    ///
    GetPage(
      name: RoutesName.adminAllSaleInvoice,
      page: () => const AdminAllSaleInvoice(),
    ),

    GetPage(
      name: RoutesName.adminCashCounterReport,
      page: () => const AdminCashCounterReport(),
    ),



    GetPage(
      name: RoutesName.aSaleReturnReport,
      page: () => const SaleReturnReportScreen(),
    ),

    /* this Routes for Manager side */
    /// Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes
    /// Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes
    /// Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes
    /// Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes // Manger Routes

    GetPage(
      name: RoutesName.mDashboardScreen,
      page: () => const MDashBoardScreen(),
    ),
    // GetPage(
    //   name: RoutesName.mUserScreen,
    //   page: () => const MUserScreen(),
    // ),
    GetPage(
      name: RoutesName.mCustomerScreen,
      page: () => const MCustomerScreen(),
    ),
    GetPage(
      name: RoutesName.mCompanyScreen,
      page: () => const MCompanyScreen(),
    ),
    GetPage(
      name: RoutesName.mBarcodeScreen,
      page: () => const MBarcodeScreen(),
    ),

    GetPage(
      name: RoutesName.mBrandScreen,
      page: () => const MBrandScreen(),
    ),
    GetPage(
      name: RoutesName.mColorScreen,
      page: () => const MColorScreen(),
    ),
    GetPage(
      name: RoutesName.mSizeScreen,
      page: () => const MSizeScreen(),
    ),
    GetPage(
      name: RoutesName.mProductScreen,
      page: () => const MProductScreen(),
    ),
    GetPage(
      name: RoutesName.mStockInventoryScreen,
      page: () => const MStockInventoryScreen(),
    ),
    GetPage(
      name: RoutesName.mAssignStockToWarehouseScreen,
      page: () => const MAssignStockToWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.mAssignStockToBranchScreen,
      page: () => const MAssignStockToBranchScreen(),
    ),
    GetPage(
      name: RoutesName.mApproveStockDifferentWarehouseScreen,
      page: () => const MApproveStockDifferentWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.mApproveStockDifferentBranchScreen,
      page: () => const MApproveStockDifferentBranchScreen(),
    ),

    GetPage(
      name: RoutesName.mSalesmanScreen,
      page: () => const MSalesmanScreen(),
    ),
    GetPage(
      name: RoutesName.mExpenseHeadScreen,
      page: () => const MExpenseHeadScreen(),
    ),
    GetPage(
      name: RoutesName.mExpenseDetailScreen,
      page: () => const MExpenseDetailScreen(),
    ),
    GetPage(
      name: RoutesName.mAllExpenseBranchScreen,
      page: () => const MAllBranchExpensesScreen(),
    ),
    GetPage(
      name: RoutesName.mBankHeadScreen,
      page: () => const MBankHeadScreen(),
    ),
    GetPage(
      name: RoutesName.mBankEntryScreen,
      page: () => const MBankEntryScreen(),
    ),
    GetPage(
      name: RoutesName.mCashVoucherScreen,
      page: () => const MCashVoucherScreen(),
    ),
    GetPage(
      name: RoutesName.mPaymentVoucherScreen,
      page: () => const MPaymentVoucherScreen(),
    ),
    GetPage(
      name: RoutesName.mWarehouseClaimScreen,
      page: () => const MWarehouseClaimScreen(),
    ),
    GetPage(
      name: RoutesName.mBranchClaimScreen,
      page: () => const MBranchClaimScreen(),
    ),

    GetPage(
      name: RoutesName.mReturnedStockWarehouseScreen,
      page: () => const MReturnedStockWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.mReturnedStockBranchScreen,
      page: () => const MReturnedStockBranchScreen(),
    ),

    GetPage(
      name: RoutesName.mSalariesScreen,
      page: () => const MSalariesScreen(),
    ),
    GetPage(
      name: RoutesName.mSetSaleScreen,
      page: () => const MSetSaleScreen(),
    ),
    GetPage(
      name: RoutesName.mWarehouseStockScreen,
      page: () => const MWarehouseStockScreen(),
    ),
    GetPage(
      name: RoutesName.mBranchStockScreen,
      page: () => const MBranchStockScreen(),
    ),
    GetPage(
      name: RoutesName.mProductWiseDiscountScreen,
      page: () => const MProductWiseDiscountScreen(),
    ),
    GetPage(
      name: RoutesName.mBranchWiseDiscountScreen,
      page: () => const MBranchWiseDiscountScreen(),
    ),
    GetPage(
      name: RoutesName.mBranchTargetScreen,
      page: () => const MBranchTargetScreen(),
    ),

    GetPage(
      name: RoutesName.mUserReportScreen,
      page: () => const UserReport(),
    ),

    GetPage(
      name: RoutesName.mCustomerReportScreen,
      page: () => const AdminCustomerReport(),
    ),

    GetPage(
      name: RoutesName.mCompanyReportScreen,
      page: () => const AdminCompanyReport(),
    ),

    GetPage(
      name: RoutesName.mProductReportScreen,
      page: () => const AdminProductReport(),
    ),
    GetPage(
      name: RoutesName.mAssignStockBranchReport,
      page: () => const AdminAssignStockBranchReport(),
    ),
    GetPage(
      name: RoutesName.mPurchaseInvoiceScreen,
      page: () => const MPurchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.mReturnPurchaseInvoiceScreen,
      page: () => const MReturnPuchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.mPurchaseInvoiceReport,
      page: () => const WPurchaseInvoiceReport(),
    ),
    GetPage(
      name: RoutesName.mReturnPurchaseInvoiceReport,
      page: () => const WReturnedPurchaseInvoiceReport(),
    ),
    /* this Routes for Warehouse side */

    /// Warehouse Routes  // Warehouse Routes  // Warehouse Routes  // Warehouse Routes
    /// Warehouse Routes  // Warehouse Routes  // Warehouse Routes  // Warehouse Routes
    /// Warehouse Routes  // Warehouse Routes  // Warehouse Routes  // Warehouse Routes
    /// Warehouse Routes  // Warehouse Routes  // Warehouse Routes  // Warehouse Routes

    GetPage(
      name: RoutesName.wgenerateBarcodeWareHouse,
      page: () => const GenerateBarcodeScreen(),
    ),

    // dashboard screen

    GetPage(
      name: RoutesName.wdashboardScreenWareHouse,
      page: () => const DashBoardScreenWarehouse(),
    ),

    // brand screen
    GetPage(
      name: RoutesName.wBrandScreen,
      page: () => const WBrandScreen(),
    ),

    // color screen
    GetPage(
      name: RoutesName.wColorScreenWareHouse,
      page: () => const WColorScreen(),
    ),

    // size screen
    GetPage(
      name: RoutesName.wsizeScreenWareHouse,
      page: () => const WSizeScreen(),
    ),

    // product screen
    GetPage(
      name: RoutesName.wProductScreenWareHouse,
      page: () => const WProductScreen(),
    ),

    // stock inventory screen
    GetPage(
      name: RoutesName.wStockInventoryScreenWareHouse,
      page: () => const WStockInventoryScreen(),
    ),

    // assign stock screen
    GetPage(
      name: RoutesName.wAssignStockToBranchScreenWareHouse,
      page: () => const AssignStockToBranchScreenWarehouse(),
    ),

    GetPage(
      name: RoutesName.wAssignToAnotherWarehouseWareHouse,
      page: () => const AssignToWarehouseScreenWarehouse(),
    ),

    GetPage(
      name: RoutesName.wReturnStockToAdminWareHouse,
      page: () => const WReturnStockToAdminScreenWarehouse(),
    ),
    GetPage(
      name: RoutesName.wReturnStockToAnotherWarehouse,
      page: () => const WReturnStockToAnotherWarehouseScreen(),
    ),
    GetPage(
      name: RoutesName.wReturnedStockFromWarehouse,
      page: () => const WReturendStockFromWarehouse(),
    ),

    GetPage(
      name: RoutesName.wReturnedStockFromBranch,
      page: () => const WReturnedStockFromBranch(),
    ),

    GetPage(
      name: RoutesName.wClaimFromWarehouseWareHouse,
      page: () => const ClaimFromWarehouseScreenWarehouse(),
    ),
    GetPage(
      name: RoutesName.wClaimFromBranchWareHouse,
      page: () => const ClaimFromBranchScreenWarehouse(),
    ),
    GetPage(
      name: RoutesName.wCliamToAdminWareHouse,
      page: () => const CliamToAdminScreenWarehouse(),
    ),

    GetPage(
      name: RoutesName.claimToAnotherWarehouse,
      page: () => const ClaimToWarehouseScreenWarehouse(),
    ),

    GetPage(
      name: RoutesName.wWarehouseStockScreenWareHouse,
      page: () => const WarehouseStockScreenWarehouse(),
    ),
    GetPage(
      name: RoutesName.wBranchStockScreenWareHouse,
      page: () => const BranchStockScreenWarehouse(),
    ),
    GetPage(
      name: RoutesName.wMyStockInWarehouse,
      page: () => const WAssignStockToMyWarehouse(),
    ),

// Warehouse Report
    // GetPage(
    //   name: RoutesName.wBarcodeReportScreenWareHouse,
    //   page: () => const WBarcodeReportScreen(),
    // ),

    GetPage(
      name: RoutesName.wClaimsFromBranchReportScreenWareHouse,
      page: () => const WClaimsFromBranchReportScreen(),
    ),

    GetPage(
      name: RoutesName.wClaimsToAdminReportScreenWareHouse,
      page: () => const WClaimsToAdminReportScreen(),
    ),

    GetPage(
      name: RoutesName.wClaimsFromWarhouseReportScreenWareHouse,
      page: () => const WClaimsFromWarehouseScreenReport(),
    ),

    GetPage(
      name: RoutesName.wProductReportScreenWareHouse,
      page: () => const WProductReportScreen(),
    ),

    GetPage(
      name: RoutesName.wReturnStockAdminReportScreenWareHouse,
      page: () => const WReturnStockAdminReportScreen(),
    ),

    GetPage(
      name: RoutesName.wStockBranchReportScreenWareHouse,
      page: () => const WStockBranchReportScreen(),
    ),

    GetPage(
      name: RoutesName.wStockWarehouseOtherReportScreenWareHouse,
      page: () => const WStockWarehouseOtherReportScreen(),
    ),

    GetPage(
      name: RoutesName.wStockWarehouseReportScreenWareHouse,
      page: () => const WStockWarehouseReportScreen(),
    ),

    GetPage(
      name: RoutesName.wAssignStockWarehouseReportScreenWareHouse,
      page: () => const WAssignStockWarehouseReportScreen(),
    ),

    GetPage(
      name: RoutesName.wAssignStockBranchReportScreenWareHouse,
      page: () => const WAssignStockBranchReportScreen(),
    ),

    GetPage(
      name: RoutesName.wSaleInvoiceScreenReport,
      page: () => const WarehouseSaleInvoiceReport(),
    ),

    GetPage(
      name: RoutesName.wSaleInvoiceScreen,
      page: () => const SaleScreenWarehouse(),
    ),

    GetPage(
      name: RoutesName.wSaleReturn,
      page: () => const WarehouseSaleReturn(),
    ),

    GetPage(
      name: RoutesName.wSalReturnReport,
      page: () => const WarehouseSaleReturnScreenReport(),
    ),
    GetPage(
      name: RoutesName.wExchangeProduct,
      page: () => const WExchangeProductScreen(),
    ),

    GetPage(
      name: RoutesName.wExchangeProductReport,
      page: () => const WExchangeProductReport(),
    ),
//purchase sale
    GetPage(
      name: RoutesName.wPurchaseInvoiceScreen,
      page: () => const WPurchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.wReturnPurchaseInvoiceScreen,
      page: () => const WReturnPuchaseInvoiceScreen(),
    ),
    GetPage(
      name: RoutesName.wPurchaseInvoiceReport,
      page: () => const WPurchaseInvoiceReport(),
    ),
    GetPage(
      name: RoutesName.wReturnPurchaseInvoiceReport,
      page: () => const WReturnedPurchaseInvoiceReport(),
    ),

    GetPage(
      name: RoutesName.wMyWarehouseStock,
      page: () => const MyWarehouseStockScreen(),
    ),

    GetPage(
      name: RoutesName.wAssignStockToMyWarehouse,
      page: () => const WAssignStockToMyWarehouse(),
    ),

    /* this Routes for Branch side */

    /// Branch Routes // Branch Routes // Branch Routes // Branch Routes
    /// Branch Routes // Branch Routes // Branch Routes // Branch Routes
    /// Branch Routes // Branch Routes // Branch Routes // Branch Routes
    /// Branch Routes // Branch Routes // Branch Routes // Branch Routes

    GetPage(
      name: RoutesName.bDashboard,
      page: () => const BDashBoardScreen(),
    ),

    GetPage(
      name: RoutesName.bCustomer,
      page: () => const BCustomerScreen(),
    ),

    GetPage(
      name: RoutesName.bStockInventory,
      page: () => const BStockInventoryScreen(),
    ),

    GetPage(
      name: RoutesName.bAssignStockToBranch,
      page: () => const BAssignStockToBranchScreen(),
    ),

    GetPage(
      name: RoutesName.bReturnProductToAdmin,
      page: () => const BReturnProductToAdminScreen(),
    ),

    GetPage(
      name: RoutesName.bReturnProductToWarehouse,
      page: () => const BReturnProductToWareHouse(),
    ),

    GetPage(
      name: RoutesName.bReturnProductToBranch,
      page: () => const BReturnProductToBranch(),
    ),

    GetPage(
      name: RoutesName.targetScreenBranch,
      page: () => const TargetScreenBranch(),
    ),

    GetPage(
      name: RoutesName.bAssignSockToMyBranch,
      page: () => const AssignStockToMyBranchScreen(),
    ),
    GetPage(
      name: RoutesName.saleScreenBranch,
      page: () => const SaleScreenBranch(),
    ),
    GetPage(
      name: RoutesName.saleReturnScreenBranch,
      page: () => const SaleReturnScreenBranch(),
    ),
    GetPage(
      name: RoutesName.branchExpensesScreenBranch,
      page: () => const BranchExpensesScreenBranch(),
    ),
    GetPage(
      name: RoutesName.warehouseClaimScreenBranch,
      page: () => const BWarehouseClaim(),
    ),
    GetPage(
      name: RoutesName.branchClaimScreenBranch,
      page: () => const BBranchClaim(),
    ),
    GetPage(
      name: RoutesName.adminClaimScreenBranch,
      page: () => const BAdminClaim(),
    ),
    GetPage(
      name: RoutesName.salariesScreenBranch,
      page: () => const SalariesScreenBranch(),
    ),

    GetPage(
      name: RoutesName.branchStockScreenBranch,
      page: () => const BBranchStockScreen(),
    ),

    GetPage(
      name: RoutesName.bMyBranchStock,
      page: () => const MyBranchStockScreen(),
    ),


    /// branch reports

    GetPage(
      name: RoutesName.bStockInventoryReport,
      page: () => const BStockInventoryReport(),
    ),

    GetPage(
      name: RoutesName.bStockPositionReport,
      page: () => const BStockPositionReport(),
    ),

    GetPage(
      name: RoutesName.bReturnStockWarehouseReport,
      page: () => const BReturnStockWarehouseReport(),
    ),

    GetPage(
      name: RoutesName.bAssignStockToAnotherBranchReport,
      page: () => const BAssignStockToAnotherBranchReport(),
    ),

    GetPage(
      name: RoutesName.bWarehouseClaimReport,
      page: () => const BWarehouseClaimReport(),
    ),

    GetPage(
      name: RoutesName.bSaleReport,
      page: () => const BSaleReport(),
    ),

    GetPage(
      name: RoutesName.bSaleReturnReport,
      page: () => const BSaleReturnReport(),
    ),

    GetPage(
      name: RoutesName.bExchangeProduct,
      page: () => const BExchangeProductScreen(),
    ),

    GetPage(
      name: RoutesName.bExchangeProductReport,
      page: () => const BExchangeProductReport(),
    ),

    GetPage(
      name: RoutesName.bTargetReport,
      page: () => const BTargetReport(),
    ),

    GetPage(
      name: RoutesName.bExpenseBranchReport,
      page: () => const BExpenseBranchReport(),
    ),

    GetPage(
      name: RoutesName.bSalariesReport,
      page: () => const BSalariesReport(),
    ),

    GetPage(
      name: RoutesName.bSalemanSalariesReport,
      page: () => const BSalesmanSaleReport(),
    ),

    GetPage(
      name: RoutesName.bCategoryWiseSaleReport,
      page: () => const BCategoryWiseSaleReport(),
    ),

    GetPage(
      name: RoutesName.bBranchClaimReport,
      page: () => const BBranchClaimReport(),
    ),
    GetPage(
      name: RoutesName.bAdminClaimReport,
      page: () => const BAdminClaimReport(),
    ),
    GetPage(
      name: RoutesName.bReturnStockAdminReport,
      page: () => const BReturnProductToAdminReport(),
    ),
    GetPage(
      name: RoutesName.bReturnStockBranchReport,
      page: () => const BReturnProductToBranchReport(),
    ),
    GetPage(
      name: RoutesName.bSaleExpenseGrossReport,
      page: () => const BSaleExpenseGrossReport(),
    ),

  ];
}
