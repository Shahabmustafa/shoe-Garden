import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/returned_item_purchase_invoice_model.dart';
import '../../../../model/warehouse/returned_purchase_invoice_model.dart';

class ReturnedPurchaseInvoiceRepository {
  final _apiService = NetworkApiServices();

  Future<ReturnedPurchaseInvoiceModel> getAllReturnedInvoice() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.returnPurchaseInvoice);
    return ReturnedPurchaseInvoiceModel.fromJson(response);
  }

  Future<dynamic> addReturnedInvoice(var data) async {
    dynamic response =
        await _apiService.postApiJson(data, AdminApiUrl.returnPurchaseInvoice);
    return response;
  }

  Future<ReturnedItemPurchaseInvoiceModel> getSpecificReturnInvoice(
      var id) async {
    dynamic response = await _apiService
        .specificGetData("${AdminApiUrl.returnPurchaseInvoice}/$id");
    return ReturnedItemPurchaseInvoiceModel.fromJson(response);
  }
}
