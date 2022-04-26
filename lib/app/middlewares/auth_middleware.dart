import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:home_services_provider/app/routes/app_routes.dart' show Routes;
import 'package:home_services_provider/app/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String route) {
    var find = Get.find;
    final authService = find;
    if (!authService.isAuth) {
      var routeSettings = RouteSettings(name: Routes.LOGIN);
      return routeSettings;
    }
    return null;
  }
}

class RouteSettings {
}

class Get {
  static get find {}

  static log(String string) {}
}

class GetMiddleware {
}
