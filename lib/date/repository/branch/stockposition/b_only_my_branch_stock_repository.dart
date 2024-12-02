import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/assignstock/assign_stock_to_my_branch.dart';


class BOnlyMyBranchStockRepository {
  final _apiService = NetworkApiServices();

  Future<AssignStockToMyBranchModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.assignStockToMyBranch);
    return AssignStockToMyBranchModel.fromJson(response);
  }

  Future<dynamic> updateBranchStatus(var data, var id) async {
    dynamic response = await _apiService.postApi(data, "${BranchApiUrl.assignStockToMyBranchApproval}/$id");
    return response;
  }
}
