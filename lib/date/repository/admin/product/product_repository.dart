import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/product_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class ProductRepository {
  final _apiService = NetworkApiServices();

  Future<AProductModel> getAllProduct() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.product);
    return AProductModel.fromJson(response);
  }

  Future<AProductModel> getAllProductForWarehouse() async {
    dynamic response = await _apiService.getApi("${AdminApiUrl.product}/all");
    return AProductModel.fromJson(response);
  }

  Future<dynamic> addProduct(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.product);
    return response;
  }

  Future<dynamic> deleteProduct(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.product}/$id');
    return response;
  }

  Future<dynamic> updateProduct(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.product}/$id?_method=patch");
    return response;
  }
}
