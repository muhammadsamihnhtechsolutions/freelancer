

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';

// class profilescreenfreelancerclientside extends StatelessWidget {

//   final PublicFreelancerModel freelancer;

//   const profilescreenfreelancerclientside(this.freelancer, {super.key});

//   @override
//   Widget build(BuildContext context) {

//     print("=====================================");
//     print("📄 PROFILE SCREEN OPENED");
//     print("👤 NAME → ${freelancer.fullName}");
//     print("⭐ RATING → ${freelancer.rating}");
//     print("=====================================");

//     final skillsList =
//         freelancer.skills.split(",").map((e) => e.trim()).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f6fa),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

           

//               const SizedBox(height: 16),

//               /// MAIN WHITE CARD
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.06),
//                       blurRadius: 18,
//                       offset: const Offset(0, 8),
//                     )
//                   ],
//                 ),

//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [

//                     /// NAME + EXPERIENCE
//                     Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [

//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [

//                               Text(
//                                 freelancer.fullName,
//                                 style: const TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),

//                               const SizedBox(height: 6),

//                               Text(
//                                 freelancer.skills,
//                                 style: const TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         Text(
//                           "${freelancer.experience} yrs experience",
//                           style: const TextStyle(
//                             color: Colors.black45,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 14),

//                     /// ⭐ DYNAMIC RATING
//                     Row(
//                       children: [

//                         Row(
//                           children: List.generate(5, (index) {
//                             if (index < freelancer.rating.floor()) {
//                               return const Icon(Icons.star,
//                                   size: 20,
//                                   color: Colors.amber);
//                             } else if (index < freelancer.rating) {
//                               return const Icon(Icons.star_half,
//                                   size: 20,
//                                   color: Colors.amber);
//                             } else {
//                               return const Icon(Icons.star_border,
//                                   size: 20,
//                                   color: Colors.amber);
//                             }
//                           }),
//                         ),

//                         const SizedBox(width: 8),

//                         Text(
//                           "(${freelancer.totalReviews} reviews)",
//                           style: const TextStyle(
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 18),

//                     /// BIO
//                     Text(
//                       freelancer.bio,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         height: 1.5,
//                         color: Colors.black87,
//                       ),
//                     ),

//                     const SizedBox(height: 22),

//                     /// SKILL CHIPS
//                     Wrap(
//                       spacing: 10,
//                       runSpacing: 10,
//                       children: skillsList
//                           .map((skill) {
//                             print("🧠 SKILL CHIP → $skill");
//                             return _SkillChip(skill);
//                           })
//                           .toList(),
//                     ),

//                     const SizedBox(height: 28),

//                     /// PORTFOLIO
//                     const Text(
//                       "Portfolio:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffeef2ff),
//                         borderRadius:
//                             BorderRadius.circular(20),
//                       ),
//                       child: const Text(
//                         "hd/profile",
//                         style: TextStyle(
//                           color: Color(0xff3b4cca),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     /// IMAGE-MATCH BACK BUTTON (NOT FULL WIDTH)
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                         height: 46,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(30),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xff2563eb),
//                               Color(0xff4f46e5),
//                             ],
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0xff4f46e5)
//                                   .withOpacity(.3),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             )
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             borderRadius:
//                                 BorderRadius.circular(30),
//                             onTap: () {
//                               print(
//                                   "⬅ GRADIENT BACK BUTTON CLICKED");
//                               Get.back();
//                             },
//                             child: const Padding(
//                               padding:
//                                   EdgeInsets.symmetric(
//                                       horizontal: 22,
//                                       vertical: 12),
//                               child: Text(
//                                 "← Back to Freelancers",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight:
//                                       FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ////////////////////////////////////////////////////////
// /// SKILL CHIP
// ////////////////////////////////////////////////////////

// class _SkillChip extends StatelessWidget {

//   final String name;

