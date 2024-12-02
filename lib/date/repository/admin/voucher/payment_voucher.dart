import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/payment_voucher_model.dart';

class PaymentVoucherRepository {
  final _apiService = NetworkApiServices();

  Future<APaymentVoucherModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.paymentVoucher);
    return APaymentVoucherModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.paymentVoucher);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.paymentVoucher}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.paymentVoucher}/$id?_method=patch");
    return response;
  }
}
