import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class DummyWelcomeBanner extends StatelessWidget {
  const DummyWelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryStart,
              AppColors.primaryEnd,// blue/pink mix look
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Welcome back, samee",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          Text(
            "Let's find your next client today",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          // Chips Row
          Row(
            children: [
              _chip("Credits: 99999"),
              const SizedBox(width: 10),
              _chip("Profile: 100%"),
            ],
          ),

          const SizedBox(height: 16),

          // Buttons Row
          Row(
            children: [
              _btn(
                text: "Find Jobs →",
                bg: Colors.white,
                textColor: Colors.black87,
              ),
              const SizedBox(width: 12),
              _btn(
                text: "Buy Credits",
                bg: Colors.white.withOpacity(0.85),
                textColor: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Chip UI
  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // Button UI
  Widget _btn({
    required String text,
    required Color bg,
    required Color textColor,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}