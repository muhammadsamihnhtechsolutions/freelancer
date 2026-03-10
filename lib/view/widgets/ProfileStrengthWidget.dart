import 'package:flutter/material.dart';
import 'package:freelancer_app/ClientProfilePage/ClientProfileController.dart';
import 'package:get/get.dart';


class ProfileStrengthWidget extends StatelessWidget {
  ProfileStrengthWidget({super.key});

  final controller = Get.find<ClientProfileController>();

  @override
  Widget build(BuildContext context) {

    print("📊 ProfileStrengthWidget BUILD");

    return Obx(() {

      print("🔄 ProfileStrengthWidget Obx Rebuild");

      final profile = controller.profile;

      /// Count filled fields
      int totalFields = 4;
      int filled = 0;

      bool hasName = (profile["company_name"] ?? "").toString().isNotEmpty;
      bool hasDesc = (profile["company_description"] ?? "").toString().isNotEmpty;
      bool hasWebsite = (profile["company_website"] ?? "").toString().isNotEmpty;
      bool hasLogo = controller.logoUrl.value.isNotEmpty;

      if (hasName) filled++;
      if (hasDesc) filled++;
      if (hasWebsite) filled++;
      if (hasLogo) filled++;

      double percent = filled / totalFields;
      int percentText = (percent * 100).toInt();

      print("📈 Profile Strength → $percentText%");
      print("📌 Filled Fields → $filled / $totalFields");

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Profile Strength",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// CIRCLE METER
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: percent,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF18C462)),
                      ),
                      Text(
                        "$percentText%",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                /// TEXT COLUMN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        percentText == 100
                            ? "Excellent profile"
                            : percentText >= 50
                                ? "Good profile"
                                : "Incomplete profile",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "Strong profiles get better freelancers.",
                        style: TextStyle(fontSize: 12),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Text(
                            "Credits: ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "$filled",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5A5BFF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// CHECKLIST
            _checkItem("company name", hasName),
            _checkItem("company description", hasDesc),
            _checkItem("company website", hasWebsite),
            _checkItem("logo", hasLogo),

            const SizedBox(height: 16),

            Row(
              children: [
                Icon(Icons.edit_outlined, size: 18, color: Colors.blue.shade600),
                const SizedBox(width: 4),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _checkItem(String text, bool completed) {

    print("✔ Checklist Item → $text | Completed: $completed");

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: completed
                ? const Color(0xFF18C462)
                : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}