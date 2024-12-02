import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/company_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class CompanyRespository {
  final _apiService = NetworkApiServices();

  Future<ACompanyModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.company);
    return ACompanyModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.company);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.company}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.company}/$id?_method=patch");
    return response;
  }
}
