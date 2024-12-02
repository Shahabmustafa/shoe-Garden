import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class WarehouseApiUrl {
//stock api

  static const String myWarehouseStock = '${AdminApiUrl.baseUrl}admin/v1/warehouse_stocks/available';

  static const String myStock = '${AdminApiUrl.baseUrl}warehouse/v1/warehouse_stocks/my_warehouse_stock';
  static const String myStockApprove = '${AdminApiUrl.baseUrl}warehouse/v1/warehouse_stocks/approved';
  static const String warehouseStock = '${AdminApiUrl.baseUrl}warehouse/v1/warehouse_stocks';
  static const String branchStock = '${AdminApiUrl.baseUrl}warehouse/v1/branch_stocks';
  static const String specificBranchStock = '${AdminApiUrl.baseUrl}warehouse/v1/branch_stocks';
  static const String assignStockToBranch = '${AdminApiUrl.baseUrl}warehouse/v1/assign_stock/to/branch';
  static const String assignStockToAnotherWarehouse = '${AdminApiUrl.baseUrl}warehouse/v1/assign_stock/to/another_warehouse';
  static const String searchDynamicAssignStock = '${AdminApiUrl.baseUrl}warehouse/v1/warehouse_stocks/search_dynamic_product_stock';
  static const String returnedStockToAdmin = '${AdminApiUrl.baseUrl}warehouse/v1/return/admin';
  static const String returnedStockToAnotherWarehouse = '${AdminApiUrl.baseUrl}warehouse/v1/return/warehouse';
  static const String returnedStockFromWarehouse = '${AdminApiUrl.baseUrl}warehouse/v1/return/from/warehouse';
  static const String returnedStockFromBranch = '${AdminApiUrl.baseUrl}warehouse/v1/return/from/branch';
  static const String warehouseClaimToAdmin = '${AdminApiUrl.baseUrl}warehouse/v1/claim/admin';
  static const String warehouseClaimToWarehouse = '${AdminApiUrl.baseUrl}warehouse/v1/claim/warehouse';
  static const String warehouseClaimFromBranch = '${AdminApiUrl.baseUrl}warehouse/v1/claim/from/branch';
  static const String warehouseClaimFromWarehouse = '${AdminApiUrl.baseUrl}warehouse/v1/claim/from/warehouse';
  static const String barcodeGenerator = '${AdminApiUrl.baseUrl}warehouse/v1/barcode';
  static const String warehouseDashboard = '${AdminApiUrl.baseUrl}warehouse/v1/dashboard';
  static const String warehouseSaleReturn = '${AdminApiUrl.baseUrl}warehouse/v1/sale_return';
  static const String warehouseSaleInvoice = '${AdminApiUrl.baseUrl}warehouse/v1/sale';

  static const String saleInvoiceReport = "${AdminApiUrl.baseUrl}warehouse/v1/sale";
  static const String saleReturnInvoiceReport = "${AdminApiUrl.baseUrl}warehouse/v1/sale_return";

}
