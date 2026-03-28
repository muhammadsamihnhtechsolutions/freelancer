import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Routes/AppRoutes.dart';

class LogoutController extends GetxController {
  Future<void> logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove("client_token");
      await prefs.remove("freelancer_token");
      await prefs.remove("current_role");
      await prefs.remove("full_name");

      Get.offAllNamed(AppRoutes.LOGIN);

      Get.snackbar(
        "Success",
        "Logged out successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Logout failed",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}