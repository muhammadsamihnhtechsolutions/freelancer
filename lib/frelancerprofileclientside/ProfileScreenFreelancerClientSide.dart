// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';

// class profilescreenfreelancerclientside extends StatelessWidget {

//   final PublicFreelancerModel freelancer;

//   const profilescreenfreelancerclientside(this.freelancer, {super.key});

//   @override
//   Widget build(BuildContext context) {

//     print("📄 PROFILE SCREEN OPENED → ${freelancer.fullName}");

//     final skillsList =
//         freelancer.skills.split(",").map((e) => e.trim()).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f6fa),

//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(18),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),

//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.06),
//                     blurRadius: 15,
//                     offset: const Offset(0, 6),
//                   )
//                 ],
//               ),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   /// NAME + EXPERIENCE
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [

//                             Text(
//                               freelancer.fullName,
//                               style: const TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),

//                             const SizedBox(height: 6),

//                             Text(
//                               freelancer.skills,
//                               style: const TextStyle(
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       Text(
//                         "${freelancer.experience} yrs experience",
//                         style: const TextStyle(
//                           color: Colors.black45,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 14),

//                   /// ⭐ RATING
//                   Row(
//                     children: [

//                       Row(
//                         children: List.generate(5, (index) {
//                           if (index < freelancer.rating.floor()) {
//                             return const Icon(Icons.star,
//                                 size: 20,
//                                 color: Colors.amber);
//                           } else if (index < freelancer.rating) {
//                             return const Icon(Icons.star_half,
//                                 size: 20,
//                                 color: Colors.amber);
//                           } else {
//                             return const Icon(Icons.star_border,
//                                 size: 20,
//                                 color: Colors.amber);
//                           }
//                         }),
//                       ),

//                       const SizedBox(width: 8),

//                       Text(
//                         "(${freelancer.totalReviews} reviews)",
//                         style: const TextStyle(
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 18),

//                   /// BIO
//                   Text(
//                     freelancer.bio,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// SKILL CHIPS
//                   Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: skillsList
//                         .map((skill) => _SkillChip(skill))
//                         .toList(),
//                   ),

//                   const SizedBox(height: 24),

//                   /// PORTFOLIO
//                   const Text(
//                     "Portfolio:",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 14, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xffeef2ff),
//                       borderRadius:
//                           BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       "hd/profile",
//                       style: TextStyle(
//                         color: Color(0xff3b4cca),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   /// BACK BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: InkWell(
//                       onTap: () {
//                         print("⬅ BACK TO FREELANCERS");
//                         Get.back();
//                       },
//                       borderRadius:
//                           BorderRadius.circular(30),
//                       child: Ink(
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(30),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xff2563eb),
//                               Color(0xff4f46e5),
//                             ],
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "← Back to Freelancers",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight:
//                                   FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
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

class profilescreenfreelancerclientside extends StatelessWidget {

  final PublicFreelancerModel freelancer;

  const profilescreenfreelancerclientside(this.freelancer, {super.key});

  @override
  Widget build(BuildContext context) {

    print("=====================================");
    print("📄 PROFILE SCREEN OPENED");
    print("👤 NAME → ${freelancer.fullName}");
    print("⭐ RATING → ${freelancer.rating}");
    print("=====================================");

    final skillsList =
        freelancer.skills.split(",").map((e) => e.trim()).toList();

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔙 TOP BACK LINK
              // GestureDetector(
              //   onTap: () {
              //     print("⬅ TOP BACK CLICKED");
              //     Get.back();
              //   },
              //   child: const Text(
              //     "← Back to Freelancers",
              //     style: TextStyle(
              //       color: Color(0xff2563eb),
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),

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
                            if (index < freelancer.rating.floor()) {
                              return const Icon(Icons.star,
                                  size: 20,
                                  color: Colors.amber);
                            } else if (index < freelancer.rating) {
                              return const Icon(Icons.star_half,
                                  size: 20,
                                  color: Colors.amber);
                            } else {
                              return const Icon(Icons.star_border,
                                  size: 20,
                                  color: Colors.amber);
                            }
                          }),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          "(${freelancer.totalReviews} reviews)",
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
                      children: skillsList
                          .map((skill) {
                            print("🧠 SKILL CHIP → $skill");
                            return _SkillChip(skill);
                          })
                          .toList(),
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
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xffeef2ff),
                        borderRadius:
                            BorderRadius.circular(20),
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
                          borderRadius:
                              BorderRadius.circular(30),
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
                            borderRadius:
                                BorderRadius.circular(30),
                            onTap: () {
                              print(
                                  "⬅ GRADIENT BACK BUTTON CLICKED");
                              Get.back();
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 12),
                              child: Text(
                                "← Back to Freelancers",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.w700,
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
  }
}

////////////////////////////////////////////////////////
/// SKILL CHIP
////////////////////////////////////////////////////////

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