

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileController.dart';
// import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerCreateProfileView.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class FreelancerProfileScreen extends StatelessWidget {
//   FreelancerProfileScreen({super.key});

//   final controller = Get.find<FreelancerProfileController>();

//   @override
//   Widget build(BuildContext context) {

//     print("🟡 FREELANCER PROFILE SCREEN BUILD");

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),

//       body: SafeArea(
//         child: Obx(() {

//           if (controller.loading.value) {

//             print("⏳ PROFILE LOADING");

//             return const Center(child: CircularProgressIndicator());
//           }

//           final p = controller.profile.value;

//           if (p == null) {

//             print("⚠️ PROFILE DATA NULL");

//             return const Center(child: Text("No profile found"));
//           }

//           print("🟢 PROFILE RENDERING");

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(18),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [

//                 const Text(
//                   "My Profile",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),

//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(.05),
//                         blurRadius: 20,
//                         offset: const Offset(0,8),
//                       )
//                     ],
//                   ),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       /// HEADER
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [

//                           const Text(
//                             "Profile Overview",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),

//                           /// EDIT BUTTON
//                           InkWell(
//                             onTap: () {

//                               print("✏️ EDIT PROFILE CLICKED");

//                               Get.to(
//                                 FreelancerCreateProfileView(
//                                   isEdit: true,
//                                   profile: p,
//                                 ),
//                               );
//                             },

//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 14,
//                                   vertical: 8),

//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     AppColors.primaryStart,
//                                     AppColors.primaryEnd,
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),

//                               child: const Row(
//                                 children: [

//                                   Icon(Icons.edit,
//                                       color: Colors.white,
//                                       size: 16),

//                                   SizedBox(width: 6),

//                                   Text(
//                                     "Edit",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),

//                       const SizedBox(height: 25),

//                       /// BIO
//                       const Text("Bio", style: _labelStyle),
//                       const SizedBox(height: 6),

//                       Text(p.bio, style: _valueStyle),

//                       const SizedBox(height: 20),

//                       /// EXPERIENCE
//                       const Text("Experience", style: _labelStyle),
//                       const SizedBox(height: 6),

//                       Text("${p.experience} years", style: _valueStyle),

//                       const SizedBox(height: 20),

//                       /// SKILLS
//                       const Text("Skills", style: _labelStyle),
//                       const SizedBox(height: 10),

//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,

//                         children: p.skills
//                             .split(",")
//                             .map(
//                               (skill) => Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 14,
//                                     vertical: 8),

//                                 decoration: BoxDecoration(
//                                   color: AppColors.primaryStart.withOpacity(.1),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),

//                                 child: Text(
//                                   skill.trim(),
//                                   style: TextStyle(
//                                     color: AppColors.primaryStart,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),

//                       const SizedBox(height: 20),

//                       /// PORTFOLIO
//                       const Text("Portfolio", style: _labelStyle),

//                       const SizedBox(height: 8),

//                       Container(
//                         padding: const EdgeInsets.all(12),

//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF3F5F9),
//                           borderRadius: BorderRadius.circular(12),
//                         ),

//                         child: Text(
//                           p.portfolioLinks,
//                           style: const TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// const _labelStyle = TextStyle(
//   fontSize: 14,
//   fontWeight: FontWeight.w800,
// );

// const _valueStyle = TextStyle(
//   fontSize: 14,
//   height: 1.4,
// );
import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/LogoutController.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileController.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerCreateProfileView.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class FreelancerProfileScreen extends StatelessWidget {
  FreelancerProfileScreen({super.key});

  final controller = Get.find<FreelancerProfileController>();

  final LogoutController logoutController =
      Get.isRegistered<LogoutController>()
          ? Get.find<LogoutController>()
          : Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    print("🟡 FREELANCER PROFILE SCREEN BUILD");

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Obx(() {
          if (controller.loading.value) {
            print("⏳ PROFILE LOADING");
            return const Center(child: CircularProgressIndicator());
          }

          final p = controller.profile.value;

          if (p == null) {
            print("⚠️ PROFILE DATA NULL");
            return const Center(child: Text("No profile found"));
          }

          print("🟢 PROFILE RENDERING");

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
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
                          InkWell(
                            onTap: () {
                              print("✏️ EDIT PROFILE CLICKED");

                              Get.to(
                                FreelancerCreateProfileView(
                                  isEdit: true,
                                  profile: p,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryStart,
                                    AppColors.primaryEnd,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
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
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 25),

                      /// BIO
                      const Text("Bio", style: _labelStyle),
                      const SizedBox(height: 6),
                      Text(p.bio, style: _valueStyle),

                      const SizedBox(height: 20),

                      /// EXPERIENCE
                      const Text("Experience", style: _labelStyle),
                      const SizedBox(height: 6),
                      Text("${p.experience} years", style: _valueStyle),

                      const SizedBox(height: 20),

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
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryStart.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  skill.trim(),
                                  style: TextStyle(
                                    color: AppColors.primaryStart,
                                    fontWeight: FontWeight.w600,
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          p.portfolioLinks,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// LOGOUT BUTTON
                InkWell(
                  onTap: () async {
                    print("🚪 FREELANCER LOGOUT CLICKED");
                    await logoutController.logoutUser();
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(.18),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

const _labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w800,
);

const _valueStyle = TextStyle(
  fontSize: 14,
  height: 1.4,
);