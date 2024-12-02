import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/stock_inventory_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class StockInventoryRepository {
  final _apiService = NetworkApiServices();

  Future<AStockInventoryModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.stockInventory);
    return AStockInventoryModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.stockInventory);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.stockInventory}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.stockInventory}/$id?_method=patch");
    return response;
  }
}
