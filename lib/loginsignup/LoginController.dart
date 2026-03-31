// import 'package:flutter/material.dart';
// import 'package:freelancer_app/loginsignup/LoginResponceModel.dart' show LoginResponse;
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Routes/AppRoutes.dart';

// class LoginController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   final email = TextEditingController();
//   final password = TextEditingController();

//   final obscure = true.obs;
//   final loading = false.obs;

//   final AuthRepo _repo = AuthRepo();

//   void togglePassword() => obscure.value = !obscure.value;

//   Future<void> loginUser() async {
//     if (!formKey.currentState!.validate()) return;

//     loading.value = true;

//     try {
//       debugPrint("🔵 Attempting login…");

//       // API CALL
//       LoginResponse data =
//           await _repo.login(email.text.trim(), password.text.trim());

//       debugPrint("🔐 Token → ${data.token}");
//       debugPrint("👤 User → ${data.user.fullName}");
//       debugPrint("🎭 Role → ${data.user.role}");

//       final prefs = await SharedPreferences.getInstance();

// if (data.user.role == "client") {
//   await prefs.setString("client_token", data.token);
// } else {
//   await prefs.setString("freelancer_token", data.token);
// }

//       // ROLE BASED NAVIGATION
//       if (data.user.role == "client") {
//         Get.offAllNamed(AppRoutes.CLIENT_DASHBOARD);
//       } else {
//         Get.offAllNamed(AppRoutes.FREELANCER_DASHBOARD);
//       }

//       Get.snackbar(
//         "Success",
//         "Login Successful",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint("❌ Login Error: $e");

//       Get.snackbar(
//         "Login Failed",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.white,
//         backgroundColor: Colors.red,
//       );
//     } finally {
//       loading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/loginsignup/LoginResponceModel.dart' show LoginResponse;
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Routes/AppRoutes.dart';

// class LoginController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   final email = TextEditingController();
//   final password = TextEditingController();

//   final obscure = true.obs;
//   final loading = false.obs;

//   final AuthRepo _repo = AuthRepo();

//   void togglePassword() => obscure.value = !obscure.value;

//   Future<void> loginUser() async {
//     if (!formKey.currentState!.validate()) return;

//     loading.value = true;

//     try {
//       debugPrint("🔵 Attempting login...");

//       LoginResponse data =
//           await _repo.login(email.text.trim(), password.text.trim());

//       debugPrint("🔐 Token → ${data.token}");
//       debugPrint("👤 User → ${data.user.fullName}");
//       debugPrint("🎭 Role → ${data.user.role}");

//       final prefs = await SharedPreferences.getInstance();

//       // Purana login data remove karo
//       await prefs.remove("token");
//       await prefs.remove("role");
//       await prefs.remove("client_token");
//       await prefs.remove("freelancer_token");

//       // Naya token save karo
//       await prefs.setString("token", data.token);
//       await prefs.setString("role", data.user.role);

//       // Agar tum full user data bhi save karna chaho
//       await prefs.setString("full_name", data.user.fullName);

//       // Role based navigation
//       if (data.user.role == "client") {
//         Get.offAllNamed(AppRoutes.CLIENT_DASHBOARD);
//       } else {
//         Get.offAllNamed(AppRoutes.FREELANCER_DASHBOARD);
//       }

//       Get.snackbar(
//         "Success",
//         "Login Successful",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint("❌ Login Error: $e");

//       Get.snackbar(
//         "Login Failed",
//         "Please check your credentials",
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.white,
//         backgroundColor: Colors.red,
//       );
//     } finally {
//       loading.value = false;
//     }
//   }

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
      debugPrint("🔵 Attempting login...");

      final LoginResponse data = await _repo.login(
        email.text.trim(),
        password.text.trim(),
      );

      final role = data.user.role.toString().trim().toLowerCase();

      debugPrint("🔐 Token => ${data.token}");
      debugPrint("👤 User => ${data.user.fullName}");
      debugPrint("🎭 Role => $role");

      if (data.token.isEmpty) {
        throw Exception("Token not received from API");
      }

      // final prefs = await SharedPreferences.getInstance();

      // // active/current role update karo
      // await prefs.setString("current_role", role);
      // await prefs.setString("full_name", data.user.fullName);

      // // role-based token save
      // if (role == "client") {
      //   await prefs.remove("client_token");
      //   await prefs.setString("client_token", data.token);
      // } else if (role == "freelancer") {
      //   await prefs.remove("freelancer_token");
      //   await prefs.setString("freelancer_token", data.token);
      // } else {
      //   throw Exception("Unknown role: $role");
      // }
      final prefs = await SharedPreferences.getInstance();

await prefs.setString("current_role", role);
await prefs.setString("full_name", data.user.fullName);

if (role == "client") {
  await prefs.remove("client_token");
  await prefs.remove("client_id");

  await prefs.setString("client_token", data.token);
  await prefs.setString("client_id", data.user.id.toString());

} else if (role == "freelancer") {
  await prefs.remove("freelancer_token");
  await prefs.remove("freelancer_id");

  await prefs.setString("freelancer_token", data.token);
  await prefs.setString("freelancer_id", data.user.id.toString());
}

debugPrint("======================================");
debugPrint("💾 SAVED LOGIN DATA");
debugPrint("➡️ ROLE => $role");
debugPrint("➡️ USER ID => ${data.user.id}");
debugPrint("➡️ client_id => ${prefs.getString("client_id")}");
debugPrint("➡️ freelancer_id => ${prefs.getString("freelancer_id")}");
debugPrint("======================================");
      debugPrint("✅ current_role => ${prefs.getString("current_role")}");
      debugPrint("✅ client_token => ${prefs.getString("client_token")}");
      debugPrint("✅ freelancer_token => ${prefs.getString("freelancer_token")}");

      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      if (role == "client") {
        Get.offAllNamed(AppRoutes.CLIENT_DASHBOARD);
      } else {
        Get.offAllNamed(AppRoutes.FREELANCER_DASHBOARD);
      }
    } catch (e) {
      debugPrint("❌ Login Error: $e");

      Get.snackbar(
        "Login Failed",
        e.toString().replaceFirst("Exception: ", ""),
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
    email.dispose();
    password.dispose();
    super.onClose();
  }
}