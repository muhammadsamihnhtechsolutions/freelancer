import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class DashboardHeaderBanner extends StatelessWidget {
  const DashboardHeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isMobile ? 18 : 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryStart,
            AppColors.primaryEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔵 GREETING
          Text(
            "Welcome back, SAMEE 👋",
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Manage talent. Build faster. Stay in control.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: isMobile ? 12 : 14,
            ),
          ),

          const SizedBox(height: 14),

          // 🔵 BUTTONS (Mobile Style – full width)
          Row(
            children: [
              Expanded(
                child: _WhiteButton(
                  text: "Post a Job",
                  icon: Icons.add,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GlassButton(
                  text: "Buy Credits",
                  icon: Icons.attach_money,
                  onTap: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔵 MOBILE-FRIENDLY STATS ROW
Row(
  children: const [
    _StatItemCompact("0", "Posted", Icons.work_outline),
    SizedBox(width: 10),
    _StatItemCompact("0", "Proposals", Icons.person_outline),
    SizedBox(width: 10),
    _StatItemCompact("0", "Hires", Icons.check_circle_outline),
    SizedBox(width: 10),
    _StatItemCompact("2", "Credits", Icons.attach_money),
  ],
)
        ],
      ),
    );
  }
}
class _StatItemCompact extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;

  const _StatItemCompact(this.value, this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _WhiteButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _WhiteButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _GlassButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem(this.value, this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 11,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}