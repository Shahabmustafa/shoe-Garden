import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/assignstock/b_assign_stock_to_another_branch_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/assignstock/assign_stock_to_my_branch.dart';

class BAssignStockToOtherBranchRepository {
  final _apiService = NetworkApiServices();

  Future<BAssignStockToOtherBranchModel> getAll() async {
    dynamic response =
        await _apiService.getApi(BranchApiUrl.assignStockToOtherBranch);
    return BAssignStockToOtherBranchModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.assignStockToOtherBranch);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService
        .deleteApi('${BranchApiUrl.assignStockToOtherBranch}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${BranchApiUrl.assignStockToOtherBranch}/$id?_method=patch");
    return response;
  }

  Future<AssignStockToMyBranchModel> assignStockToMyBranch() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.assignStockToMyBranch);
    return AssignStockToMyBranchModel.fromJson(response);
  }

  Future<dynamic> updateBranchStatus(var data, var id) async {
    dynamic response = await _apiService.postApi(data, "${BranchApiUrl.assignStockToMyBranchApproval}/$id");
    return response;
  }


}
