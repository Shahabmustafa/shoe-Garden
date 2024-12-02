import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/size_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SizeRespository {
  final _apiService = NetworkApiServices();

  Future<ASizeModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.size);
    return ASizeModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.size);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService.deleteApi('${AdminApiUrl.size}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.size}/$id?_method=patch");
    return response;
  }
}
