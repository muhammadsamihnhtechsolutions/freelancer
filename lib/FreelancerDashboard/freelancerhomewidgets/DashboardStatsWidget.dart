import 'package:flutter/material.dart';

class DashboardStatsWidget extends StatelessWidget {
  const DashboardStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _statCard("Proposals", "12", Icons.description_outlined),
        const SizedBox(width: 10),
        _statCard("Completed", "7", Icons.check_circle_outline),
        const SizedBox(width: 10),
        _statCard("Earnings", "£824", Icons.monetization_on_outlined),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}