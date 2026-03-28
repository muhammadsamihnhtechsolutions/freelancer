
import 'package:get/get.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';

class FreelancerProfileController extends GetxController {

  /// =============================
  /// STATE
  /// =============================

  RxBool loading = false.obs;

  RxBool profileExists = false.obs;

  Rxn<FreelancerProfileModel> profile = Rxn();

  /// =============================
  /// INIT
  /// =============================

  @override
  void onInit() {
    super.onInit();

    print("=================================");
    print("🟣 FREELANCER PROFILE CONTROLLER INIT");
    print("=================================");

    checkProfile();
  }

  /// =============================
  /// CHECK PROFILE (FIRST FLOW)
  /// =============================

  Future<void> checkProfile() async {

    try {

      loading.value = true;

      print("----------------------------------");
      print("🔎 CHECKING FREELANCER PROFILE");
      print("----------------------------------");

      final res = await FreelancerProfileRepo.getProfile();

      if (res == null) {

        print("❌ PROFILE NOT FOUND");

        profileExists.value = false;

        /// Navigate to create profile
        Get.offAllNamed("/createFreelancerProfile");

        return;

      }

      print("✅ PROFILE EXISTS");

      profile.value = res;

      profileExists.value = true;

      print("🧠 Skills → ${res.skills}");
      print("💼 Experience → ${res.experience}");
      print("🔗 Portfolio → ${res.portfolioLinks}");
      print("📝 Bio → ${res.bio}");

    } catch (e) {

      print("❌ CHECK PROFILE ERROR → $e");

      Get.offAllNamed("/createFreelancerProfile");

    } finally {

      loading.value = false;

      print("----------------------------------");

    }

  }

  /// =============================
  /// FETCH PROFILE (REFRESH)
  /// =============================

  Future<void> fetchProfile() async {

    try {

      loading.value = true;

      print("----------------------------------");
      print("📡 FETCH PROFILE STARTED");
      print("----------------------------------");

      final res = await FreelancerProfileRepo.getProfile();

      if (res == null) {

        print("❌ PROFILE DATA NULL");

        profileExists.value = false;

        return;

      }

      profile.value = res;

      profileExists.value = true;

      print("✅ PROFILE FETCHED SUCCESSFULLY");

      print("🆔 User ID → ${res.userId}");
      print("🧠 Skills → ${res.skills}");
      print("💼 Experience → ${res.experience}");
      print("🔗 Portfolio → ${res.portfolioLinks}");
      print("📝 Bio → ${res.bio}");

    } catch (e) {

      print("❌ FETCH PROFILE ERROR → $e");

    } finally {

      loading.value = false;

      print("----------------------------------");

    }

  }
  /// =============================
/// PROFILE STRENGTH (DYNAMIC)
/// =============================
double get profileStrength {

  if (profile.value == null) return 0.0;

  int totalFields = 4;
  int completed = 0;

  final p = profile.value!;

  /// String / List fields
  if (p.skills != null && p.skills!.isNotEmpty) completed++;
  if (p.portfolioLinks != null && p.portfolioLinks!.isNotEmpty) completed++;
  if (p.bio != null && p.bio!.isNotEmpty) completed++;

  /// int field (experience)
  if (p.experience != null && p.experience! > 0) completed++;

  double strength = completed / totalFields;

  print("📊 PROFILE STRENGTH → ${(strength * 100).toStringAsFixed(0)}%");

  return strength;
}

  /// =============================
  /// CREATE PROFILE
  /// =============================
Future<void> createProfile(FreelancerProfileModel data) async {

  try {

    loading.value = true;

    print("----------------------------------");
    print("🟢 CREATE FREELANCER PROFILE");
    print("📤 BODY → ${data.toJson()}");
    print("----------------------------------");

    final res = await FreelancerProfileRepo.createProfile(data);

    if (res == null) {

      print("❌ CREATE PROFILE FAILED → NULL RESPONSE");

      return;
    }

    profile.value = res;
    profileExists.value = true;

    print("✅ PROFILE CREATED SUCCESSFULLY");

    print("🧠 Skills → ${res.skills}");
    print("💼 Experience → ${res.experience}");
    print("🔗 Portfolio → ${res.portfolioLinks}");
    print("📝 Bio → ${res.bio}");

    /// Navigate to profile page
    Get.offAllNamed("/freelancerProfile");

  } catch (e, stack) {

    print("❌ CREATE PROFILE ERROR → $e");
    print(stack);

  } finally {

    loading.value = false;

    print("----------------------------------");

  }

}

  /// =============================
  /// UPDATE PROFILE
  /// =============================

  Future<void> updateProfile(FreelancerProfileModel data) async {

    try {

      loading.value = true;

      print("----------------------------------");
      print("🟡 UPDATE FREELANCER PROFILE");
      print("📤 BODY → ${data.toJson()}");
      print("----------------------------------");

      final res = await FreelancerProfileRepo.updateProfile(data);

      if (res == null) {

        print("❌ UPDATE PROFILE FAILED");

        return;

      }

      profile.value = res;

      print("✅ PROFILE UPDATED SUCCESSFULLY");

      print("🧠 Skills → ${res.skills}");
      print("💼 Experience → ${res.experience}");
      print("🔗 Portfolio → ${res.portfolioLinks}");
      print("📝 Bio → ${res.bio}");

      Get.snackbar(
        "Success",
        "Profile Updated Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {

      print("❌ UPDATE PROFILE ERROR → $e");

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      loading.value = false;

      print("----------------------------------");

    }

  }

}