import 'package:flutter/material.dart';

import '../freelancerhomewidgets/ClientReviewsSetion.dart';
import '../freelancerhomewidgets/DashboardHeaderWidget.dart';
import '../freelancerhomewidgets/DashboardStatsWidget.dart';
import '../freelancerhomewidgets/DshboardMobileSection.dart';
import '../freelancerhomewidgets/DummyWelcomeBannerWidget.dart' show DummyWelcomeBanner;
import '../freelancerhomewidgets/QuickActionsWidget.dart';
import '../freelancerhomewidgets/RecentJobsWiidget.dart';
import '../freelancerhomewidgets/RecommendedJobsSection.dart';

class FreelancerDashboardView extends StatefulWidget {
  const FreelancerDashboardView({super.key});

  @override
  State<FreelancerDashboardView> createState() => _FreelancerDashboardViewState();
}

class _FreelancerDashboardViewState extends State<FreelancerDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // HEADER
              DashboardHeaderWidget(name: "John Doe"),

              SizedBox(height: 18),

DummyWelcomeBanner(),
              // QUICK ACTION BUTTONS
              
              SizedBox(height: 18),
          

              SizedBox(height: 18),

              // DASHBOARD STATS
              DashboardStatsWidget(),

              SizedBox(height: 20),

              // RECENT JOBS SLIDER
              RecentJobsWidget(),
                  SizedBox(height: 20),
              ClientReviewsSection(),
                   SizedBox(height: 20),
              RecommendedJobsSection(),

     SizedBox(height: 20),
              DashboardMobileSection(),
            ],
          ),
        ),
      ),
    );
  }
}