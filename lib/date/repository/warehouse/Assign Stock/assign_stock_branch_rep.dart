import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_assign_stock_branch_model.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

class WAssignStockToBranchRepository {
  final _apiService = NetworkApiServices();

  Future<WAssignToBranchModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.assignStockToBranch);
    return WAssignToBranchModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, WarehouseApiUrl.assignStockToBranch);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService
        .deleteApi('${WarehouseApiUrl.assignStockToBranch}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${WarehouseApiUrl.assignStockToBranch}/$id?_method=patch");
    return response;
  }
}
