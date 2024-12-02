import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/warehouse_claim_model.dart';

class WClaimFromBranchRepository {
  final _apiService = NetworkApiServices();

  Future<WClaimModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.warehouseClaimFromBranch);
    return WClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(
        data, WarehouseApiUrl.warehouseClaimFromBranch);
    return response;
  }
}
