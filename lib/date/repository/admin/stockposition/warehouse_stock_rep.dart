import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/assign_stock_wareshouse_model.dart';
import 'package:sofi_shoes/model/admin/specific_warehouse_stock_position_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class WarehouseStockRepository {
  final _apiService = NetworkApiServices();

  Future<AAssignStockTwoWarehouseModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.warehouseStockPosition);
    return AAssignStockTwoWarehouseModel.fromJson(response);
  }

  Future<SpecificWarehouseStockPositionModel> getSpecificWarehouse(var id) async {
    dynamic response = await _apiService.specificGetData("${AdminApiUrl.specificWarehouseStockPosition}/$id");
    return SpecificWarehouseStockPositionModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.warehouseAssignStock);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.warehouseAssignStock}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.warehouseAssignStock}/$id?_method=patch");
    return response;
  }

}
