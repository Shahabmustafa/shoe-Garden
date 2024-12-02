import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/bank_entry_model.dart';

import '../../../../res/apiurl/admin_api_url.dart';

class BankEntryRepository {
  final _apiService = NetworkApiServices();

  Future<ABankEntryModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.bankEntry);
    return ABankEntryModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.bankEntry);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.bankEntry}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.bankEntry}/$id?_method=patch");
    return response;
  }
}
