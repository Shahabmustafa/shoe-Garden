import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/warehouse_claim_model.dart';

class WClaimToWarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<WClaimModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.warehouseClaimToWarehouse);
    return WClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(
        data, WarehouseApiUrl.warehouseClaimToWarehouse);
    return response;
  }
}