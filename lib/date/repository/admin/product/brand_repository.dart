import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/brand_model.dart';

class BrandRepository {
  final _apiService = NetworkApiServices();

  Future<ABrandModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.brand);
    return ABrandModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.brand);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response = await _apiService.deleteApi('${AdminApiUrl.brand}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.brand}/$id?_method=patch");
    return response;
  }
}
