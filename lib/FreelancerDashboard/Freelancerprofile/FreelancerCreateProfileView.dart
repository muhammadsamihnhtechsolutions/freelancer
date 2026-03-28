// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileController.dart';
// import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class FreelancerCreateProfileView extends StatelessWidget {
//   FreelancerCreateProfileView({super.key});

//   final controller = Get.find<FreelancerProfileController>();

//   final skillsCtrl = TextEditingController();
//   final portfolioCtrl = TextEditingController();
//   final expCtrl = TextEditingController();
//   final bioCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     print("🟢 FreelancerCreateProfileView BUILD");

//     return Scaffold(
//       backgroundColor: const Color(0xfff4f6fa),

//       appBar: AppBar(
//         title: const Text("Create Freelancer Profile"),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),

//       body: Obx(() {

//         print("📊 Loading → ${controller.loading.value}");

//         if (controller.loading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(20),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               const SizedBox(height: 10),

//               /// SKILLS
//               const Text(
//                 "Skills (comma separated)",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 6),

//               _field(
//                 controller: skillsCtrl,
//                 hint: "react, seo, javascript, ai",
//               ),

//               const SizedBox(height: 20),

//               /// PORTFOLIO
//               const Text(
//                 "Portfolio Links (comma separated URLs)",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 6),

//               _field(
//                 controller: portfolioCtrl,
//                 hint: "https://yourportfolio.com",
//               ),

//               const SizedBox(height: 20),

//               /// EXPERIENCE
//               const Text(
//                 "Experience (years)",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 6),

//               _field(
//                 controller: expCtrl,
//                 hint: "2",
//                 keyboard: TextInputType.number,
//               ),

//               const SizedBox(height: 20),

//               /// BIO
//               const Text(
//                 "Bio",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 6),

//               TextField(
//                 controller: bioCtrl,
//                 maxLines: 4,
//                 decoration: _decoration("Write about yourself"),
//               ),

//               const SizedBox(height: 30),

//               /// BUTTON
//               SizedBox(
//                 width: double.infinity,

//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryStart,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),

//                   onPressed: () {

//                     print("🟢 CREATE PROFILE BUTTON CLICKED");

//                     final model = FreelancerProfileModel(
//                       userId: "",
//                       skills: skillsCtrl.text,
//                       portfolioLinks: portfolioCtrl.text,
//                       experience: int.tryParse(expCtrl.text) ?? 0,
//                       bio: bioCtrl.text,
//                     );

//                     print("📤 SENDING PROFILE DATA → ${model.toJson()}");

//                     controller.createProfile(model);
//                   },

//                   child: const Text(
//                     "Create Profile",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//             ],
//           ),
//         );
//       }),
//     );
//   }

//   /// FIELD
//   Widget _field({
//     required TextEditingController controller,
//     required String hint,
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboard,
//       decoration: _decoration(hint),
//     );
//   }

//   /// DECORATION
//   InputDecoration _decoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileController.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class FreelancerCreateProfileView extends StatelessWidget {

  final bool isEdit;
  final FreelancerProfileModel? profile;

  FreelancerCreateProfileView({
    super.key,
    this.isEdit = false,
    this.profile,
  });

  final controller = Get.find<FreelancerProfileController>();

  final skillsCtrl = TextEditingController();
  final portfolioCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final bioCtrl = TextEditingController();

  void _setInitialData() {

    if (profile != null) {

      print("🧠 PREFILLING PROFILE DATA");

      skillsCtrl.text = profile!.skills;
      portfolioCtrl.text = profile!.portfolioLinks;
      expCtrl.text = profile!.experience.toString();
      bioCtrl.text = profile!.bio;
    }
  }

  @override
  Widget build(BuildContext context) {

    print("🟢 FreelancerCreateProfileView BUILD");

    _setInitialData();

    return Scaffold(
      backgroundColor: const Color(0xfff4f6fa),

      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Freelancer Profile" : "Create Freelancer Profile",
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Obx(() {

        print("📊 Loading → ${controller.loading.value}");

        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              /// SKILLS
              const Text(
                "Skills (comma separated)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              _field(
                controller: skillsCtrl,
                hint: "react, seo, javascript, ai",
              ),

              const SizedBox(height: 20),

              /// PORTFOLIO
              const Text(
                "Portfolio Links (comma separated URLs)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              _field(
                controller: portfolioCtrl,
                hint: "https://yourportfolio.com",
              ),

              const SizedBox(height: 20),

              /// EXPERIENCE
              const Text(
                "Experience (years)",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              _field(
                controller: expCtrl,
                hint: "2",
                keyboard: TextInputType.number,
              ),

              const SizedBox(height: 20),

              /// BIO
              const Text(
                "Bio",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              TextField(
                controller: bioCtrl,
                maxLines: 4,
                decoration: _decoration("Write about yourself"),
              ),

              const SizedBox(height: 30),

              /// BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryStart,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  onPressed: () {

                    print("🟢 PROFILE BUTTON CLICKED");

                    final model = FreelancerProfileModel(
                      userId: "",
                      skills: skillsCtrl.text,
                      portfolioLinks: portfolioCtrl.text,
                      experience: int.tryParse(expCtrl.text) ?? 0,
                      bio: bioCtrl.text,
                    );

                    print("📤 PROFILE DATA → ${model.toJson()}");

                    if (isEdit) {

                      print("🟡 UPDATE PROFILE MODE");

                      controller.updateProfile(model);

                    } else {

                      print("🟢 CREATE PROFILE MODE");

                      controller.createProfile(model);

                    }
                  },

                  child: Text(
                    isEdit ? "Update Profile" : "Create Profile",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        );
      }),
    );
  }

  /// FIELD
  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: _decoration(hint),
    );
  }

  /// DECORATION
  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}