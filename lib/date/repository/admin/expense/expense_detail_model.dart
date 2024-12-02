import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/expense_detail_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class ExpenseDetailRepository {
  final _apiService = NetworkApiServices();

  Future<AExpenseDetailModel> getAllExpenseDetail() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.expenseDetail);
    return AExpenseDetailModel.fromJson(response);
  }

  Future<dynamic> addExpenseDetail(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.expenseDetail);
    return response;
  }

  Future<dynamic> deleteExpenseDetail(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.expenseDetail}/$id');
    return response;
  }

  Future<dynamic> updateExpenseDetail(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.expenseDetail}/$id?_method=patch");
    return response;
  }
}
