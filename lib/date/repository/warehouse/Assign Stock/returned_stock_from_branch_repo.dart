import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/warehouse/warehouse_return_stock_admin_model.dart';

class WReturnedStockFromBranchRepository {
  final _apiService = NetworkApiServices();

  Future<WReturnedStockToAdminModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.returnedStockFromBranch);
    return WReturnedStockToAdminModel.fromJson(response);
  }
}
