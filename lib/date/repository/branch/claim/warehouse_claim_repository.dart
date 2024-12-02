import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/claim/b_warehouse_claims_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BWarehouseClaimRepository {
  final _apiService = NetworkApiServices();

  Future<BWarehouseClaimModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.warehouseClaim);
    return BWarehouseClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.warehouseClaim);
    return response;
  }

  // Future<dynamic> delete(var id) async {
  //   dynamic response =
  //   await _apiService.deleteApi('${BranchApiUrl.warehouseClaim}/$id');
  //   return response;
  // }
  //
  // Future<dynamic> update(var data, var id) async {
  //   dynamic response = await _apiService.updateApi(
  //       data, "${BranchApiUrl.warehouseClaim}/$id?_method=patch");
  //   return response;
  // }
}
