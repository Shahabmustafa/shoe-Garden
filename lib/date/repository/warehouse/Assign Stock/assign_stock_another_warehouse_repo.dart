import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_assign_another_warehouse_model.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

class WAssignStockAnotherWarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<WAssignToAnotherWarehouseModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.assignStockToAnotherWarehouse);
    return WAssignToAnotherWarehouseModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(
        data, WarehouseApiUrl.assignStockToAnotherWarehouse);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService
        .deleteApi('${WarehouseApiUrl.assignStockToAnotherWarehouse}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.postApi(data,
        "${WarehouseApiUrl.assignStockToAnotherWarehouse}/$id?_method=patch");
    return response;
  }
}
