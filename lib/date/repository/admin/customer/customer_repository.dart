import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/customer_model.dart';

class CustomerRepository {
  final _apiService = NetworkApiServices();

  Future<ACustomerModel> getAllCustomer() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.customer);
    return ACustomerModel.fromJson(response);
  }

  Future<dynamic> addCustomer(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.customer);
    return response;
  }

  Future<dynamic> deleteCustomer(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.customer}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.customer}/$id?_method=patch");
    return response;
  }
}
