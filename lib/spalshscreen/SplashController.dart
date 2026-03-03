// import 'dart:developer' as developer;
// import 'package:get/get.dart';
// import 'package:freelancer_app/Routes/AppRoutes.dart';

// class SplashController extends GetxController {
//   @override
//   void onReady() {
//     super.onReady();
//     developer.log("✅ SplashController onReady called", name: "Splash");

//     Future.delayed(const Duration(seconds: 2), () {
//       developer.log("➡️ Going to SIGNUP", name: "Splash");
//       Get.offAllNamed(AppRoutes.SIGNUP);
//     });
//   }
// }

import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:freelancer_app/Routes/AppRoutes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    developer.log("✅ SplashController onReady called", name: "Splash");

    Future.delayed(const Duration(seconds: 2), () {
      developer.log("➡️ Going to SIGNUP", name: "Splash");
      Get.offAllNamed(AppRoutes.SIGNUP);
    });
  }
}