// import 'package:flutter/material.dart';
// import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';

// class FreelancerProfileClientSideUI extends StatelessWidget {
//   const FreelancerProfileClientSideUI({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final controller =
//         Get.put(FreelancerProfileClientSideController());

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f6fa),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Freelancers",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           children: [

//             /// 🔍 SEARCH BAR
//             Container(
//               height: 46,
//               padding: const EdgeInsets.symmetric(horizontal: 14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.05),
//                     blurRadius: 6,
//                   )
//                 ],
//               ),
//               child: TextField(
//                 controller: controller.searchCtrl,
//                 onSubmitted: (_) {
//                   print("🔎 SEARCH SUBMITTED FROM UI");
//                   controller.searchFreelancers();
//                 },
//                 decoration: const InputDecoration(
//                   hintText: "Search freelancers by name or skills...",
//                   border: InputBorder.none,
//                   icon: Icon(Icons.search),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 22),

//             /// 📋 LIST
//             Expanded(
//               child: Obx(() {

//                 print("🧾 CURRENT LIST LENGTH → ${controller.freelancers.length}");

//                 if (controller.loading.value) {
//                   return const Center(
//                       child: CircularProgressIndicator());
//                 }

//                 if (controller.freelancers.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       "No freelancers found",
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: controller.freelancers.length,
//                   itemBuilder: (context, index) {

//                     final freelancer =
//                         controller.freelancers[index];

//                     print("🧾 BUILDING CARD FOR → ${freelancer.fullName}");

//                     return _FreelancerCard(freelancer);
//                   },
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _FreelancerCard extends StatelessWidget {

//   final PublicFreelancerModel freelancer;

//   const _FreelancerCard(this.freelancer);

//   @override
//   Widget build(BuildContext context) {

//     final skillsList =
//         freelancer.skills.split(",").map((e) => e.trim()).toList();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(20),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.06),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// NAME + EXPERIENCE
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [

//               Text(
//                 freelancer.fullName,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),

//               Text(
//                 "${freelancer.experience} yrs",
//                 style: const TextStyle(
//                   color: Colors.black45,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 6),

//           /// ⭐ Rating
//           Row(
//             children: [
//               const Icon(Icons.star, size: 16, color: Colors.amber),
//               const SizedBox(width: 4),
//               Text(
//                 freelancer.rating.toStringAsFixed(1),
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 "(${freelancer.totalReviews} reviews)",
//                 style: const TextStyle(color: Colors.black54, fontSize: 12),
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           /// SKILLS
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children:
//                 skillsList.map((skill) => _Skill(skill)).toList(),
//           ),

//           const SizedBox(height: 10),

//           /// BIO
//           Text(
//             freelancer.bio,
//             style: const TextStyle(
//               color: Colors.black54,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class _Skill extends StatelessWidget {
//   final String name;

//   const _Skill(this.name);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';
// import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';

// class FreelancerProfileClientSideUI extends StatelessWidget {
//   const FreelancerProfileClientSideUI({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final controller =
//         Get.put(FreelancerProfileClientSideController());

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f6fa),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Freelancers",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           children: [

//             /// 🔎 FILTER ROW
//             Row(
//               children: [

//                 /// SEARCH
//                 Expanded(
//                   flex: 3,
//                   child: _SearchField(controller),
//                 ),

//                 const SizedBox(width: 12),

//                 /// SKILL FILTER
//                 Expanded(
//                   flex: 2,
//                   child: Obx(() => GestureDetector(
//                     onTap: () {
//                       print("🎯 SKILL FILTER CLICKED");
//                       controller.selectedSkill.value = "react";
//                       controller.searchFreelancers();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: controller.selectedSkill.value.isEmpty
//                               ? Colors.grey.shade300
//                               : Colors.blue,
//                         ),
//                       ),
//                       child: const Text(
//                         "Filter by skill (React, Node)",
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ),
//                   )),
//                 ),

//                 const SizedBox(width: 12),

