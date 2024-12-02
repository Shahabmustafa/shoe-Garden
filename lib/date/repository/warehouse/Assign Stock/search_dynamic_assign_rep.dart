import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/search_dynamic_stock_warehouse_model.dart';
import '../../../network/network_api_service.dart';

class WSearchDynamicRepository {
  final _apiService = NetworkApiServices();

  Future<SearchDynamicStockWarehouseModel> getSpecific(var data) async {
    final response = await _apiService.postApi(
      data,
      WarehouseApiUrl.searchDynamicAssignStock,
    );
    return SearchDynamicStockWarehouseModel.fromJson(response);
  }

  Future<dynamic> getBarcode(var data) async {
    final response = await _apiService.postApi(
      data,
      WarehouseApiUrl.searchDynamicAssignStock,
    );
    return response;
  }
}
