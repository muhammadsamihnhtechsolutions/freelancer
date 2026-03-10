

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/ClientProfilePage/ClientProfileModel.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class ClientProfileController extends GetxController {

//   /// ==============================
//   /// STATE
//   /// ==============================
//   final isLoading = false.obs;
//   final isCheckingProfile = false.obs;

//   /// PROFILE DATA
//   final profile = {}.obs;

//   /// FORM CONTROLLERS
//   final companyNameCtrl = TextEditingController();
//   final websiteCtrl = TextEditingController();
//   final sizeCtrl = TextEditingController();
//   final emailCtrl = TextEditingController();
//   final linkedinCtrl = TextEditingController();
//   final industryCtrl = TextEditingController();
//   final locationCtrl = TextEditingController();
//   final phoneCtrl = TextEditingController();
//   final descriptionCtrl = TextEditingController();

//   /// ==============================
//   /// INIT
//   /// ==============================
//   @override
//   void onInit() {
//     print("==================================================");
//     print("🚀 ClientProfileController INIT");
//     print("==================================================");

//     fetchProfile();

//     super.onInit();
//   }

//   /// ==============================
//   /// CHECK PROFILE AFTER LOGIN
//   /// ==============================
//   Future<void> checkProfile() async {

//     print("==================================================");
//     print("🔍 CHECK PROFILE START");
//     print("==================================================");

//     try {

//       isCheckingProfile.value = true;

//       final res = await ClientProfileRepo.getClientProfile();

//       print("⬇️ CHECK PROFILE RESPONSE → $res");

//       if (res != null && res["success"] == true && res["data"] != null) {

//         print("✅ PROFILE FOUND");

//         profile.value = res["data"];

//         _fillProfileData(res["data"]);

//         Get.offAllNamed("/profile");

//       } else {

//         print("⚠️ PROFILE NOT FOUND → Redirecting to create profile");

//         Get.offAllNamed("/createProfile");

//       }

//     } catch (e) {

//       print("❌ CHECK PROFILE ERROR → $e");

//       Get.offAllNamed("/createProfile");

//     } finally {

//       isCheckingProfile.value = false;

//       print("==================================================");
//       print("🔚 CHECK PROFILE END");
//       print("==================================================");

//     }
//   }

//   /// ==============================
//   /// FETCH PROFILE
//   /// ==============================
//   Future<void> fetchProfile() async {

//     print("==================================================");
//     print("📥 FETCH CLIENT PROFILE START");
//     print("==================================================");

//     try {

//       final res = await ClientProfileRepo.getClientProfile();

//       print("⬇️ FETCH RESPONSE → $res");

//       if (res != null && res["success"] == true && res["data"] != null) {

//         print("✅ PROFILE RECEIVED FROM API");

//         profile.value = res["data"];

//         print("📦 PROFILE STORED IN CONTROLLER → ${profile.value}");

//         _fillProfileData(res["data"]);

//       } else {

//         print("⚠️ PROFILE NOT FOUND FROM API");

//         profile.clear();

//       }

//     } catch (e) {

//       print("❌ FETCH PROFILE ERROR → $e");

//     }

//     print("==================================================");
//     print("🔚 FETCH CLIENT PROFILE END");
//     print("==================================================");
//   }

//   /// ==============================
//   /// AUTO FILL FORM
//   /// ==============================
//   void _fillProfileData(Map data) {

//     print("==================================================");
//     print("📥 AUTO FILLING FORM DATA");
//     print("==================================================");

//     companyNameCtrl.text = data["company_name"] ?? "";
//     websiteCtrl.text = data["company_website"] ?? "";
//     sizeCtrl.text = data["company_size"] ?? "";
//     emailCtrl.text = data["contact_email"] ?? "";
//     linkedinCtrl.text = data["linkedin_url"] ?? "";
//     industryCtrl.text = data["industry"] ?? "";
//     locationCtrl.text = data["location"] ?? "";
//     phoneCtrl.text = data["phone"] ?? "";
//     descriptionCtrl.text =
//         data["company_description"] ?? data["description"] ?? "";

//     print("📝 FORM FILLED SUCCESSFULLY");
//   }

//   /// ==============================
//   /// SAVE PROFILE
//   /// ==============================
//   Future<void> saveProfile({required bool isEdit}) async {

//     print("==================================================");
//     print("🚀 SAVE PROFILE START");
//     print("==================================================");

//     try {

//       isLoading.value = true;

//       /// Decide create or update automatically
//       bool isEdit = profile.isNotEmpty;

//       print("📝 EDIT MODE → $isEdit");

//       print("📌 FORM DATA");
//       print("Company Name → ${companyNameCtrl.text}");
//       print("Website → ${websiteCtrl.text}");
//       print("Company Size → ${sizeCtrl.text}");
//       print("Email → ${emailCtrl.text}");
//       print("LinkedIn → ${linkedinCtrl.text}");
//       print("Industry → ${industryCtrl.text}");
//       print("Location → ${locationCtrl.text}");
//       print("Phone → ${phoneCtrl.text}");
//       print("Description → ${descriptionCtrl.text}");

//       final model = ClientProfileModel(
//         companyName: companyNameCtrl.text,
//         companyWebsite: websiteCtrl.text,
//         companySize: sizeCtrl.text,
//         contactEmail: emailCtrl.text,
//         linkedinUrl: linkedinCtrl.text,
//         industry: industryCtrl.text,
//         location: locationCtrl.text,
//         phone: phoneCtrl.text,
//         description: descriptionCtrl.text,
//       );

//       print("--------------------------------------------------");
//       print("📦 MODEL JSON DATA → ${model.toJson()}");
//       print("--------------------------------------------------");

//       final res = await ClientProfileRepo.saveClientProfile(model, isEdit);

//       print("⬇️ SAVE PROFILE RESPONSE → $res");

//       if (res != null && res["success"] == true) {

//         print("✅ PROFILE SAVED SUCCESSFULLY");

//         Get.snackbar("Success", "Profile saved successfully");

//         await fetchProfile();

//         Get.back();
     

//       } else {

//         print("❌ API ERROR → ${res?["message"]}");

//         Get.snackbar(
//           "Error",
//           res?["message"] ?? "Profile save failed",
//         );

//       }

//     } catch (e) {

//       print("❌ SAVE PROFILE EXCEPTION → $e");

//       Get.snackbar("Error", e.toString());

//     } finally {

//       isLoading.value = false;

//       print("==================================================");
//       print("🏁 SAVE PROFILE END");
//       print("==================================================");

//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:freelancer_app/ClientProfilePage/ClientProfileModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientProfileController extends GetxController {

  /// ==============================
  /// STATE
  /// ==============================

  final isLoading = false.obs;
  final isCheckingProfile = false.obs;
  final isLogoUploading = false.obs;

  /// PROFILE DATA
  final profile = {}.obs;

  /// LOGO URL
  final logoUrl = "".obs;

  /// ==============================
  /// FORM CONTROLLERS
  /// ==============================

  final companyNameCtrl = TextEditingController();
  final websiteCtrl = TextEditingController();
  final sizeCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final linkedinCtrl = TextEditingController();
  final industryCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  /// ==============================
  /// INIT
  /// ==============================

  @override
  void onInit() {
    print("==================================================");
    print("🚀 ClientProfileController INIT");
    print("==================================================");

    fetchProfile();

    super.onInit();
  }

  /// ==============================
  /// CHECK PROFILE AFTER LOGIN
  /// ==============================

  Future<void> checkProfile() async {

    print("==================================================");
    print("🔍 CHECK PROFILE START");
    print("==================================================");

    try {

      isCheckingProfile.value = true;

      final res = await ClientProfileRepo.getClientProfile();

      print("⬇️ CHECK PROFILE RESPONSE → $res");

      if (res != null && res["success"] == true && res["data"] != null) {

        print("✅ PROFILE FOUND");

        profile.value = res["data"];
        logoUrl.value = res["data"]["logo"] ?? "";

        _fillProfileData(res["data"]);

        Get.offAllNamed("/profile");

      } else {

        print("⚠️ PROFILE NOT FOUND → Redirecting to create profile");

        Get.offAllNamed("/createProfile");
      }

    } catch (e) {

      print("❌ CHECK PROFILE ERROR → $e");
      Get.offAllNamed("/createProfile");

    } finally {

      isCheckingProfile.value = false;

      print("==================================================");
      print("🔚 CHECK PROFILE END");
      print("==================================================");
    }
  }

  /// ==============================
  /// FETCH PROFILE
  /// ==============================

  // Future<void> fetchProfile() async {

  //   print("==================================================");
  //   print("📥 FETCH CLIENT PROFILE START");
  //   print("==================================================");

  //   try {

  //     final res = await ClientProfileRepo.getClientProfile();

  //     print("⬇️ FETCH RESPONSE → $res");

  //     if (res != null && res["success"] == true && res["data"] != null) {

  //       print("✅ PROFILE RECEIVED FROM API");

  //       profile.value = res["data"];
  //       logoUrl.value = res["data"]["logo"] ?? "";

  //       print("📦 PROFILE STORED → ${profile.value}");
  //       print("🖼️ LOGO URL STORED → ${logoUrl.value}");

  //       _fillProfileData(res["data"]);

  //     } else {

  //       print("⚠️ PROFILE NOT FOUND FROM API");
  //       profile.clear();
  //       logoUrl.value = "";
  //     }

  //   } catch (e) {

  //     print("❌ FETCH PROFILE ERROR → $e");
  //   }

  //   print("==================================================");
  //   print("🔚 FETCH CLIENT PROFILE END");
  //   print("==================================================");
  // }
  Future<void> fetchProfile() async {

  print("==================================================");
  print("📥 FETCH CLIENT PROFILE START");
  print("==================================================");

  try {

    final res = await ClientProfileRepo.getClientProfile();

    print("⬇️ FETCH RESPONSE → $res");

    if (res != null && res["success"] == true && res["data"] != null) {

      print("✅ PROFILE RECEIVED FROM API");

      profile.value = res["data"];

      /// 🔥 LOGO FIX PART (VERY IMPORTANT)
   final logoPath = res["data"]["logo"] ?? "";

if (logoPath.isNotEmpty) {

  if (logoPath.startsWith("http")) {
    /// Already full URL
    logoUrl.value = logoPath;
  } else {
    /// Relative path
    logoUrl.value =
        "https://freelancesupermarket.hnhsofttechsolutions.com$logoPath";
  }

  print("🖼️ LOGO URL SET → ${logoUrl.value}");

} else {
  logoUrl.value = "";
}

      print("📦 PROFILE STORED IN CONTROLLER → ${profile.value}");
      print("🖼️ LOGO URL STORED IN CONTROLLER → ${logoUrl.value}");

      _fillProfileData(res["data"]);

    } else {

      print("⚠️ PROFILE NOT FOUND FROM API");

      profile.clear();
      logoUrl.value = "";
    }

  } catch (e) {

    print("❌ FETCH PROFILE ERROR → $e");
  }

  print("==================================================");
  print("🔚 FETCH CLIENT PROFILE END");
  print("==================================================");
}

  /// ==============================
  /// AUTO FILL FORM
  /// ==============================

  void _fillProfileData(Map data) {

    print("==================================================");
    print("📥 AUTO FILLING FORM DATA");
    print("==================================================");

    companyNameCtrl.text = data["company_name"] ?? "";
    websiteCtrl.text = data["company_website"] ?? "";
    sizeCtrl.text = data["company_size"] ?? "";
    emailCtrl.text = data["contact_email"] ?? "";
    linkedinCtrl.text = data["linkedin_url"] ?? "";
    industryCtrl.text = data["industry"] ?? "";
    locationCtrl.text = data["location"] ?? "";
    phoneCtrl.text = data["phone"] ?? "";
    descriptionCtrl.text =
        data["company_description"] ?? data["description"] ?? "";

    print("📝 FORM FILLED SUCCESSFULLY");
  }

  /// ==============================
  /// SAVE PROFILE (CREATE / UPDATE)
  /// ==============================

  Future<void> saveProfile({required bool isEdit}) async {

    print("==================================================");
    print("🚀 SAVE PROFILE START");
    print("==================================================");

    try {

      isLoading.value = true;

      bool isEdit = profile.isNotEmpty;

      print("📝 EDIT MODE → $isEdit");

      final model = ClientProfileModel(
        companyName: companyNameCtrl.text,
        companyWebsite: websiteCtrl.text,
        companySize: sizeCtrl.text,
        contactEmail: emailCtrl.text,
        linkedinUrl: linkedinCtrl.text,
        industry: industryCtrl.text,
        location: locationCtrl.text,
        phone: phoneCtrl.text,
        description: descriptionCtrl.text,
        logo: logoUrl.value, // IMPORTANT
      );

      print("📦 MODEL JSON → ${model.toJson()}");

      final res =
          await ClientProfileRepo.saveClientProfile(model, isEdit);

      print("⬇️ SAVE PROFILE RESPONSE → $res");

      if (res != null && res["success"] == true) {

        print("✅ PROFILE SAVED SUCCESSFULLY");

        Get.snackbar("Success", "Profile saved successfully");

        await fetchProfile();
        Get.back();

      } else {

        print("❌ SAVE ERROR → ${res?["message"]}");

        Get.snackbar(
          "Error",
          res?["message"] ?? "Profile save failed",
        );
      }

    } catch (e) {

      print("❌ SAVE PROFILE EXCEPTION → $e");
      Get.snackbar("Error", e.toString());

    } finally {

      isLoading.value = false;

      print("==================================================");
      print("🏁 SAVE PROFILE END");
      print("==================================================");
    }
  }

  /// ==============================
  /// UPDATE LOGO ONLY
  /// ==============================
Future<void> updateLogo(String uploadedUrl) async {

  print("==================================================");
  print("🖼️ UPDATE LOGO START");
  print("==================================================");

  try {

    isLogoUploading.value = true;

    print("🖼️ RAW UPLOADED URL → $uploadedUrl");

    /// 🔥 Ensure relative path for backend
    String relativePath = uploadedUrl;

    if (uploadedUrl.startsWith("http")) {
      final uri = Uri.parse(uploadedUrl);
      relativePath = uri.path;
    }

    print("📁 RELATIVE PATH → $relativePath");

    /// 👇 Backend ko relative path bhejna
    final model = ClientProfileModel(
      logo: relativePath,
    );

    print("📦 LOGO MODEL JSON → ${model.toJson()}");

    final res =
        await ClientProfileRepo.saveClientProfile(model, true);

    print("⬇️ UPDATE LOGO RESPONSE → $res");

    if (res != null && res["success"] == true) {

      print("✅ LOGO UPDATED SUCCESSFULLY");

      /// 🔥 UI ke liye full URL set karo
      logoUrl.value =
          "https://freelancesupermarket.hnhsofttechsolutions.com$relativePath";

      Get.snackbar("Success", "Logo updated successfully");

      await fetchProfile();

    } else {

      print("❌ LOGO UPDATE FAILED → ${res?["message"]}");

      Get.snackbar(
        "Error",
        res?["message"] ?? "Logo update failed",
      );
    }

  } catch (e) {

    print("❌ LOGO UPDATE EXCEPTION → $e");

  } finally {

    isLogoUploading.value = false;

    print("==================================================");
    print("🏁 UPDATE LOGO END");
    print("==================================================");
  }
}


  /// ==============================
  /// DISPOSE
  /// ==============================

  @override
  void onClose() {
    companyNameCtrl.dispose();
    websiteCtrl.dispose();
    sizeCtrl.dispose();
    emailCtrl.dispose();
    linkedinCtrl.dispose();
    industryCtrl.dispose();
    locationCtrl.dispose();
    phoneCtrl.dispose();
    descriptionCtrl.dispose();
    super.onClose();
  }
}