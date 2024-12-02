import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_sale_return_model.dart';

import '../../../../res/apiurl/branch_api_url.dart';

class WarehouseSaleReturnInvoiceRepository {
  final _apiService = NetworkApiServices();

  Future<WarehouseSaleReturnInvoiceModel> getSaleReturnInvoice() async {
    dynamic response = await _apiService.getApi(
      BranchApiUrl.saleReturnInvoice,
    );
    return WarehouseSaleReturnInvoiceModel.fromJson(response);
  }
}
