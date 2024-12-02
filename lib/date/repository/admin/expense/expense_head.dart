import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/admin/expense_head_model.dart';

class ExpenseHeadRepository {
  final _apiService = NetworkApiServices();

  Future<AExpenseHeadModel> getAllExpenseHead() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.expenseHead);
    return AExpenseHeadModel.fromJson(response);
  }

  Future<AExpenseHeadModel> getAllExpenseHeadForBranch() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.expenseHead);
    return AExpenseHeadModel.fromJson(response);
  }

  Future<dynamic> addExpenseHead(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.expenseHead);
    return response;
  }

  Future<dynamic> deleteExpenseHead(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.expenseHead}/$id');
    return response;
  }

  Future<dynamic> updateExpenseHead(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.expenseHead}/$id?_method=patch");
    return response;
  }
}
