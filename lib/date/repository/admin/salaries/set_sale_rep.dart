import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/set_sale_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SetSaleRepository {
  final _apiService = NetworkApiServices();

  Future<ASetSaleModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.setSale);
    return ASetSaleModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.setSale);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.setSale}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.setSale}/$id?_method=patch");
    return response;
  }
}
