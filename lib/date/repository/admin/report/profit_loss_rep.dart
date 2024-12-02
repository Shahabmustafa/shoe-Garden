import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/profit_loss_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class ProfitOrLossRepository {
  final _apiService = NetworkApiServices();

  Future<ProfitLossModel> getProfitOrLoss(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.profitLossReport);
    return ProfitLossModel.fromJson(response);
  }
}
