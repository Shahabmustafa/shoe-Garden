import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_sale_invoice_model.dart';

import '../../../../res/apiurl/branch_api_url.dart';

class WarehouseSaleInvoiceRepository {
  final _apiService = NetworkApiServices();

  Future<WarehouseSaleinvoiceModel> getSaleInvoice() async {
    dynamic response = await _apiService.getApi(
      BranchApiUrl.saleInvoice,
    );
    return WarehouseSaleinvoiceModel.fromJson(response);
  }
}
