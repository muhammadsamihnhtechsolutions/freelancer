import 'dart:ui';
 // ✅ blue gradient colors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/controller/DashboardController.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:freelancer_app/view/Clientdashboard/BottomnavFreelancer.dart';
import 'package:freelancer_app/view/Clientdashboard/ClientProfilePage.dart';
import 'package:freelancer_app/view/Clientdashboard/HomeView.dart';
import 'package:freelancer_app/view/Jobs.dart';
import 'package:freelancer_app/view/widgets/CustomeBottomNav.dart';
import 'package:get/get.dart';

import 'Clientdashboard/PostJobPage.dart';

class BottomNavView extends StatelessWidget {
  BottomNavView({super.key});
final DashboardController controller = Get.find<DashboardController>();
final pages = [
  DashboardPage(),              // 0
  AdminJobsPage(),              // 1
  ClientFreelancerProfileUI(),  // 2
  PostJobMobilePage(),                // 3  ← Add this!
  ClientProfilePage(),          // 4
];
  static const Color bg = Color(0xFF0D0D0D);
  static const Color navBg = Color(0xFF121212);

  // back handling
  final Rx<DateTime> _lastBack = DateTime.fromMillisecondsSinceEpoch(0).obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.selectedIndex.value;

      return WillPopScope(
        onWillPop: () async {
          // If not on Home -> go to Home
          if (index != 0) {
            HapticFeedback.lightImpact();
            controller.changeIndex(0);
            return false;
          }

          // Double back to exit
          final now = DateTime.now();
          if (now.difference(_lastBack.value).inMilliseconds < 1200) {
            return true;
          }
          _lastBack.value = now;

          Get.snackbar(
            'Exit',
            'Press back again to exit',
            backgroundColor: const Color(0xFF1A1A1A),
            colorText: Colors.white,
            duration: const Duration(milliseconds: 900),
            margin: const EdgeInsets.all(12),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,

          /// Background premium blue glow
          body: Stack(
            children: [
              // 🔵 top-left blue gradient glow
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

              // 🔵 bottom-right blue gradient glow
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
                  transitionBuilder: (child, anim) {
                    final fade = FadeTransition(opacity: anim, child: child);
                    final scale = ScaleTransition(
                      scale: Tween<double>(begin: 0.985, end: 1.0).animate(anim),
                      child: fade,
                    );
                    return scale;
                  },

                  // ✅ Preserve state with IndexedStack
                  child: IndexedStack(
                    key: ValueKey(index),
                    index: index,
                    children: pages,
                  ),
                ),
              ),
            ],
          ),

          /// Floating glass bottom nav
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
  child: CustomBottomNav(
    currentIndex: index,
    onTap: (i) {
      HapticFeedback.lightImpact();
      controller.changeIndex(i);
    },
  ),
)
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}