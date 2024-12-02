import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/expense/branch_expense_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BExpenseRepository {
  final _apiService = NetworkApiServices();

  Future<BranchExpenseModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.branchExpense);
    return BranchExpenseModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.branchExpense);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${BranchApiUrl.branchExpense}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${BranchApiUrl.branchExpense}/$id?_method=patch");
    return response;
  }
}
