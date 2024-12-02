import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/assign_stock_branch_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class AssignStockBranchRepository {
  final _apiService = NetworkApiServices();

  Future<AAssignStockToBranchModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.branchAssignStock);
    return AAssignStockToBranchModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.branchAssignStock);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchAssignStock}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchAssignStock}/$id?_method=patch");
    return response;
  }
}
