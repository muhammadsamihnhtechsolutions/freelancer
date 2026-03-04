import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FindJobViews.dart' show FindJobsView;
import 'package:get/get.dart';

import '../Freelancerprofile/FreelancerProfileView.dart';
import '../myperposal/MyProposelView.dart';
import 'FreelancerBottomNav.dart';
import 'FreelancerBottomNavController.dart';
import '../../theme/AppColors.dart';
import 'FreelancerDashboardView.dart';

// TODO: replace with your real screens later


class FreelancerBottomNavView extends StatelessWidget {
  FreelancerBottomNavView({super.key});

  final FreelancerBottomNavController controller =
      Get.put(FreelancerBottomNavController());

  final pages = [
    const FreelancerDashboardView(),
    const FindJobsView(),
    const MyProposalsView(),
    FreelancerProfileScreen(),
  ];

  static const Color bg = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.index.value;

      return Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [
            /// 🔵 Blue Glow (same as client)
            Positioned(
              top: -120,
              left: -120,
              child: Container(
                height: 260,
                width: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryStart.withOpacity(0.22),
                      AppColors.primaryEnd.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -140,
              right: -140,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryEnd.withOpacity(0.18),
                      AppColors.primaryStart.withOpacity(0.04),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
            ),

            /// Main content
            SafeArea(
              bottom: false,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 260),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: IndexedStack(
                  key: ValueKey(index),
                  index: index,
                  children: pages,
                ),
              ),
            ),
          ],
        ),

        /// ⭐ Floating Glass BottomNavigation (same as client)
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryStart.withOpacity(0.9),
                        AppColors.primaryEnd.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryStart.withOpacity(0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  /// ⭐ same navigation system as client-side
                  child: FreelancerCustomBottomNav(
                    currentIndex: index,
                    onTap: (i) {
                      HapticFeedback.lightImpact();
                      controller.setIndex(i);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}