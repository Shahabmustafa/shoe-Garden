import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/warehouse_return_stock_admin_model.dart';

class WReturnedStockToAnotherWarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<WReturnedStockToAdminModel> getAll() async {
    dynamic response = await _apiService
        .getApi(WarehouseApiUrl.returnedStockToAnotherWarehouse);
    return WReturnedStockToAdminModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(
        data, WarehouseApiUrl.returnedStockToAnotherWarehouse);
    return response;
  }
}
