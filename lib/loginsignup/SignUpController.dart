// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SignupController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   // Text Controllers
//   final fullNameCtrl = TextEditingController();
//   final emailCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();

//   // UI States
//   final obscurePassword = true.obs;

//   // Dropdown States
//   final selectedCountry = RxnString();
//   final selectedRole = "Work as a freelancer".obs;


//   // ✅ YAHAN ADD KARO
// // ✅ safest (string hardcode nahi)
// bool get isFreelancer => selectedRole.value == roles.first; // "Work as a freelancer"
// bool get isClient => selectedRole.value == roles.last;      // "Hire freelancers"
//   // Dummy lists (later API se aa sakti hain)
//   final countries = <String>[
//     "Pakistan",
//     "United Arab Emirates",
//     "Saudi Arabia",
//     "United Kingdom",
//     "United States",
//   ];

//   final roles = <String>[
//     "Work as a freelancer",
//     "Hire freelancers",
//   ];

//   void togglePassword() => obscurePassword.value = !obscurePassword.value;

//   @override
//   void onClose() {
//     fullNameCtrl.dispose();
//     emailCtrl.dispose();
//     passwordCtrl.dispose();
//     super.onClose();
//   }
// }




import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/SignUpModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final obscurePassword = true.obs;

  // Dropdown
  final selectedCountry = RxnString();
  final selectedRole = "Work as a freelancer".obs;

  final isLoading = false.obs;

  final countries = [

    "United Arab Emirates",
    "Saudi Arabia",
    "United Kingdom",
    "United States",
  ];

  final roles = [
    "Work as a freelancer", // freelancer
    "Hire freelancers", // client
  ];

  bool get isFreelancer => selectedRole.value == roles.first;
  bool get isClient => selectedRole.value == roles.last;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedCountry.value == null) {
      Get.snackbar("Country missing", "Please select your country");
      return;
    }

    isLoading.value = true;

    final data = SignupModel(
      fullName: fullNameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text.trim(),
      role: isFreelancer ? "freelancer" : "client",
      country: selectedCountry.value!,
    );

    print("📦 FINAL SIGNUP PAYLOAD → ${data.toJson()}");

    try {
      final res = await SignupRepo.register(data);

      Get.snackbar(
        "Verify Email",
        "A verification link has been sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed("/login"); // success → go to login

    } catch (e) {
      print("❌ SIGNUP ERROR: $e");
      Get.snackbar("Signup Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}