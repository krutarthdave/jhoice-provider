import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart' show User;
import 'package:home_services_provider/app/repositories/user_repository.dart' show UserRepository;
import 'settings_service.dart' show SettingsService;

class AuthService extends GetxService {
  final user = User().obs;
  GetStorage _box;

  UserRepository _usersRepo;

  AuthService() {
    _usersRepo = new UserRepository();
    _box = new GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((User _user) {
      var Get;
      if (Get.isRegistered<SettingsService>()) {
        Get.find<SettingsService>().address.value.userId = _user.id;
      }
      _box.write('current_user', _user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = User.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future get removeCurrentUser async {
    user.value = new User();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.apiToken : '';
}

class GetxService {
}

class GetStorage {
  void write(String s, Map<String, dynamic> json) {}

  bool hasData(String s) {}

  read(String s) {}

  remove(String s) {}
}
