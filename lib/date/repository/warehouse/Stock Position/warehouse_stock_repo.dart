import 'package:sofi_shoes/model/admin/specific_warehouse_stock_position_model.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/warehouse_warehouse_stock_model.dart';
import '../../../network/network_api_service.dart';

class WWarehouseStockRepository {
  final _apiService = NetworkApiServices();

  Future<WWarehouseStockModel> getAll() async {
    dynamic response = await _apiService.getApi(WarehouseApiUrl.warehouseStock);
    return WWarehouseStockModel.fromJson(response);
  }

  Future<SpecificWarehouseStockPositionModel> specificBranch(String id) async {
    dynamic response = await _apiService.specificGetData("${WarehouseApiUrl.warehouseStock}/${id}");
    return SpecificWarehouseStockPositionModel.fromJson(response);
  }
}
