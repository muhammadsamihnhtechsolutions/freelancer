// import 'package:flutter/material.dart';

// import '../freelancerhomewidgets/ClientReviewsSetion.dart';
// import '../freelancerhomewidgets/DashboardHeaderWidget.dart';
// import '../freelancerhomewidgets/DashboardStatsWidget.dart';
// import '../freelancerhomewidgets/DshboardMobileSection.dart';
// import '../freelancerhomewidgets/DummyWelcomeBannerWidget.dart' show DummyWelcomeBanner;
// import '../freelancerhomewidgets/RecommendedJobsSection.dart';

// class FreelancerDashboardView extends StatefulWidget {
//   const FreelancerDashboardView({super.key});

//   @override
//   State<FreelancerDashboardView> createState() => _FreelancerDashboardViewState();
// }

// class _FreelancerDashboardViewState extends State<FreelancerDashboardView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const DashboardHeaderWidget(),
//       backgroundColor: const Color(0xFFF4F6FA),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               // HEADER
       

//               SizedBox(height: 18),

// DummyWelcomeBanner(),
//               // QUICK ACTION BUTTONS
              
//               SizedBox(height: 18),
          

//               SizedBox(height: 18),

//               // DASHBOARD STATS
//               DashboardStatsWidget(),

//               SizedBox(height: 20),

//               // RECENT JOBS SLIDER
//               // RecentJobsWidget(),
//                   SizedBox(height: 20),
//               ClientReviewsSection(),
//                    SizedBox(height: 20),
//               RecommendedJobsSection(),

//      SizedBox(height: 20),
//               DashboardMobileSection(),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/view/widgets/FreelancerReviews.dart';
import 'package:get/get.dart';

import '../freelancerhomewidgets/ClientReviewsSetion.dart';
import '../freelancerhomewidgets/DashboardHeaderWidget.dart';
import '../freelancerhomewidgets/DashboardStatsWidget.dart';
import '../freelancerhomewidgets/DshboardMobileSection.dart';
import '../freelancerhomewidgets/DummyWelcomeBannerWidget.dart' show DummyWelcomeBanner;
import '../freelancerhomewidgets/RecommendedJobsSection.dart';

import 'package:freelancer_app/frelancerprofileclientside/FreelancerProfileClientSideController.dart';

class FreelancerDashboardView extends StatefulWidget {
  const FreelancerDashboardView({
    super.key,
    this.freelancerUserId = "",
  });

  final String freelancerUserId;

  @override
  State<FreelancerDashboardView> createState() => _FreelancerDashboardViewState();
}

class _FreelancerDashboardViewState extends State<FreelancerDashboardView> {
  late final FreelancerProfileClientSideController freelancerController;

  @override
  void initState() {
    super.initState();

    freelancerController =
        Get.isRegistered<FreelancerProfileClientSideController>()
            ? Get.find<FreelancerProfileClientSideController>()
            : Get.put(FreelancerProfileClientSideController());
  }

  String _resolveFreelancerId() {
    final args = Get.arguments;
    String resolvedId = widget.freelancerUserId;

    print("==================================================");
    print("📌 FREELANCER DASHBOARD OPEN");
    print("➡️ constructor freelancerUserId => ${widget.freelancerUserId}");
    print("➡️ Get.arguments => $args");
    print("==================================================");

    /// 1) constructor se
    if (resolvedId.trim().isNotEmpty) {
      print("✅ FREELANCER ID FROM CONSTRUCTOR => $resolvedId");
      return resolvedId;
    }

    /// 2) Get.arguments se
    if (args != null) {
      if (args is Map && args["freelancerUserId"] != null) {
        resolvedId = args["freelancerUserId"].toString();
        if (resolvedId.trim().isNotEmpty) {
          print("✅ FREELANCER ID FROM ARGUMENTS.freelancerUserId => $resolvedId");
          return resolvedId;
        }
      }

      if (args is Map && args["assigned_freelancer_id"] != null) {
        resolvedId = args["assigned_freelancer_id"].toString();
        if (resolvedId.trim().isNotEmpty) {
          print("✅ FREELANCER ID FROM ARGUMENTS.assigned_freelancer_id => $resolvedId");
          return resolvedId;
        }
      }

      if (args is Map && args["freelancer_id"] != null) {
        resolvedId = args["freelancer_id"].toString();
        if (resolvedId.trim().isNotEmpty) {
          print("✅ FREELANCER ID FROM ARGUMENTS.freelancer_id => $resolvedId");
          return resolvedId;
        }
      }

      if (args is String && args.trim().isNotEmpty) {
        resolvedId = args.trim();
        print("✅ FREELANCER ID FROM STRING ARGUMENT => $resolvedId");
        return resolvedId;
      }
    }

    /// 3) selectedFreelancer se
    try {
      final selected = freelancerController.selectedFreelancer.value;
      final selectedId = selected?.id.toString() ?? "";

      print("➡️ selectedFreelancer.id => $selectedId");

      if (selectedId.trim().isNotEmpty) {
        print("✅ FREELANCER ID FROM selectedFreelancer => $selectedId");
        return selectedId;
      }
    } catch (e) {
      print("❌ selectedFreelancer ID READ ERROR => $e");
    }

    /// 4) freelancers list ka first item
    try {
      if (freelancerController.freelancers.isNotEmpty) {
        final firstId = freelancerController.freelancers.first.id.toString();

        print("➡️ freelancers.first.id => $firstId");

        if (firstId.trim().isNotEmpty) {
          print("✅ FREELANCER ID FROM freelancers.first => $firstId");
          return firstId;
        }
      } else {
        print("⚠️ freelancerController.freelancers is empty");
      }
    } catch (e) {
      print("❌ freelancers.first ID READ ERROR => $e");
    }

    print("❌ FREELANCER ID NOT FOUND ANYWHERE");
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final resolvedFreelancerUserId = _resolveFreelancerId();

      print("--------------------------------------------------");
      print("🔄 FREELANCER DASHBOARD REBUILD");
      print("✅ resolvedFreelancerUserId => $resolvedFreelancerUserId");
      print("--------------------------------------------------");

      return Scaffold(
        appBar: const DashboardHeaderWidget(),
        backgroundColor: const Color(0xFFF4F6FA),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                const DummyWelcomeBanner(),
                const SizedBox(height: 18),
                const SizedBox(height: 18),
                const DashboardStatsWidget(),
                const SizedBox(height: 20),

                if (resolvedFreelancerUserId.trim().isNotEmpty)
                  FreelancerReviewsSection(
                    userId: resolvedFreelancerUserId,
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Freelancer id missing",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),
                const RecommendedJobsSection(),
                const SizedBox(height: 20),
                const DashboardMobileSection(),
              ],
            ),
          ),
        ),
      );
    });
  }
}