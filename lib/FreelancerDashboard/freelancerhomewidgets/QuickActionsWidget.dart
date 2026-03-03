import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _actionButton(Icons.search, "Find Jobs"),
        const SizedBox(width: 10),
        _actionButton(Icons.send, "My Proposals"),
        const SizedBox(width: 10),
        _actionButton(Icons.edit, "Edit Profile"),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryStart,
              AppColors.primaryEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}