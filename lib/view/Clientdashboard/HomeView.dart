import 'package:flutter/material.dart';
import 'package:freelancer_app/view/widgets/AppTopBar.dart';
import 'package:freelancer_app/view/widgets/DashBoardHeaderBanner.dart';
import 'package:freelancer_app/view/widgets/JobSetion.dart';
import 'package:freelancer_app/view/widgets/WeeklyGraphs.dart';

import '../widgets/FreelancerReviews.dart';
import '../widgets/ProfileStrengthWidget.dart';
import '../widgets/RecentActivitywidget.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
           const JobsEmptyStateWidget(),
                  const SizedBox(height: 20),

ProfileStrengthWidget(),
                  const SizedBox(height: 20),
                  FreelancerReviewsSection(),
                  const SizedBox(height: 20),
                  
WeeklyActivityCard(),

                  // JOB STATUS & EMPTY LIST AREA
                  // JobsOverviewSection(),
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