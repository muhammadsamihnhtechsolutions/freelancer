import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class RecentJobsWidget extends StatelessWidget {
  const RecentJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Jobs",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _jobCard("UI Designer", "£120 - £300"),
              _jobCard("Flutter App Fix", "£40"),
              _jobCard("Website SEO", "£60 - £120"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _jobCard(String title, String price) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 6),
          Text(price,
              style:
                  const TextStyle(fontSize: 13, color: Colors.black54)),
          const Spacer(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryStart,
                  AppColors.primaryEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "View Job",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}