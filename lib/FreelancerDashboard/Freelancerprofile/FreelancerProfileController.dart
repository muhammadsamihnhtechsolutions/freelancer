import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class FreelancerProfileController extends GetxController {

  /// ===============================
  /// STATE
  /// ===============================

  var loading = false.obs;

  Rxn<FreelancerProfileModel> profile = Rxn();

  /// ===============================
  /// INIT
  /// ===============================

  @override
  void onInit() {
    super.onInit();

    print("--------------------------------------------------");
    print("🟣 FREELANCER PROFILE CONTROLLER INIT");
    print("--------------------------------------------------");

    fetchProfile();
  }

  /// ===============================
  /// FETCH PROFILE
  /// ===============================

  Future<void> fetchProfile() async {

    try {

      print("🔵 FETCHING FREELANCER PROFILE STARTED");

      loading.value = true;

      final res = await FreelancerProfileRepo.getFreelancerProfile();

      profile.value = res;

      print("✅ PROFILE FETCHED SUCCESSFULLY");

      print("🆔 User ID → ${res.userId}");
      print("🧠 Skills → ${res.skills}");
      print("💼 Experience → ${res.experience}");
      print("🔗 Portfolio → ${res.portfolioLinks}");
      print("📝 Bio → ${res.bio}");

    } catch (e) {

      print("❌ ERROR Fetching Profile → $e");

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      loading.value = false;

      print("--------------------------------------------------");

    }

  }

}