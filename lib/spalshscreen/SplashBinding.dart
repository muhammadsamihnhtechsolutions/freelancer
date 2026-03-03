import 'package:freelancer_app/spalshscreen/SplashController.dart';
import 'package:get/get.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    print("🔥 SplashBinding Loaded");
    Get.put<SplashController>(SplashController()); // MUST
  }
}