// import 'package:flutter/material.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class DashboardHeaderWidget extends StatelessWidget {
//   final String name;

//   const DashboardHeaderWidget({super.key, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primaryStart,
//             AppColors.primaryEnd,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryStart.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Avatar
//           const CircleAvatar(
//             radius: 28,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.person, color: Colors.black87, size: 32),
//           ),
//           const SizedBox(width: 16),

//           // Welcome text
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Welcome Back,",
//                     style: TextStyle(color: Colors.white70, fontSize: 14)),
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/NotificationClientside/ClientSideNotificationPage.dart';
// import 'package:freelancer_app/controller/DashboardController.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/theme/AppColors.dart';
// import 'package:freelancer_app/ClientProfilePage/ClientProfileController.dart';

// class DashboardHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
//   const DashboardHeaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final controller = Get.find<ClientProfileController>();

//     return SafeArea(
//       bottom: false,
//       child: Container(
//         width: double.infinity,
//         height: 90,
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.primaryStart,
//               AppColors.primaryEnd,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryStart.withOpacity(0.3),
//               blurRadius: 15,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [

//             /// 🌟 LEFT SIDE (LOGO)
//             Image.asset(
//               "assets/logo.jpg",
//               height: 40,
//               fit: BoxFit.contain,
//             ),

//             const Spacer(),

//             /// 🌟 RIGHT SIDE
//             Row(
//               children: [

//                 /// 🔔 Notification
//                 InkWell(
//                   onTap: () {

//                     print("🔔 NAVIGATING WITH TRANSITION");

//                     Get.to(
//                       () => const ClientSideNotificationPage(),
//                       transition: Transition.rightToLeft,
//                       duration: const Duration(milliseconds: 300),
//                     );
//                   },
//                   borderRadius: BorderRadius.circular(50),
//                   child: Container(
//                     height: 42,
//                     width: 42,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white.withOpacity(0.15),
//                     ),
//                     child: const Icon(
//                       Icons.notifications_none,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 14),

//                 /// 👤 Profile Avatar
//                 InkWell(
//                   onTap: () {
//                     Get.find<DashboardController>().changeIndex(4);
//                   },
//                   borderRadius: BorderRadius.circular(50),
//                   child: Container(
//                     height: 42,
//                     width: 42,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.35),
//                         width: 1.5,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.primaryStart.withOpacity(0.3),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         )
//                       ],
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         "assets/logo.jpg",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(90);
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerNotification.dart/FreelancerNotificationScreen.dart';
import 'package:freelancer_app/NotificationClientside/ClientSideNotificationPage.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class DashboardHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const DashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryStart,
              AppColors.primaryEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// LEFT SIDE LOGO
            Image.asset(
              "assets/logo.jpg",
              height: 38,
              fit: BoxFit.contain,
            ),

            /// RIGHT SIDE NOTIFICATION
            InkWell(
              onTap: () {

                print("🔔 NAVIGATING WITH TRANSITION");

                Get.to(
                  () =>  FreelancerNotificationScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 38,
                width: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}