import 'package:sofi_shoes/model/admin/bank_head_model.dart';

import '../../../../res/apiurl/admin_api_url.dart';
import '../../../network/network_api_service.dart';

class BankHeadRepository {
  final _apiService = NetworkApiServices();

  Future<ABankHeadModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.bankHead);
    return ABankHeadModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.bankHead);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.bankHead}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.bankHead}/$id?_method=patch");
    return response;
  }
}
