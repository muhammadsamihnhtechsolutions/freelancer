// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LoginController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   final email = TextEditingController();
//   final password = TextEditingController();

//   final obscure = true.obs;

//   void togglePassword() => obscure.value = !obscure.value;

//   @override
//   void onClose() {
//     email.dispose();
//     password.dispose();
//     super.onClose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/LoginResponceModel.dart' show LoginResponse;
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

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

      LoginResponse data =
          await _repo.login(email.text.trim(), password.text.trim());

      debugPrint("🔐 Token → ${data.token}");
      debugPrint("👤 User → ${data.user.fullName}");
      debugPrint("🎭 Role → ${data.user.role}");

      // Role Based Navigation
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

  // ❌ don't dispose here — GetX manages safely
@override
void onClose() {
  super.onClose();
}
}