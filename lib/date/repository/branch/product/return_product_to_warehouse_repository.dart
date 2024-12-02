import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/product/return_product_to_warehouse_model.dart';

class BReturnProductToWarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<BReturnProductToWareHouseModel> getAll() async {
    dynamic response =
        await _apiService.getApi(BranchApiUrl.returnProductToWarehouse);
    return BReturnProductToWareHouseModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.returnProductToWarehouse);
    return response;
  }
}
