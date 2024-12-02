import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class StatusRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> updateWarehouse(var data, var id) async {
    dynamic response = await _apiService.postApi(data, "${AdminApiUrl.warehouseStatus}/$id");
    return response;
  }

  Future<dynamic> updateBranch(var data, var id) async {
    dynamic response =
        await _apiService.postApi(data, "${AdminApiUrl.branchStatus}/$id");
    return response;
  }

  Future<dynamic> updateClaim(var data, var id) async {
    dynamic response =
        await _apiService.postApi(data, "${AdminApiUrl.claimStatus}/$id");
    return response;
  }

  Future<dynamic> updateReturned(var data, var id) async {
    dynamic response =
        await _apiService.postApi(data, "${AdminApiUrl.returnedStatus}/$id");
    return response;
  }
}
