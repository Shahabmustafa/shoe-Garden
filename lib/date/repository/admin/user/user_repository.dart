import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/user_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<AUserModel> getAllUser() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.userApi);
    return AUserModel.fromJson(response);
  }

  Future<dynamic> addUser(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.userApi);
    return response;
  }

  Future<dynamic> deleteUser(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.userApi}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.userApi}/$id?_method=patch");
    return response;
  }
}
