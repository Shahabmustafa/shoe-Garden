import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/color_model.dart';

class ColorRepository {
  final _apiService = NetworkApiServices();

  Future<AColorModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.color);
    return AColorModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.color);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService.deleteApi('${AdminApiUrl.color}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.color}/$id?_method=patch");
    return response;
  }
}
