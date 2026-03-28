


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:freelancer_app/ClientProfilePage/ClientProfileController.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class ClientProfilePage extends StatelessWidget {
//   ClientProfilePage({super.key});

//   /// ✅ FIX 1: Use existing controller (NO duplicate instance)
//   final controller = Get.find<ClientProfileController>();

//   @override
//   Widget build(BuildContext context) {

//     print("🖥️ ClientProfilePage BUILD");

//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F4F7),
//       body: SafeArea(
//         child: Obx(() {

//           print("🔄 Profile Obx Rebuild");

//           final client = controller.profile;

//           if (controller.isLoading.value) {
//             print("⏳ Loading...");
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (client.isEmpty) {
//             print("⚠️ No profile found");
//             return const Center(
//               child: Text(
//                 "No profile found",
//                 style: TextStyle(fontSize: 16),
//               ),
//             );
//           }

//           print("✅ Profile Loaded → ${client["company_name"]}");

//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 _pageHeader(),
//                 const SizedBox(height: 20),

//                 _profileHeaderCard(client),

//                 const SizedBox(height: 24),

//                 _sectionTitle("About Company"),
//                 const SizedBox(height: 10),
//                 _aboutText(client["company_description"] ?? ""),

//                 const SizedBox(height: 24),

//                 _sectionTitle("Company Information"),
//                 const SizedBox(height: 12),

//                 _infoGrid(client),

//                 const SizedBox(height: 30),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   /// HEADER
//   Widget _pageHeader() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Client Profile",
//           style: TextStyle(
//             fontSize: 26,
//             fontWeight: FontWeight.w800,
//             color: Color(0xFF0F172A),
//           ),
//         ),
//         SizedBox(height: 6),
//         Text(
//           "Manage your company information",
//           style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
//         ),
        
//       ],
      
//     );
    
//   }

//   /// PROFILE CARD
//   Widget _profileHeaderCard(client) {

//     print("📦 Building Profile Header Card");

//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.withOpacity(.15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 14,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// ✅ FIX 2: Dynamic Logo (no design change)
//           Obx(() {

//             print("🖼️ Logo Refresh → ${controller.logoUrl.value}");

//             if (controller.logoUrl.value.isEmpty) {
//               return Container(
//                 height: 64,
//                 width: 64,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryStart.withOpacity(.15),
//                       AppColors.primaryEnd.withOpacity(.15),
//                     ],
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.business,
//                   size: 30,
//                   color: Color(0xFF1E293B),
//                 ),
//               );
//             }

//             return Container(
//               height: 64,
//               width: 64,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: NetworkImage(controller.logoUrl.value),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           }),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Text(
//                   client["company_name"] ?? "",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   client["industry"] ?? "",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF64748B),
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.location_on_rounded,
//                       size: 16,
//                       color: Color(0xFF64748B),
//                     ),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         client["location"] ?? "",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Color(0xFF64748B),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 10),

//           InkWell(
//             onTap: () {
//               print("✏️ Edit Clicked");
//               Get.toNamed(
//                 "/createClientProfile",
//                 arguments: controller.profile,
//               );
//             },
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 14,
//                 vertical: 9,
//               ),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryStart,
//                     AppColors.primaryEnd,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Text(
//                 "Edit",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w700,
//       ),
//     );
//   }

//   Widget _aboutText(String about) {

//     print("📝 About Section Rendered");

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.withOpacity(.15)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.04),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           )
//         ],
//       ),
//       child: Text(
//         about.isEmpty ? "No description provided." : about,
//         style: const TextStyle(
//           fontSize: 14,
//           height: 1.5,
//           color: Color(0xFF475569),
//         ),
//       ),
//     );
//   }

//   Widget _infoGrid(client) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: _infoTile(
//                 title: "Website",
//                 value: client["company_website"] ?? "",
//                 icon: Icons.language,
//                 clickable: true,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _infoTile(
//                 title: "Email",
//                 value: client["contact_email"] ?? "",
//                 icon: Icons.email_outlined,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: _infoTile(
//                 title: "Phone",
//                 value: client["phone"] ?? "",
//                 icon: Icons.phone,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _infoTile(
//                 title: "LinkedIn",
//                 value: client["linkedin_url"] ?? "",
//                 icon: Icons.link,
//                 clickable: true,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _infoTile({
//     required String title,
//     required String value,
//     required IconData icon,
//     bool clickable = false,
//   }) {
//     return InkWell(
//       onTap: clickable ? () => _launchUrl(value) : null,
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: Colors.grey.withOpacity(.15)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.04),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             )
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 20, color: AppColors.primaryStart),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: Color(0xFF64748B),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     value.isEmpty ? "-" : value,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: clickable
//                           ? Colors.blue
//                           : const Color(0xFF0F172A),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _launchUrl(String url) async {

