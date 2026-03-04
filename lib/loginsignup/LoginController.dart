import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/LoginResponceModel.dart' show LoginResponse;
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Routes/AppRoutes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  final obscure = true.obs;
  final loading = false.obs;

  final AuthRepo _repo = AuthRepo();

  void togglePassword() => obscure.value = !obscure.value;

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    loading.value = true;

    try {
      debugPrint("🔵 Attempting login…");

      // API CALL
      LoginResponse data =
          await _repo.login(email.text.trim(), password.text.trim());

      debugPrint("🔐 Token → ${data.token}");
      debugPrint("👤 User → ${data.user.fullName}");
      debugPrint("🎭 Role → ${data.user.role}");

      // 🔥 SAVE TOKEN IN STORAGE
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString("token", data.token);
      // debugPrint("🔐 TOKEN SAVED IN STORAGE → ${data.token}");
      final prefs = await SharedPreferences.getInstance();

if (data.user.role == "client") {
  await prefs.setString("client_token", data.token);
} else {
  await prefs.setString("freelancer_token", data.token);
}

      // ROLE BASED NAVIGATION
      if (data.user.role == "client") {
        Get.offAllNamed(AppRoutes.CLIENT_DASHBOARD);
      } else {
        Get.offAllNamed(AppRoutes.FREELANCER_DASHBOARD);
      }

      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("❌ Login Error: $e");

      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}