import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/salemen_salaries_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SalemenSariesRepository {
  final _apiService = NetworkApiServices();

  Future<ASalemenSalariesModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.salaries);
    return ASalemenSalariesModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.salaries);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.salaries}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.salaries}/$id?_method=patch");
    return response;
  }
}
