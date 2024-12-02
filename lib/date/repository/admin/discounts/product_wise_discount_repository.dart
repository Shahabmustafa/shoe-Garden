import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/product_wise_discountmodel.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class ProductWiseDiscountRepository {
  final _apiService = NetworkApiServices();

  Future<AProductWiseDiscountModel> getAll() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.productWiseDiscount);
    return AProductWiseDiscountModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.productWiseDiscount);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.productWiseDiscount}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.productWiseDiscount}/$id?_method=patch");
    return response;
  }
}
