import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find.user;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  UserRepository _userRepository;

  AuthController() {
    _userRepository = UserRepository();
  }

  void login() async {
    Get.focusScope.unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      loading.value = true;
      try {
        await Get.find.setDeviceToken();
        currentUser.value = await _userRepository.login(currentUser.value);
        await _userRepository.signInWithEmailAndPassword(
            currentUser.value.email, currentUser.value.apiToken);
        loading.value = false;
        await Get.toNamed(Routes.ROOT, arguments: 0);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  void loginWithGoogle() async {
    Get.focusScope.unfocus();
    loading.value = true;
    try {
      await Get.find.setDeviceToken();
      // await _userRepository
      Map<String, dynamic> result = await _userRepository.signInGoogle();
      currentUser.value = await _userRepository.loginSocial(result);
      loading.value = false;
      await Get.toNamed(Routes.ROOT, arguments: 0);
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      print('done');
      loading.value = false;
    }
  }

  void loginWithFacebook() async {
    Get.focusScope.unfocus();
    loading.value = true;
    try {
      await Get.find.setDeviceToken();
      // await _userRepository
      Map<String, dynamic> result = await _userRepository.signInFacebook();
      currentUser.value = await _userRepository.loginSocial(result);
      loading.value = false;
      await Get.toNamed(Routes.ROOT, arguments: 0);
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      print('done');
      loading.value = false;
    }
  }

  void loginWithTrueCaller(Map<String, dynamic> result) async {
    Get.focusScope.unfocus();
    loading.value = true;

    try {
      await Get.find.setDeviceToken();

      currentUser.value = await _userRepository.loginSocial(result);
      fba.UserCredential userCredential =
          await fba.FirebaseAuth.instance.signInAnonymously();

      loading.value = false;
      await Get.toNamed(Routes.ROOT, arguments: 0);
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      print('done');
      loading.value = false;
    }
  }

  void register() async {
    Get.focusScope.unfocus();
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      loading.value = true;
      try {
        await _userRepository.sendCodeToPhone();
        loading.value = false;
        await Get.toNamed(Routes.PHONE_VERIFICATION);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      await _userRepository.verifyPhone(smsSent.value);
      await Get.find.setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);
      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email, currentUser.value.apiToken);
      await Get.find.removeCurrentUser();
      loading.value = false;
      await Get.toNamed(Routes.LOGIN);
    } catch (e) {
      loading.value = false;
      Get.toNamed(Routes.REGISTER);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  void sendResetLink() async {
    Get.focusScope.unfocus();
    if (forgotPasswordFormKey.currentState.validate()) {
      forgotPasswordFormKey.currentState.save();
      loading.value = true;
      try {
        await _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(
            message:
                "The Password reset link has been sent to your email: ".tr +
                    currentUser.value.email));
        Timer(Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }
}
