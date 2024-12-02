import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/branch_target_model.dart';

class BranchTargetRepository {
  final _apiService = NetworkApiServices();

  Future<BranchTargetModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.branchTarget);
    return BranchTargetModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.branchTarget);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchTarget}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchTarget}/$id?_method=patch");
    return response;
  }
}
