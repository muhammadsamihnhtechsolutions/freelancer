// import 'package:flutter/material.dart';
// import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
// import 'package:freelancer_app/view/Clientdashboard/PostJobPage.dart';
// import 'package:freelancer_app/view/widgets/AppTopBar.dart';
// import 'package:freelancer_app/view/widgets/ClientGetReviewsWidget.dart';
// import 'package:freelancer_app/view/widgets/DashBoardHeaderBanner.dart';
// import 'package:freelancer_app/view/widgets/FreelancerReviews.dart';
// import 'package:freelancer_app/view/widgets/JobSetion.dart';
// import 'package:freelancer_app/view/widgets/WeeklyGraphs.dart';

// import '../widgets/ProfileStrengthWidget.dart';
// import '../widgets/RecentActivitywidget.dart';

// import 'package:get/get.dart';


// class DashboardPage extends StatelessWidget {
//    DashboardPage({super.key});

//     final controller = Get.put(GraphActivityController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//         appBar: const AppTopBar(),
//       body: Row(
//         children: [

//           /// LEFT SIDEBAR
//           // const DashboardSidebar(),

//           /// MAIN AREA
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   // GREETING BANNER (BLUE)
//                   // const DashboardHeaderBanner(),
//                   DashboardHeaderBanner(
//   firstName: "Samee",
//   postedCount: 12,
//   proposalsCount: 35,
//   hiresCount: 4,
//   creditsCount: 20,
//   onPostJobTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => PostJob(),
//       ),
//     );
//   },
// ),
// ClientGetReviewsWidget(
//   jobId: widget.jobId,
// ),
//                   const SizedBox(height: 20),

//                   // PROFILE STRENGTH BOX
//            const JobsSectionWidget(jobs: [],),
//                   const SizedBox(height: 20),

// ProfileStrengthWidget(),
//                   const SizedBox(height: 20),
// // 
//                   const SizedBox(height: 20),
                  
// WeeklyActivityCard(),

//                   // JOB STATUS & EMPTY LIST AREA
//                   // JobsOverviewSection(),
//                     const SizedBox(height: 20),  
// RecentActivityWidget(),
// // FreelancerReviewsSection(
// //   userId: proposal.userId,
// // )

//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
import 'package:freelancer_app/view/Clientdashboard/PostJobPage.dart';
import 'package:freelancer_app/view/widgets/AppTopBar.dart';
import 'package:freelancer_app/view/widgets/ClientGetReviewsWidget.dart';
import 'package:freelancer_app/view/widgets/DashBoardHeaderBanner.dart';
import 'package:freelancer_app/view/widgets/JobSetion.dart';
import 'package:freelancer_app/view/widgets/WeeklyGraphs.dart';
import '../widgets/ProfileStrengthWidget.dart';
import '../widgets/RecentActivitywidget.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    super.key,
    this.userId = "af0587c1-c5b6-47b9-9300-104d824bd9ae",
  });

  final String userId;
  final controller = Get.put(GraphActivityController());

  @override
  Widget build(BuildContext context) {
    print("==================================================");
    print("📌 DASHBOARD PAGE BUILD");
    print("➡️ USER ID => $userId");
    print("==================================================");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: const AppTopBar(),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardHeaderBanner(
                    firstName: "Samee",
                    postedCount: 12,
                    proposalsCount: 35,
                    hiresCount: 4,
                    creditsCount: 20,
                    onPostJobTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostJob(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  if (userId.trim().isNotEmpty)
                    ClientGetReviewsWidget(
                      jobId: userId,
                    ),

                  const SizedBox(height: 20),

                  const JobsSectionWidget(jobs: []),
                  const SizedBox(height: 20),

                  ProfileStrengthWidget(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),

                  WeeklyActivityCard(),

                  const SizedBox(height: 20),
                  RecentActivityWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}