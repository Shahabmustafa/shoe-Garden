import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/claim/b_admin_claim_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BAdminClaimRepository {
  final _apiService = NetworkApiServices();

  Future<BAdminClaimModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.adminClaim);
    return BAdminClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.adminClaim);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${BranchApiUrl.adminClaim}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${BranchApiUrl.adminClaim}/$id?_method=patch");
    return response;
  }
}
