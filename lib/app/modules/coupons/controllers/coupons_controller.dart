import 'package:get/get.dart';
import 'package:home_services_provider/app/models/custom_coupon.dart';
import 'package:home_services_provider/app/services/auth_service.dart';
import 'package:home_services_provider/common/ui.dart';
import '../../../providers/api_provider.dart';
import 'package:dio/dio.dart' as dio;

class CouponsController extends GetxController with ApiClient {
  final coupons = [].obs; //= <CustomCoupon>[].obs;
  dio.Dio _httpClient;
  dio.Options _optionsNetwork;
  dio.Options _optionsCache;

  @override
  void onInit() async {
    this.baseUrl = this.globalService.global.value.laravelBaseUrl;
    _httpClient = new dio.Dio();
    await refreshCoupons();
    super.onInit();
  }

  // CouponsController(){
  //   refreshCoupons();
  //   this.baseUrl = this.globalService.global.value.laravelBaseUrl;
  //   _httpClient = new dio.Dio();
  // }

  Future refreshCoupons() async {
    try {
      if (Get.find.isAuth) {
        String user_id = Get.find.user.value.id;
        var _queryParameters = {
          'user_id': user_id,
          'api_token': Get.find.user.value.apiToken
        };

        Uri _uri = getApiBaseUri("custom_coupons")
            .replace(queryParameters: _queryParameters);

        var response = await _httpClient.getUri(_uri);

        print(response.data);

        if (response.data['message'] == 'success') {
          coupons.value = response.data['data'];
        }
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
