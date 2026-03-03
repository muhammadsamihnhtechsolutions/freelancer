import 'package:flutter/material.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const AppTopBar({
    super.key,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryStart.withOpacity(0.95),
              AppColors.primaryEnd.withOpacity(0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// 🌟 LEFT SIDE (LOGO)
            Row(
              children: [
                Image.asset(
                  "assets/logo.jpg",
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),

            /// 🌟 RIGHT SIDE (Notification + Profile)
            Row(
              children: [

                /// 🔔 Notification
              /// 👤 Profile Avatar (Safe Loading + Fallback)
InkWell(
  onTap: onProfileTap,
  borderRadius: BorderRadius.circular(50),
  child: Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white.withOpacity(0.35),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryStart.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 2,
        )
      ],
    ),
    child: ClipOval(
      child: Image.asset(
        "assets/profile.jpg",
        width: 20,
        height: 20,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 18,
            ),
          );
        },
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            return Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            );
          }
          return child;
        },
      ),
    ),
  ),
),
                const SizedBox(width: 14),

                /// 👤 Profile Avatar
                InkWell(
                  onTap: onProfileTap,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryStart.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                      image: const DecorationImage(
                        image: AssetImage("assets/profile.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}