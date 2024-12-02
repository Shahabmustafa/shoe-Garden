import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/warehouse_claim_model.dart';

class WarehouseClaimRepository {
  final _apiService = NetworkApiServices();

  Future<AWarehouseClaimModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.warehouseClaim);
    return AWarehouseClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.warehouseClaim);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.warehouseClaim}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.warehouseClaim}/$id?_method=patch");
    return response;
  }
}
