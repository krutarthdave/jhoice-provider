import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

import 'app/providers/laravel_provider.dart' show LaravelApiClient;
import 'app/routes/theme1_app_pages.dart' show Theme1AppPages;
import 'app/services/auth_service.dart' show AuthService;
import 'app/services/firebase_messaging_service.dart' show FireBaseMessagingService;
import 'app/services/global_service.dart' show GlobalService;
import 'app/services/settings_service.dart' show SettingsService;
import 'app/services/translation_service.dart' show TranslationService;

void initServices() async {
  var Get;
  var s = 'starting services ...';
  Get.log(s);
  var GetStorage;
  await GetStorage.init();
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => GlobalService().init());
  var Firebase;
  await Firebase.initializeApp();
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => FireBaseMessagingService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  await Get.putAsync(() => SettingsService().init());
  Get.log('All services started...');
}

void main() async {
  var WidgetsFlutterBinding;
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  var Get;
  var GlobalMaterialLocalizations;
  var Transition;
  runApp(
    GetMaterialApp(
      title: Get.find<SettingsService>().setting.value.appName,
      initialRoute: Theme1AppPages.INITIAL,
      getPages: Theme1AppPages.routes,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<SettingsService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().fallbackLocale,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<SettingsService>().getThemeMode(),
      theme: Get.find<SettingsService>().getLightTheme(),
      //Get.find<SettingsService>().getLightTheme.value,
      darkTheme: Get.find<SettingsService>().getDarkTheme(),
    ),
  );
}

GetMaterialApp(
    {title,
    String initialRoute,
    List getPages,
    List localizationsDelegates,
    supportedLocales,
    translationsKeys,
    locale,
    fallbackLocale,
    bool debugShowCheckedModeBanner,
    defaultTransition,
    themeMode,
    theme,
    darkTheme}) {}

void runApp(getMaterialApp) {}
