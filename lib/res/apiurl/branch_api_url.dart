class BranchApiUrl {
  static const String baseUrl =
      'https://investwithcc.com/safishoes/public/api/';

  static const String branchDashboard = "${baseUrl}branch/v1/dashboard";

  static const String counter = "${baseUrl}branch/v1/counter";

  static const String branchStocks =
      "${baseUrl}branch/v1/branch_stocks/my_branch_stock";

  static const String branchExpense = "${baseUrl}branch/v1/branch_expenses";

  static const String salemanSalaries = "${baseUrl}branch/v1/sale_man_salaries";

  static const String branchTarget = "${baseUrl}branch/v1/target";

  static const String assignStockToOtherBranch =
      "${baseUrl}branch/v1/assign_stock/to/another_branch";

  static const String warehouseClaim = "${baseUrl}branch/v1/claim/warehouse";

  static const String adminClaim = "${baseUrl}branch/v1/claim/admin";

  static const String branchClaim = "${baseUrl}branch/v1/claim/branch";

  /// branch stock api
  static const String assignStockToMyBranch =
      "${baseUrl}branch/v1/branch_stocks/my_branch_stock";
  static const String assignStockToMyBranchApproval =
      "${baseUrl}branch/v1/branch_stocks/approved";

  static const String allBranchStock = "${baseUrl}branch/v1/branch_stocks";
  static const String myBranchSock =
      "${baseUrl}admin/v1/branch_stocks/available";

  static const String specificBranchStock =
      "${baseUrl}warehouse/v1/branch_stocks";

  /// branch product return api
  static const String returnProductToWarehouse =
      "${baseUrl}branch/v1/return/warehouse";

  static const String returnProductToAdmin = "${baseUrl}branch/v1/return/admin";

  static const String returnProductToBranch =
      "${baseUrl}branch/v1/return/branch";

  static const String branchSearchDynamicProductStock =
      "${baseUrl}branch/v1/branch_stocks/search_dynamic_product_stock";

  static const String getAllCustomer = "${baseUrl}branch/v1/customers";

  static const String getAllSaleman = "${baseUrl}branch/v1/salemans";

  static const String saleInvoiceDynamicApi =
      "${baseUrl}branch/v1/branch_stocks/search_dynamic_sale_invoice_product_stock";

  static const String saleInvoice = "${baseUrl}branch/v1/sale";
  static const String saleInvoiceReport = "${baseUrl}branch/v1/sale/filter-by-date";
  static const String saleReturnInvoiceReport = "${baseUrl}branch/v1/sale_return/filter-by-date";
  static const String exchangeProductReport = "${baseUrl}branch/v1/exchange_products";

  static const String saleReturnInvoice = "${baseUrl}branch/v1/sale_return";

  static const String exchangeProduct = "${baseUrl}branch/v1/sale";

  static const String getExchangeProduct =
      "${baseUrl}branch/v1/sale/exchange_products";

  static const String saleExpenseGross =
      "${baseUrl}branch/v1/report/sale/cash_transfer_report";

  static const String cashAssignToAdmin =
      "${baseUrl}branch/v1/report/sale/cash_assign_to_admin";

  static const String salesmanReport = "${baseUrl}branch/v1/report/salemen";

  static const String salesmanSalaryReport =
      "${baseUrl}branch/v1/report/sale/sale_men";

  static const String expenseHead =
      "${baseUrl}branch/v1/branch_expenses/expenses";
}
