import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> login(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.loginApi);
    return response;
  }
}
