import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/branch_expense_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class AllBranchExpenseRepository {
  final _apiService = NetworkApiServices();

  Future<AAllBranchExpenseModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.branchExpense);
    return AAllBranchExpenseModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.branchExpense);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchExpense}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchExpense}/$id?_method=patch");
    return response;
  }
}
