import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/sale_invoice/exchange_product_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class ExchangeProductRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> update(var data, var previousInvoiceId) async {
    dynamic response = await _apiService.postApiJson(
        data, "${BranchApiUrl.exchangeProduct}/$previousInvoiceId}?_method=patch");
    return response;
  }

  Future<ExchangeProductModel> getExchnageProduct() async {
    dynamic response =
        await _apiService.getApi(BranchApiUrl.getExchangeProduct);
    return ExchangeProductModel.fromJson(response);
  }

  /// get exchange report invoice with date
  Future<ExchangeProductModel> filterExchangeProduct(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.getExchangeProduct);
    return ExchangeProductModel.fromJson(response);
  }
}
