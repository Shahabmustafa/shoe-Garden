import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/branch_claim_model.dart';

class BranchClaimRepository {
  final _apiService = NetworkApiServices();

  Future<ABranchClaimModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.branchClaim);
    return ABranchClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.branchClaim);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchClaim}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchClaim}/$id?_method=patch");
    return response;
  }
}
