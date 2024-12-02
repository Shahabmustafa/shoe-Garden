import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/cash_voucher_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class CashVoucherRepository {
  final _apiService = NetworkApiServices();

  Future<ACashVoucherModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.cashVoucher);
    return ACashVoucherModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.cashVoucher);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.cashVoucher}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.cashVoucher}/$id?_method=patch");
    return response;
  }

  Future<ACashVoucherModel> getSpecific(var id) async {
    dynamic response = await _apiService.specificGetData("${AdminApiUrl.cashVoucher}/$id");
    return ACashVoucherModel.fromJson(response);
  }
}
