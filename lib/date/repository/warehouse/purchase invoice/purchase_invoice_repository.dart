import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/sale_invoice/purchase_invoice_model.dart';
import '../../../../model/branch/sale_invoice/sale_invoice_models.dart';
import '../../../../model/warehouse/purchase_invoice_model.dart';

class PurchaseInvoiceRepository {
  final _apiService = NetworkApiServices();

  Future<PurchaseInvoiceSearchModel> getSpecific(var data) async {
    final response = await _apiService.postApi(
      data,
      AdminApiUrl.dynamicApiPurchaseInvoice,
    );

    return PurchaseInvoiceSearchModel.fromJson(response);
  }

  Future<dynamic> getbarcode(var data) async {
    final response = await _apiService.postApi(
      data,
      AdminApiUrl.dynamicApiPurchaseInvoice,
    );
    return response;
  }

  Future<dynamic> addPurchaseInvoice(var data) async {
    dynamic response =
        await _apiService.postApiJson(data, AdminApiUrl.purchaseInvoice);
    return response;
  }

  Future<PurchaseInvoiceModel> getInvoice() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.purchaseInvoice);
    return PurchaseInvoiceModel.fromJson(response);
  }

  Future<SaleInvoiceModels> specificSaleInvoice(var id) async {
    dynamic response = await _apiService.specificGetData(
        "${AdminApiUrl.dynamicApiPurchaseInvoice}/$id?_method=patch");
    return SaleInvoiceModels.fromJson(response);
  }

  Future<String> getCounter() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.counter);
    if (response != null && response['success'] == true) {
      return response['body'].toString();
    } else {
      throw Exception('Failed to fetch counter value');
    }
  }
}