//                 /// EXPERIENCE DROPDOWN
//                 Expanded(
//                   flex: 2,
//                   child: Obx(() => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: DropdownButton<String>(
//                       value: controller.selectedExperience.value,
//                       isExpanded: true,
//                       underline: const SizedBox(),
//                       items: const [
//                         DropdownMenuItem(
//                             value: "Any Experience",
//                             child: Text("Any Experience")),
//                         DropdownMenuItem(
//                             value: "1",
//                             child: Text("1+ Years")),
//                         DropdownMenuItem(
//                             value: "2",
//                             child: Text("2+ Years")),
//                         DropdownMenuItem(
//                             value: "3",
//                             child: Text("3+ Years")),
//                       ],
//                       onChanged: (v) {
//                         print("📌 EXPERIENCE SELECTED → $v");
//                         controller.selectedExperience.value = v!;
//                         controller.searchFreelancers();
//                       },
//                     ),
//                   )),
//                 ),

//                 const SizedBox(width: 12),

//                 /// RESET
//                 GestureDetector(
//                   onTap: controller.resetFilters,
//                   child: const Text(
//                     "Reset Filters",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 22),

//             /// LIST
//             Expanded(
//               child: Obx(() {

//                 if (controller.loading.value) {
//                   return const Center(
//                       child: CircularProgressIndicator());
//                 }

//                 if (controller.freelancers.isEmpty) {
//                   return const Center(
//                     child: Text("No freelancers found"),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: controller.freelancers.length,
//                   itemBuilder: (context, index) {

//                     final freelancer =
//                         controller.freelancers[index];

//                     return _FreelancerCard(freelancer);
//                   },
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final FreelancerProfileClientSideController controller;

//   const _SearchField(this.controller);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 46,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 6,
//           )
//         ],
//       ),
//       child: TextField(
//         controller: controller.searchCtrl,
//         onSubmitted: (_) {
//           print("🔎 SEARCH SUBMITTED");
//           controller.searchFreelancers();
//         },
//         decoration: const InputDecoration(
//           hintText: "Search freelancers by name or skills...",
//           border: InputBorder.none,
//           icon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }
// }
// class _FreelancerCard extends StatelessWidget {

//   final PublicFreelancerModel freelancer;

//   const _FreelancerCard(this.freelancer);

//   @override
//   Widget build(BuildContext context) {

