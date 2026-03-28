import 'package:flutter/material.dart';
import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
import 'package:freelancer_app/view/widgets/AppTopBar.dart';
import 'package:freelancer_app/view/widgets/DashBoardHeaderBanner.dart';
import 'package:freelancer_app/view/widgets/FreelancerReviews.dart';
import 'package:freelancer_app/view/widgets/JobSetion.dart';
import 'package:freelancer_app/view/widgets/WeeklyGraphs.dart';

import '../widgets/ProfileStrengthWidget.dart';
import '../widgets/RecentActivitywidget.dart';

import 'package:get/get.dart';


class DashboardPage extends StatelessWidget {
   DashboardPage({super.key});

    final controller = Get.put(GraphActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
        appBar: const AppTopBar(),
      body: Row(
        children: [

          /// LEFT SIDEBAR
          // const DashboardSidebar(),

          /// MAIN AREA
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // GREETING BANNER (BLUE)
                  const DashboardHeaderBanner(),

                  const SizedBox(height: 20),

                  // PROFILE STRENGTH BOX
           const JobsSectionWidget(jobs: [],),
                  const SizedBox(height: 20),

ProfileStrengthWidget(),
                  const SizedBox(height: 20),
// 
                  const SizedBox(height: 20),
                  
WeeklyActivityCard(),

                  // JOB STATUS & EMPTY LIST AREA
                  // JobsOverviewSection(),
                    const SizedBox(height: 20),  
RecentActivityWidget(),
// FreelancerReviewsSection(
//   userId: proposal.userId,
// )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';
// import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
// import 'package:freelancer_app/view/widgets/AppTopBar.dart';
// import 'package:freelancer_app/view/widgets/DashBoardHeaderBanner.dart';
// import 'package:freelancer_app/view/widgets/FreelancerReviews.dart';
// import 'package:freelancer_app/view/widgets/JobSetion.dart';
// import 'package:freelancer_app/view/widgets/WeeklyGraphs.dart';
// import '../widgets/ProfileStrengthWidget.dart';
// import '../widgets/RecentActivitywidget.dart';
// import 'package:get/get.dart';

// class DashboardPage extends StatelessWidget {
//   final String freelancerUserId;

//   DashboardPage({
//     super.key,
//     this.freelancerUserId = "",
//   });

//   final GraphActivityController controller =
//       Get.put(GraphActivityController());

//   final FreelancerProfileClientSideController freelancerController =
//       Get.isRegistered<FreelancerProfileClientSideController>()
//           ? Get.find<FreelancerProfileClientSideController>()
//           : Get.put(FreelancerProfileClientSideController());

//   String _resolveFreelancerId() {
//     final args = Get.arguments;
//     String resolvedId = freelancerUserId;

//     print("==================================================");
//     print("📌 DASHBOARD PAGE OPEN");
//     print("➡️ constructor freelancerUserId => $freelancerUserId");
//     print("➡️ Get.arguments => $args");
//     print("==================================================");

//     /// 1) constructor se
//     if (resolvedId.trim().isNotEmpty) {
//       print("✅ FREELANCER ID FROM CONSTRUCTOR => $resolvedId");
//       return resolvedId;
//     }

//     /// 2) Get.arguments se
//     if (args != null) {
//       if (args is Map && args["freelancerUserId"] != null) {
//         resolvedId = args["freelancerUserId"].toString();
//         if (resolvedId.trim().isNotEmpty) {
//           print("✅ FREELANCER ID FROM ARGUMENTS.freelancerUserId => $resolvedId");
//           return resolvedId;
//         }
//       }

//       if (args is Map && args["assigned_freelancer_id"] != null) {
//         resolvedId = args["assigned_freelancer_id"].toString();
//         if (resolvedId.trim().isNotEmpty) {
//           print(
//               "✅ FREELANCER ID FROM ARGUMENTS.assigned_freelancer_id => $resolvedId");
//           return resolvedId;
//         }
//       }

//       if (args is String && args.trim().isNotEmpty) {
//         resolvedId = args.trim();
//         print("✅ FREELANCER ID FROM STRING ARGUMENT => $resolvedId");
//         return resolvedId;
//       }
//     }

//     /// 3) selectedFreelancer se
//     try {
//       final selected = freelancerController.selectedFreelancer.value;
//       final selectedId = selected?.id.toString() ?? "";

//       print("➡️ selectedFreelancer.id => $selectedId");

//       if (selectedId.trim().isNotEmpty) {
//         print("✅ FREELANCER ID FROM selectedFreelancer => $selectedId");
//         return selectedId;
//       }
//     } catch (e) {
//       print("❌ selectedFreelancer ID READ ERROR => $e");
//     }

//     /// 4) freelancers list ka first item
//     try {
//       if (freelancerController.freelancers.isNotEmpty) {
//         final firstId =
//             freelancerController.freelancers.first.id.toString();

//         print("➡️ freelancers.first.id => $firstId");

//         if (firstId.trim().isNotEmpty) {
//           print("✅ FREELANCER ID FROM freelancers.first => $firstId");
//           return firstId;
//         }
//       } else {
//         print("⚠️ freelancerController.freelancers is empty");
//       }
//     } catch (e) {
//       print("❌ freelancers.first ID READ ERROR => $e");
//     }

//     print("❌ FREELANCER ID NOT FOUND ANYWHERE");
//     return "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final resolvedFreelancerUserId = _resolveFreelancerId();

//       print("--------------------------------------------------");
//       print("🔄 DASHBOARD REBUILD");
//       print("✅ resolvedFreelancerUserId => $resolvedFreelancerUserId");
//       print("--------------------------------------------------");

//       return Scaffold(
//         backgroundColor: const Color(0xFFF6F7FB),
//         appBar: const AppTopBar(),
//         body: Row(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const DashboardHeaderBanner(),
//                     const SizedBox(height: 20),

//                     const JobsSectionWidget(jobs: []),
//                     const SizedBox(height: 20),

//                     // ProfileStrengthWidget(),
//                     // const SizedBox(height: 20),

//                     // WeeklyActivityCard(),
//                     // const SizedBox(height: 20),

//                     // RecentActivityWidget(),
//                     // const SizedBox(height: 20),

//                     if (resolvedFreelancerUserId.trim().isNotEmpty)
//                       FreelancerReviewsSection(
//                         userId: resolvedFreelancerUserId,
//                       )
//                     else
//                       Container(
//                         padding: const EdgeInsets.all(14),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Text(
//                           "Freelancer id missing",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                           const SizedBox(height: 20),

//                          ProfileStrengthWidget(),
//                     const SizedBox(height: 20),

//                     WeeklyActivityCard(),
//                     const SizedBox(height: 20),

//                     RecentActivityWidget(),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }