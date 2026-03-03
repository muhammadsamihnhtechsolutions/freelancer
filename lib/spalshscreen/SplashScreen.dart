// import 'package:flutter/material.dart';
// import 'package:freelancer_app/spalshscreen/SplashController.dart';
// import 'package:get/get.dart';


// class SplashPage extends GetView<SplashController> {
//   const SplashPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Logo box (same style like your signup)
//                 Container(
//                   width: 84,
//                   height: 84,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade700,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.06),
//                         blurRadius: 18,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "FS",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 28,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 const Text(
//                   "Freelancer Supermarket",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//                 const SizedBox(height: 6),

//                 const Text(
//                   "Find verified freelance opportunities\nin seconds.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 13,
//                     height: 1.3,
//                   ),
//                 ),

//                 const SizedBox(height: 28),

//                 const SizedBox(
//                   width: 26,
//                   height: 26,
//                   child: CircularProgressIndicator(strokeWidth: 2.6),
//                 ),

//                 const SizedBox(height: 36),

//                 const Text(
//                   "© 2026 Freelancer Supermarket",
//                   style: TextStyle(
//                     color: Colors.black45,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:freelancer_app/spalshscreen/SplashController.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// 🌈 Background Gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryStart,
              AppColors.primaryEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// ⭐ Only Logo in Center (NO ClipOval)
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    "assets/logo.jpg", // ← Set your exact logo path here
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                    frameBuilder: (_, child, frame, __) {
                      if (frame == null) {
                        return SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.6,
                          ),
                        );
                      }
                      return child;
                    },
                  ),
                ),

                const SizedBox(height: 26),

                /// Loader
                const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.6,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                /// Footer
                const Text(
                  "© 2026 Freelancer Supermarket",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}