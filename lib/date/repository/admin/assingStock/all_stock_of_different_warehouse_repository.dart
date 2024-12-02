import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/all_stock_of_different_warehouse_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class AllStockOfDifferentWarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<AllStockOfDifferentWarehouseModel> getAll() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.getAllStockOfDifferentWarehouse);
    return AllStockOfDifferentWarehouseModel.fromJson(response);
  }
}