//   const _SkillChip(this.name);

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 6,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xffeef2ff),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         name,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w600,
//           color: Color(0xff3b4cca),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';
import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';

class profilescreenfreelancerclientside extends StatefulWidget {
  final PublicFreelancerModel freelancer;

  const profilescreenfreelancerclientside(this.freelancer, {super.key});

  @override
  State<profilescreenfreelancerclientside> createState() =>
      _profilescreenfreelancerclientsideState();
}

class _profilescreenfreelancerclientsideState
    extends State<profilescreenfreelancerclientside> {
  late final FreelancerProfileClientSideController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<FreelancerProfileClientSideController>()
        ? Get.find<FreelancerProfileClientSideController>()
        : Get.put(FreelancerProfileClientSideController());

    print("=====================================");
    print("📄 PROFILE SCREEN OPENED");
    print("👤 INITIAL NAME → ${widget.freelancer.fullName}");
    print("🆔 INITIAL ID → ${widget.freelancer.id}");
    print("⭐ INITIAL RATING → ${widget.freelancer.rating}");
    print("=====================================");

    if (widget.freelancer.id.toString().trim().isNotEmpty) {
      controller.fetchFreelancerProfile(widget.freelancer.id.toString());
    } else {
      print("❌ FREELANCER ID EMPTY, PROFILE FETCH SKIPPED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isLoading = controller.profileLoading.value;

      final PublicFreelancerModel freelancer =
          controller.selectedFreelancer.value ?? widget.freelancer;

      final skillsList =
          freelancer.skills.split(",").map((e) => e.trim()).toList();

      print("=====================================");
      print("🔄 PROFILE SCREEN REBUILD");
      print("⏳ profileLoading → $isLoading");
      print("👤 ACTIVE NAME → ${freelancer.fullName}");
      print("🆔 ACTIVE ID → ${freelancer.id}");
      print("⭐ ACTIVE RATING → ${freelancer.rating}");
      print("📝 TOTAL REVIEWS → ${freelancer.totalReviews}");
      print("=====================================");

      return Scaffold(
        backgroundColor: const Color(0xfff5f6fa),
        body: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// MAIN WHITE CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// NAME + EXPERIENCE
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        freelancer.fullName,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        freelancer.skills,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${freelancer.experience} yrs experience",
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            /// ⭐ DYNAMIC RATING
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    final starIndex = index + 1;
                                    final double ratingValue =
                                        freelancer.rating.toDouble();

                                    if (ratingValue >= starIndex) {
                                      return const Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.amber,
                                      );
                                    } else if (ratingValue >=
                                        starIndex - 0.5) {
                                      return const Icon(
                                        Icons.star_half,
                                        size: 20,
                                        color: Colors.amber,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.star_border,
                                        size: 20,
                                        color: Colors.amber,
                                      );
                                    }
                                  }),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${freelancer.rating.toStringAsFixed(1)} (${freelancer.totalReviews} reviews)",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            /// BIO
                            Text(
                              freelancer.bio,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 22),

                            /// SKILL CHIPS
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: skillsList.map((skill) {
                                print("🧠 SKILL CHIP → $skill");
                                return _SkillChip(skill);
                              }).toList(),
                            ),

                            const SizedBox(height: 28),

                            /// PORTFOLIO
                            const Text(
                              "Portfolio:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffeef2ff),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "hd/profile",
                                style: TextStyle(
                                  color: Color(0xff3b4cca),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            /// IMAGE-MATCH BACK BUTTON (NOT FULL WIDTH)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff2563eb),
                                      Color(0xff4f46e5),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff4f46e5)
                                          .withOpacity(.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      print("⬅ GRADIENT BACK BUTTON CLICKED");
                                      Get.back();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        "← Back to Freelancers",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}

class _SkillChip extends StatelessWidget {
  final String name;

  const _SkillChip(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffeef2ff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xff3b4cca),
        ),
      ),
    );
  }
}