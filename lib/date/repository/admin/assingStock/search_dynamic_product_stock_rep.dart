import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/search_dynamic_product_stock_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SearchDynamicRepository {
  final _apiService = NetworkApiServices();

  Future<ASearchDynamicProductStockModel> getSpecific(var data) async {
    final response = await _apiService.postApi(
      data,
      AdminApiUrl.searchDynamicProductInventory,
    );
    return ASearchDynamicProductStockModel.fromJson(response);
  }

  Future<dynamic> getBarcode(var data) async {
    final response = await _apiService.postApi(
      data,
      AdminApiUrl.searchDynamicProductInventory,
    );
    return response;
  }
}
