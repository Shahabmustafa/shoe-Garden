import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/my_stock_model.dart';
import '../../../../model/warehouse/my_warehouse_stock_model.dart';

class MyStockRepository {
  final _apiService = NetworkApiServices();

  Future<WMyStockModel> getAll() async {
    dynamic response = await _apiService.getApi(WarehouseApiUrl.myStock);
    return WMyStockModel.fromJson(response);
  }

  Future<dynamic> updateWarehouseStatus(var data, var id) async {
    dynamic response = await _apiService.postApi(data, "${WarehouseApiUrl.myStockApprove}/$id");
    return response;
  }

  Future<MyWarehouseStockModel> myWarehouseStock(var data) async {
    dynamic response = await _apiService.postApi(data,WarehouseApiUrl.myWarehouseStock);
    return MyWarehouseStockModel.fromJson(response);
  }

}
