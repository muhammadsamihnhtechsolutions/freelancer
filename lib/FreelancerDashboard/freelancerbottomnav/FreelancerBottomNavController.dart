import 'package:freelancer_app/controller/DashboardController.dart';
import 'package:get/get.dart';

class FreelancerBottomNavController extends GetxController {
  final RxInt index = 0.obs;
  final DashboardController controller = Get.put(DashboardController());

  void setIndex(int i) {
    index.value = i;
  }
}