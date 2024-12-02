import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/branch_stock_inventory_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BStockInventoryRepository {
  final _apiService = NetworkApiServices();

  Future<BStockInventoryModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.branchStocks);
    return BStockInventoryModel.fromJson(response);
  }
}
