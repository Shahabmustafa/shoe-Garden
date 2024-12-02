import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/saleman_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SalemenRepository {
  final _apiService = NetworkApiServices();

  Future<ASalemenModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.salemen);
    return ASalemenModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.salemen);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.salemen}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.salemen}/$id?_method=patch");
    return response;
  }
}
