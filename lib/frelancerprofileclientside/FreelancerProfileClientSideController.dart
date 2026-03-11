import 'package:flutter/material.dart';
import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/service/Repo.dart';
// 👆 Ye client side wala model hoga (id, full_name, short_bio etc)

class FreelancerProfileClientSideController extends GetxController {

  TextEditingController searchCtrl = TextEditingController();

  RxBool loading = false.obs;
  RxBool profileLoading = false.obs;
  /// FILTERS
RxString selectedSkill = "".obs;
RxString selectedExperience = "Any Experience".obs;

  /// 🔹 LIST FOR CLIENT SIDE
  RxList<PublicFreelancerModel> freelancers =
      <PublicFreelancerModel>[].obs;

  /// 🔹 SINGLE PROFILE (CLIENT VIEW)
  Rx<PublicFreelancerModel?> selectedFreelancer =
      Rx<PublicFreelancerModel?>(null);
      RxList<PublicFreelancerModel> filteredFreelancers =
    <PublicFreelancerModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    print("======================================");
    print("🟢 INIT → FreelancerProfileClientSideController");
    print("======================================");
    fetchFreelancers("");
  }

  /// 🔵 FETCH ALL FREELANCERS (LIST API)
  Future<void> fetchFreelancers(String search) async {

    try {

      print("======================================");
      print("🔵 FETCH FREELANCERS STARTED");
      print("➡️ SEARCH TEXT → $search");
      print("======================================");

      loading.value = true;

      final res =
          await freelancerprofileclientsiderepo.fetchFreelancers(search);

      print("⬇️ RAW RESPONSE → $res");
      print("⬇️ RESPONSE TYPE → ${res.runtimeType}");

      /// ✅ YOUR API RETURNS DIRECT LIST
      if (res != null && res is List) {

        print("✅ API LIST LENGTH → ${res.length}");

        freelancers.value =
            res.map((e) =>
                PublicFreelancerModel.fromJson(e)).toList();

        print("✅ TOTAL LOADED → ${freelancers.length}");

      } else {

        print("❌ INVALID RESPONSE FORMAT");
        freelancers.clear();
      }

    } catch (e) {

      print("❌ LIST ERROR → $e");

    } finally {

      loading.value = false;

      print("🟢 LOADING FALSE");
      print("======================================");
    }
  }

  /// 🔵 FETCH SINGLE PROFILE
  Future<void> fetchFreelancerProfile(String id) async {

    try {

      print("======================================");
      print("🔵 FETCH PROFILE STARTED");
      print("➡️ FREELANCER ID → $id");
      print("======================================");

      profileLoading.value = true;

      final res =
          await freelancerprofileclientsiderepo.fetchFreelancerProfile(id);

      print("⬇️ PROFILE RAW RESPONSE → $res");
      print("⬇️ RESPONSE TYPE → ${res.runtimeType}");

      /// 🔥 Handle both possible formats
      if (res is Map<String, dynamic>) {

        /// Case 1: Direct object
        if (!res.containsKey("success")) {

          selectedFreelancer.value =
              PublicFreelancerModel.fromJson(res);

          print("✅ PROFILE LOADED (DIRECT MAP)");

        }

        /// Case 2: Wrapped response
        else if (res["success"] == true) {

          selectedFreelancer.value =
              PublicFreelancerModel.fromJson(res["data"]);

          print("✅ PROFILE LOADED (WRAPPED SUCCESS)");

        }

      } else {

        print("❌ PROFILE RESPONSE INVALID FORMAT");
      }

    } catch (e) {

      print("❌ PROFILE ERROR → $e");

    } finally {

      profileLoading.value = false;

      print("🟢 PROFILE LOADING FALSE");
      print("======================================");
    }
  }
  void resetFilters() {
  print("♻️ RESET FILTERS TRIGGERED");

  selectedSkill.value = "";
  selectedExperience.value = "Any Experience";
  searchCtrl.clear();

  fetchFreelancers("");
}

  /// 🔎 SEARCH
  void searchFreelancers() {

    final searchText = searchCtrl.text.trim();

    print("🔎 SEARCH TRIGGERED → $searchText");

    fetchFreelancers(searchText);
  }
  
void applyFilters() {

  print("🎯 APPLY FILTERS");

  filteredFreelancers.value = freelancers.where((f) {

    final matchesSearch =
        searchCtrl.text.isEmpty ||
        f.fullName.toLowerCase()
            .contains(searchCtrl.text.toLowerCase()) ||
        f.skills.toLowerCase()
            .contains(searchCtrl.text.toLowerCase());

    final matchesSkill =
        selectedSkill.value.isEmpty ||
        f.skills.toLowerCase()
            .contains(selectedSkill.value.toLowerCase());

    final matchesExperience =
        selectedExperience.value == "Any Experience" ||
        f.experience >=
            int.parse(selectedExperience.value);

    return matchesSearch &&
        matchesSkill &&
        matchesExperience;

  }).toList();

  print("✅ FILTERED COUNT → ${filteredFreelancers.length}");
}

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }
}
