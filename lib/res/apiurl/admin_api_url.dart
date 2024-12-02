class AdminApiUrl {
  static const String baseUrl =
      'https://investwithcc.com/safishoes/public/api/';

  // static String? id;

  // static String? accessToken;
  // "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2VjM2Q1M2I4NjA0M2VmZDhjN2VhNzUyMzE4MWFjOTFhZGUzNWJkY2IyYWNmZGNlNDM1YmU0Y2RjOTkyYTY4ODA5MjI2NzdhYThkZWUwNDAiLCJpYXQiOjE3MjEzMDI3MjQuMjUzODIyLCJuYmYiOjE3MjEzMDI3MjQuMjUzODI4LCJleHAiOjE3NTI4Mzg3MjQuMjUyMjA5LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.JZSwu9hVpy8dasPXczcsx5xF32Y-iqB8Fg1GcOMmrLnoAu7sRabI6tA9G_L75sNyG67_2odK0S99LKhtXRN3m6DMbHTf_W9lD0tfb2u-h2yH7_yOzeLpnx6S04HhQ4rgL9pK7s-Q3Nrxrd0XkIbdCb5wyN_GPhZuvb1Ug8_2FcugAwBMialDfiLihQL3Dkl8xxhiw5z1liBnn-Ew55l7l_qOjUJ9g_KeqMLZsTSpbTEUSRWYj1x9NOqDEl_EfTAgCFsAxlH7chXCm0iy7k0UE6Smdv5uuHzl9c7grP77vvqRAJ7z4ez7HZ50UXkiIzfXZ3dL5e1-uXXiXOdPTKgU8XiifLLhIPX9rYaXUILr0k6IMb_S3w2HIXB2Go4H__CM5wWcTWS1DKAyBCrYY4U0lZY7hwTIrnAjFTr-MBNbAPS9dmUq5_S9yfmLVEnd7GB_JZnryh2mGHXYLP-HjNVKqwhJUQb1_BS6BEc_nuZYvzvUSs9FxcI3NCTUiSWVOwI0pqjbTopkgEzUiIb1mTvYUWgfVwQeM-TLJjVO0ENv3HvHXZz7vrhcE360mIwlZ9VLTEWrxqzR-bXJaQ_eCnYNpdOTOX_rltRohEQtTsZEejGLx0fVugAvSSqonBhEIFcFG_BipY47XSeEDZVYtBO6tnnfIkVH0XFU45EjCnnxXVw";
  // static String? accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjQ4YTVjYjVkNGU4MGYxN2RjZTllNWY1NTI4MDAxNzRhNjVkNjgyOGZkYTY0YmI2ZTMyOGMxOWU3ZTM1MTRmNjk4Y2EzMmMzZTllYTdjNGIiLCJpYXQiOjE3MTk4MTI5NDQuNTA0ODk0LCJuYmYiOjE3MTk4MTI5NDQuNTA0OTAxLCJleHAiOjE3NTEzNDg5NDQuNTAxMzA5LCJzdWIiOiIzMSIsInNjb3BlcyI6W119.a0eMXRmpuibgqvX_0tWqYfCoZRdruR84HaDYuYQnLwfyNsWE1j8Z-9a8ggAM0XMDqW6kjF797BlH2MXsPEM4MSlqvlLzDcCqOEXh_4OW1ZCyAz8jcrlxUFWhtKTpukjhBQtCT54dNUdcxOcxG10dpTYDJ6QEC5NnIQMOD0HH1yCPGcOhMh1bdddGE-wht7jtkRnoRA8oUy6fmMk1D4QKGSyw32tGwWhce5hw42LlBH4kD70HLANR-xce0DW8ul5Pakwk9f4MOs7d7vwRk-ocnKGZNZLFn1PT5zDu48p9ofjhJSmMlLOMS7pRRZGKuqlB6FGephBiBArIz7QTqOvbgtvmXfccCuxjdLnSjmbyZCPk4Ros0FXfJ5RkXNr30UNlDFXxy-LYpLITRkkyTplvY_XfCaQjEgLCVVdjaH7mlpj08wTJqLXFgNNXVPSPsuxVVuWP9Cnksqa9mfzNNXSo2MctGfXwSBRM_xPJup5oxUglzD9AuDINYn5-65_a91B5eqTxobMdfPBzl6XEvW8NleFZpt93H6HeFd3akdy_Q2j4yZ0e4t0T9u30b4Q9SghojMz_TOwWlwgbLVelP0H3_IO5_XGWhfmPxhbx8DG3sNjp8bG7MkPywJgAGQScZ4BPuPHHWFalRD8vMFzZzLz6RwxffzWtx5J3qpL9zbVEubw";
  static const String loginApi = "${baseUrl}login";

  /// Admin Side Apis

  /// user api url
  static const String userApi = '${baseUrl}admin/v1/users';

  /// customer api url
  static const String customer = '${baseUrl}admin/v1/customers';

  /// company api url
  static const String company = '${baseUrl}admin/v1/companies';

  /// brand api url
  static const String brand = '${baseUrl}admin/v1/brands';

  /// colors api url
  static const String color = '${baseUrl}admin/v1/colors';

  /// sizes api url
  static const String size = '${baseUrl}admin/v1/sizes';

  /// expense head api url
  static const String expenseHead = '${baseUrl}admin/v1/expenses';

  /// expense detail api url
  static const String expenseDetail = '${baseUrl}admin/v1/general_expenses';

  /// branch expense api url
  static const String branchExpense = '${baseUrl}admin/v1/branch_expenses';

  /// products api url
  static const String product = '${baseUrl}admin/v1/products';

  /// stock inventory api url
  static const String stockInventory = '${baseUrl}admin/v1/product_stocks';

  /// bank head api url
  static const String bankHead = '${baseUrl}admin/v1/bank_heads';

  /// bank entries api url
  static const String bankEntry = '${baseUrl}admin/v1/bank_entries';

  /// cash vouchers api url
  static const String cashVoucher = '${baseUrl}admin/v1/cash_vouchers';

  /// payment vouchers api url
  static const String paymentVoucher = '${baseUrl}admin/v1/payment_vouchers';

  /// saleman api url
  static const String salemen = '${baseUrl}admin/v1/sale_mans';

  /// get branch api url
  static const String getBranch = '${baseUrl}admin/v1/branches';

  /// set salaries api url
  static const String setSale = '${baseUrl}admin/v1/commissions';

  /// saleman salaries api url
  static const String salaries = '${baseUrl}admin/v1/sale_mans_salaries';

  /// branch claim api url
  static const String branchClaim = '${baseUrl}admin/v1/claims/from/branches';

  /// warehouse claim api url
  static const String warehouseClaim = '${baseUrl}admin/v1/claims/from/warehouses';

  /// warehouse
  static const String warehouse = '${baseUrl}admin/v1/warehouses';

  /// assign stock
  static const String warehouseAssignStock = '${baseUrl}admin/v1/warehouse_stocks';
  static const String returnedStockWarehouse = '${baseUrl}admin/v1/return/from/warehouses';
  static const String returnedStockBranch = '${baseUrl}admin/v1/return/from/branches';

  static const String branchAssignStock = '${baseUrl}admin/v1/branch_stocks';

  static const String getAllStockOfDifferentWarehouse = '${baseUrl}admin/v1/warehouse_stocks/all';

  static const String getAllStockOfDifferentBranch = '${baseUrl}admin/v1/branch_stocks/all';

  /// stock position
  static const String warehouseStockPosition = '${baseUrl}admin/v1/warehouse_stocks/all';
  static const String specificWarehouseStockPosition = '${baseUrl}admin/v1/warehouse_stocks';

  static const String branchStockPosition = '${baseUrl}admin/v1/branch_stocks/all';
  static const String specificBranchStockPosition = '${baseUrl}admin/v1/branch_stocks';

  /// branch and warehouse assign stock status
  static const String warehouseStatus = '${baseUrl}admin/v1/warehouse_stocks/update/status';
  static const String branchStatus = '${baseUrl}admin/v1/branch_stocks/update/status';

  static const String claimStatus = '${baseUrl}admin/v1/claims/update/status';
  static const String returnedStatus = '${baseUrl}admin/v1/return/update/status';

  static const String searchDynamicProductInventory = "${baseUrl}admin/v1/product_stocks/search_dynamic_product_stock";

  static const String productWiseDiscount = "${baseUrl}admin/v1/product_discount";

  static const String branchWiseDiscount = "${baseUrl}admin/v1/branch_discount";

  static const String branchTarget = "${baseUrl}admin/v1/target";

  static const String dashboard = "${baseUrl}admin/v1/dashboard";

  static const String companyLedgerReport = "${baseUrl}admin/v1/report/company_ledger";
  static const String customerLedgerReport = "${baseUrl}admin/v1/report/customer_ledger";

  static const String profitLossReport = "${baseUrl}admin/v1/report/profit_or_loss";

  static const String saleReport = "${baseUrl}admin/v1/report/sale";
  static const String saleReturnReport = "${baseUrl}admin/v1/report/sale/return";

  static const String returnStockFromWarehouseReport = "${baseUrl}admin/v1/report/return/warehouse_stock";

  static const String returnStockFromBranchReport = "${baseUrl}admin/v1/report/return/branch_stock";

  static const String purchaseInvoice = "${baseUrl}admin/v1/purchase_invoice";

  static const String returnPurchaseInvoice = "${baseUrl}admin/v1/purchase_retrun";

  static const String dynamicApiPurchaseInvoice = "${baseUrl}admin/v1/purchase_invoice/search_dynamic_purchase_invoice_product_stock";

  static const String allBranchSaleReports = "${baseUrl}admin/v1/report/sale";

  static const String cashCounter = "${baseUrl}admin/v1/report/branch/cash_transfer";
}
