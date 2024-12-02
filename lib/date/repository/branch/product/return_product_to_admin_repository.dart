import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/product/return_product_to_admin_model.dart';

class BReturnProductToAdminRepository {
  final _apiService = NetworkApiServices();

  Future<BReturnProductToAdminModel> getAll() async {
    dynamic response =
        await _apiService.getApi(BranchApiUrl.returnProductToAdmin);
    return BReturnProductToAdminModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.returnProductToAdmin);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${BranchApiUrl.returnProductToAdmin}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${BranchApiUrl.returnProductToAdmin}/$id?_method=patch");
    return response;
  }
}
