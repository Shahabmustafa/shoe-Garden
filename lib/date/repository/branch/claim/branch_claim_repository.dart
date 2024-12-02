import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/claim/b_branch_claim_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BBranchClaimRepository {
  final _apiService = NetworkApiServices();

  Future<BBranchClaimModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.branchClaim);
    return BBranchClaimModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.branchClaim);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${BranchApiUrl.branchClaim}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${BranchApiUrl.branchClaim}/$id?_method=patch");
    return response;
  }
}