//     print("🌐 Launch URL → $url");

//     if (url.isEmpty) return;

//     final uri =
//         Uri.parse(url.startsWith("http") ? url : "https://$url");

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//       print("✅ URL Launched");
//     } else {
//       print("❌ URL Failed");
//     }
//   }
  
  
// }



import 'package:flutter/material.dart';
import 'package:freelancer_app/Routes/AppRoutes.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancer_app/ClientProfilePage/ClientProfileController.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class ClientProfilePage extends StatelessWidget {
  ClientProfilePage({super.key});

  final controller = Get.find<ClientProfileController>();

  @override
  Widget build(BuildContext context) {
    print("🖥️ ClientProfilePage BUILD");

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Obx(() {
          print("🔄 Profile Obx Rebuild");

          final client = controller.profile;

          if (controller.isLoading.value) {
            print("⏳ Loading...");
            return const Center(child: CircularProgressIndicator());
          }

          if (client.isEmpty) {
            print("⚠️ No profile found");
            return const Center(
              child: Text(
                "No profile found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          print("✅ Profile Loaded → ${client["company_name"]}");

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pageHeader(),
                const SizedBox(height: 20),

                _profileHeaderCard(client),

                const SizedBox(height: 24),

                _sectionTitle("About Company"),
                const SizedBox(height: 10),
                _aboutText(client["company_description"] ?? ""),

                const SizedBox(height: 24),

                _sectionTitle("Company Information"),
                const SizedBox(height: 12),

                _infoGrid(client),

                const SizedBox(height: 30),

                _logoutButton(),

                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _pageHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Client Profile",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Manage your company information",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _profileHeaderCard(dynamic client) {
    print("📦 Building Profile Header Card");

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            print("🖼️ Logo Refresh → ${controller.logoUrl.value}");

            if (controller.logoUrl.value.isEmpty) {
              return Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryStart.withOpacity(.15),
                      AppColors.primaryEnd.withOpacity(.15),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.business,
                  size: 30,
                  color: Color(0xFF1E293B),
                ),
              );
            }

            return Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(controller.logoUrl.value),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client["company_name"] ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  client["industry"] ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        client["location"] ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          InkWell(
            onTap: () {
              print("✏️ Edit Clicked");
              Get.toNamed(
                "/createClientProfile",
                arguments: controller.profile,
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryStart,
                    AppColors.primaryEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Edit",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _aboutText(String about) {
    print("📝 About Section Rendered");

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        about.isEmpty ? "No description provided." : about,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _infoGrid(dynamic client) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _infoTile(
                title: "Website",
                value: client["company_website"] ?? "",
                icon: Icons.language,
                clickable: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoTile(
                title: "Email",
                value: client["contact_email"] ?? "",
                icon: Icons.email_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _infoTile(
                title: "Phone",
                value: client["phone"] ?? "",
                icon: Icons.phone,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoTile(
                title: "LinkedIn",
                value: client["linkedin_url"] ?? "",
                icon: Icons.link,
                clickable: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoTile({
    required String title,
    required String value,
    required IconData icon,
    bool clickable = false,
  }) {
    return InkWell(
      onTap: clickable ? () => _launchUrl(value) : null,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.withOpacity(.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primaryStart),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value.isEmpty ? "-" : value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: clickable ? Colors.blue : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return InkWell(
      onTap: () async {
        print("🚪 Logout Clicked");

        final prefs = await SharedPreferences.getInstance();

        await prefs.remove("token");
        await prefs.remove("role");
        await prefs.remove("client_token");
        await prefs.remove("freelancer_token");

        Get.offAllNamed(AppRoutes.LOGIN);

        Get.snackbar(
          "Success",
          "Logged out successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(.20),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    print("🌐 Launch URL → $url");

    if (url.isEmpty) return;

    final uri = Uri.parse(
      url.startsWith("http") ? url : "https://$url",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      print("✅ URL Launched");
    } else {
      print("❌ URL Failed");
    }
  }
}