//     final skillsList =
//         freelancer.skills.split(",").map((e) => e.trim()).toList();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(20),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.06),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// NAME + EXPERIENCE
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [

//               Text(
//                 freelancer.fullName,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),

//               Text(
//                 "${freelancer.experience} yrs",
//                 style: const TextStyle(
//                   color: Colors.black45,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 6),

//           /// ⭐ Rating
//           Row(
//             children: [
//               const Icon(Icons.star, size: 16, color: Colors.amber),
//               const SizedBox(width: 4),
//               Text(
//                 freelancer.rating.toStringAsFixed(1),
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 "(${freelancer.totalReviews} reviews)",
//                 style: const TextStyle(color: Colors.black54, fontSize: 12),
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           /// SKILLS
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children:
//                 skillsList.map((skill) => _Skill(skill)).toList(),
//           ),

//           const SizedBox(height: 10),

//           /// BIO
//           Text(
//             freelancer.bio,
//             style: const TextStyle(
//               color: Colors.black54,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// class _Skill extends StatelessWidget {
//   final String name;

//   const _Skill(this.name);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
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
import 'package:freelancer_app/frelancerprofileclientside/ProfileScreenFreelancerClientSide.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/frelancerprofileclientside/PublicFreelancerModel.dart';
import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';

class FreelancerProfileClientSideUI extends StatelessWidget {
  const FreelancerProfileClientSideUI({super.key});

  @override
  Widget build(BuildContext context) {

    final controller =
        Get.put(FreelancerProfileClientSideController());

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Freelancers",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔎 SEARCH
              _SearchField(controller),

              const SizedBox(height: 14),

              /// FILTER ROW (Mobile Responsive)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    _SkillFilter(controller),

                    const SizedBox(width: 12),

                    _ExperienceFilter(controller),

                    const SizedBox(width: 12),

                    _ResetButton(controller),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              /// LIST
              Expanded(
                child: Obx(() {

                  print("📋 FILTERED LIST LENGTH → ${controller.filteredFreelancers.length}");

                  if (controller.loading.value) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (controller.filteredFreelancers.isEmpty) {
                    return const Center(
                      child: Text(
                        "No freelancers found",
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.filteredFreelancers.length,
                    itemBuilder: (context, index) {

                      final freelancer =
                          controller.filteredFreelancers[index];

                      print("🧾 BUILDING CARD → ${freelancer.fullName}");

                      return _FreelancerCard(
                        freelancer,
                        onTap: () {
                          print("👆 CARD CLICKED → ${freelancer.id}");
                          Get.to(() => profilescreenfreelancerclientside(freelancer));
                        },
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// SEARCH FIELD
////////////////////////////////////////////////////////

class _SearchField extends StatelessWidget {
  final FreelancerProfileClientSideController controller;

  const _SearchField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: controller.searchCtrl,
        onChanged: (v) {
          print("🔎 SEARCH TEXT → $v");
          controller.applyFilters();
        },
        decoration: const InputDecoration(
          hintText: "Search freelancers by name or skills...",
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// SKILL FILTER
////////////////////////////////////////////////////////

class _SkillFilter extends StatelessWidget {
  final FreelancerProfileClientSideController controller;

  const _SkillFilter(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        print("🎯 SKILL FILTER SELECTED → React");
        controller.selectedSkill.value = "react";
        controller.applyFilters();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: controller.selectedSkill.value.isEmpty
                ? Colors.grey.shade300
                : Colors.blue,
          ),
        ),
        child: const Text("Filter by skill (React)"),
      ),
    ));
  }
}

////////////////////////////////////////////////////////
/// EXPERIENCE FILTER
////////////////////////////////////////////////////////

class _ExperienceFilter extends StatelessWidget {
  final FreelancerProfileClientSideController controller;

  const _ExperienceFilter(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: controller.selectedExperience.value,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(
              value: "Any Experience",
              child: Text("Any Experience")),
          DropdownMenuItem(
              value: "1",
              child: Text("1+ Years")),
          DropdownMenuItem(
              value: "2",
              child: Text("2+ Years")),
          DropdownMenuItem(
              value: "3",
              child: Text("3+ Years")),
        ],
        onChanged: (v) {
          print("📌 EXPERIENCE FILTER → $v");
          controller.selectedExperience.value = v!;
          controller.applyFilters();
        },
      ),
    ));
  }
}

////////////////////////////////////////////////////////
/// RESET
////////////////////////////////////////////////////////

class _ResetButton extends StatelessWidget {
  final FreelancerProfileClientSideController controller;

  const _ResetButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("♻️ RESET FILTERS");
        controller.resetFilters();
      },
      child: const Text(
        "Reset Filters",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// CARD
////////////////////////////////////////////////////////

class _FreelancerCard extends StatelessWidget {

  final PublicFreelancerModel freelancer;
  final VoidCallback onTap;

  const _FreelancerCard(this.freelancer, {required this.onTap});

  @override
  Widget build(BuildContext context) {

    final skillsList =
        freelancer.skills.split(",").map((e) => e.trim()).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// NAME + EXPERIENCE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    freelancer.fullName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text("${freelancer.experience} yrs"),
              ],
            ),

            const SizedBox(height: 6),

            /// ⭐ DYNAMIC STARS
            Row(
              children: List.generate(5, (index) {
                if (index < freelancer.rating.floor()) {
                  return const Icon(Icons.star,
                      size: 18, color: Colors.amber);
                } else if (index < freelancer.rating) {
                  return const Icon(Icons.star_half,
                      size: 18, color: Colors.amber);
                } else {
                  return const Icon(Icons.star_border,
                      size: 18, color: Colors.amber);
                }
              }),
            ),

            const SizedBox(height: 10),

            /// SKILLS
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  skillsList.map((skill) => _Skill(skill)).toList(),
            ),

            const SizedBox(height: 10),

            /// BIO
            Text(
              freelancer.bio,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// SKILL CHIP
////////////////////////////////////////////////////////

class _Skill extends StatelessWidget {
  final String name;

  const _Skill(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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

////////////////////////////////////////////////////////
/// PROFILE SCREEN
////////////////////////////////////////////////////////

// class _ProfileScreen extends StatelessWidget {

//   final PublicFreelancerModel freelancer;

//   const _ProfileScreen(this.freelancer);

//   @override
//   Widget build(BuildContext context) {

//     print("📄 PROFILE SCREEN OPENED → ${freelancer.fullName}");

//     return Scaffold(
//       appBar: AppBar(title: Text(freelancer.fullName)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Text(freelancer.bio),
//       ),
//     );
//   }
// }