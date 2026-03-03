import 'package:get/get.dart';
import 'package:freelancer_app/loginsignup/LoginController.dart';
import 'package:freelancer_app/loginsignup/SignUpController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());
  }
}