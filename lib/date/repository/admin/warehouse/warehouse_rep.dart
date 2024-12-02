import 'package:sofi_shoes/model/admin/warehouse_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../network/network_api_service.dart';

class WarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<AWarehouseModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.warehouse);
    return AWarehouseModel.fromJson(response);
  }

  // Future<dynamic> add(var data) async {
  //   dynamic response = await _apiService.postApi(data, AdminApiUrl.warehouse);
  //   return response;
  // }

  // Future<dynamic> delete(var id) async {
  //   dynamic response =
  //       await _apiService.deleteApi('${AdminApiUrl.warehouse}/$id');
  //   return response;
  // }

  // Future<dynamic> update(var data, var id) async {
  //   dynamic response = await _apiService.updateApi(
  //       data, "${AdminApiUrl.warehouse}/$id?_method=patch");
  //   return response;
  // }
}
