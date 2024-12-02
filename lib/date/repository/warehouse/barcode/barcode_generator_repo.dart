import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/warehouse/barcode_generater_model.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

class WBarcodeGeneratorRepository {
  final _apiService = NetworkApiServices();

  Future<BarcodeModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.barcodeGenerator);
    return BarcodeModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, WarehouseApiUrl.barcodeGenerator);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${WarehouseApiUrl.barcodeGenerator}/$id');
    return response;
  }
}
