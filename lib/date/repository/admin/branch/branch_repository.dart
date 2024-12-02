import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/branch_model.dart';

class BranchRepository {
  final _apiService = NetworkApiServices();

  Future<ABranchModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.getBranch);
    return ABranchModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.getBranch);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.getBranch}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.getBranch}/$id?_method=patch");
    return response;
  }
}
