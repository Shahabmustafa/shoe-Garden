import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/branch_wise_discount_model.dart';

class BranchWiseDiscountRepository {
  final _apiService = NetworkApiServices();

  Future<ABranchWiseDiscountModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.branchWiseDiscount);
    return ABranchWiseDiscountModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.branchWiseDiscount);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchWiseDiscount}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchWiseDiscount}/$id?_method=patch");
    return response;
  }
}
