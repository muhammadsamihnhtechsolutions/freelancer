// import 'package:flutter/material.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class FreelancerProfileView extends StatelessWidget {
//   const FreelancerProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // TITLE
//               const Text(
//                 "My Profile",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w900,
//                   letterSpacing: -0.5,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // MAIN PROFILE CARD
//               _profileCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // -----------------------------
//   // PROFILE CARD
//   // -----------------------------
//   Widget _profileCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // TITLE + EDIT BUTTON
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Profile Overview",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),

//               _editButton(),
//             ],
//           ),

//           const SizedBox(height: 24),

//           // BIO SECTION
//           const Text("Bio", style: _labelStyle),
//           const SizedBox(height: 5),
//           const Text(
//             "Hi, I am a Flutter developer with strong web dev experience.",
//             style: _valueStyle,
//           ),

//           const SizedBox(height: 18),

//           // EXPERIENCE
//           const Text("Experience", style: _labelStyle),
//           const SizedBox(height: 5),
//           const Text("2 years", style: _valueStyle),

//           const SizedBox(height: 18),

//           // SKILLS
//           const Text("Skills", style: _labelStyle),
//           const SizedBox(height: 10),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               _skillChip("React"),
//               _skillChip("SEO"),
//               _skillChip("JavaScript"),
//               _skillChip("AI"),
//               _skillChip("CSS AI"),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // PORTFOLIO LINK
//           const Text("Portfolio", style: _labelStyle),
//           const SizedBox(height: 8),

//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF3F5F9),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text(
//               "https://portfolio.com/myprofile",
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//             ),
//           ),

//           const SizedBox(height: 14),
//         ],
//       ),
//     );
//   }

//   // -----------------------------
//   // EDIT BUTTON
//   // -----------------------------
//   Widget _editButton() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primaryStart,
//             AppColors.primaryEnd,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryStart.withOpacity(0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: const [
//           Icon(Icons.edit, color: Colors.white, size: 16),
//           SizedBox(width: 6),
//           Text(
//             "Edit",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // -----------------------------
//   // SKILL CHIP
//   // -----------------------------
//   Widget _skillChip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.primaryStart.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: AppColors.primaryStart,
//           fontWeight: FontWeight.w600,
//           fontSize: 13,
//         ),
//       ),
//     );
//   }
// }

// // -----------------------------
// // TEXT STYLES
// // -----------------------------
// const _labelStyle = TextStyle(
//   fontSize: 14,
//   fontWeight: FontWeight.w800,
//   color: Colors.black87,
// );

// const _valueStyle = TextStyle(
//   fontSize: 14,
//   color: Colors.black87,
//   height: 1.4,
// );

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileController.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class FreelancerProfileScreen extends StatelessWidget {
  FreelancerProfileScreen({super.key});

  final controller = Get.put(FreelancerProfileController());

  @override
  Widget build(BuildContext context) {

    print("🟡 FREELANCER PROFILE SCREEN BUILD");

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: SafeArea(

        child: Obx(() {

          if(controller.loading.value){

            print("⏳ PROFILE LOADING");

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final p = controller.profile.value;

          if(p == null){

            print("⚠️ PROFILE DATA NULL");

            return const Center(
              child: Text("No profile found"),
            );
          }

          print("🟢 PROFILE RENDERING");

          return SingleChildScrollView(

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TITLE
                const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 20),

                /// PROFILE CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const Text(
                            "Profile Overview",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          /// EDIT BUTTON
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8),

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryStart,
                                  AppColors.primaryEnd,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryStart.withOpacity(.3),
                                  blurRadius: 12,
                                  offset: const Offset(0,4),
                                )
                              ],
                            ),

                            child: Row(
                              children: const [

                                Icon(Icons.edit,
                                    color: Colors.white,
                                    size: 16),

                                SizedBox(width: 6),

                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// BIO
                      const Text("Bio", style: _labelStyle),
                      const SizedBox(height: 5),

                      Text(
                        p.bio,
                        style: _valueStyle,
                      ),

                      const SizedBox(height: 18),

                      /// EXPERIENCE
                      const Text("Experience", style: _labelStyle),
                      const SizedBox(height: 5),

                      Text(
                        "${p.experience} years",
                        style: _valueStyle,
                      ),

                      const SizedBox(height: 18),

                      /// SKILLS
                      const Text("Skills", style: _labelStyle),
                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,

                        children: p.skills
                            .split(",")
                            .map(
                              (skill) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8),

                                decoration: BoxDecoration(
                                  color: AppColors.primaryStart.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(18),
                                ),

                                child: Text(
                                  skill.trim(),
                                  style: TextStyle(
                                    color: AppColors.primaryStart,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      /// PORTFOLIO
                      const Text("Portfolio", style: _labelStyle),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Text(
                          p.portfolioLinks,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// TEXT STYLES

const _labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w800,
  color: Colors.black87,
);

const _valueStyle = TextStyle(
  fontSize: 14,
  color: Colors.black87,
  height: 1.4,
);