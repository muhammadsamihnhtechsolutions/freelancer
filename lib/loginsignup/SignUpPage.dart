import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/SignUpController.dart';
import 'package:freelancer_app/view/BottomNavView.dart';
import 'package:get/get.dart';

import '../FreelancerDashboard/freelancerbottomnav/FreelancerBottomNavView.dart' show FreelancerBottomNavView;

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  InputDecoration _decoration({
    required String label,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue.shade700, width: 1.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Stack(
          children: [
            // ✅ Top-left Logo (like screenshot)
            Positioned(
              left: 24,
              top: 18,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "FS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Freelancer",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Supermarket",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // ✅ Center Card
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isWide ? 520 : 520),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 6),
                            const Text(
                              "Create your account",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Register in seconds to access verified freelance opportunities.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 22),

                            // ✅ Full name
                            TextFormField(
                              controller: controller.fullNameCtrl,
                              decoration: _decoration(
                                label: "Full name",
                                hint: "John Doe",
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return "Name required";
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // ✅ Email
                            TextFormField(
                              controller: controller.emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _decoration(
                                label: "Email",
                                hint: "you@example.com",
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return "Email required";
                                if (!v.contains("@")) return "Enter valid email";
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // ✅ Password (with eye icon)
                            Obx(
                              () => TextFormField(
                                controller: controller.passwordCtrl,
                                obscureText: controller.obscurePassword.value,
                                decoration: _decoration(
                                  label: "Password",
                                  hint: "Minimum 6 characters",
                                  suffixIcon: IconButton(
                                    onPressed: controller.togglePassword,
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) return "Password required";
                                  if (v.length < 6) return "Minimum 6 characters";
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 14),

                            // ✅ Country dropdown
                            Obx(
                              () => DropdownButtonFormField<String>(
                                value: controller.selectedCountry.value,
                                decoration: _decoration(
                                  label: "Country",
                                  hint: "Select your country",
                                ),
                                items: controller.countries
                                    .map((c) => DropdownMenuItem(
                                          value: c,
                                          child: Text(c),
                                        ))
                                    .toList(),
                                onChanged: (v) => controller.selectedCountry.value = v,
                                validator: (v) => v == null ? "Country required" : null,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // ✅ I want to dropdown
                            Obx(
                              () => DropdownButtonFormField<String>(
                                value: controller.selectedRole.value,
                                decoration: _decoration(label: "I want to"),
                                items: controller.roles
                                    .map((r) => DropdownMenuItem(
                                          value: r,
                                          child: Text(r),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) controller.selectedRole.value = v;
                                },
                              ),
                            ),
                            const SizedBox(height: 18),

                            // ✅ Create account button
                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
onPressed: () {
  controller.registerUser();
},
                                child: const Text(
                                  "Create account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // ✅ Already have account? Log in
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/login");
                                  },
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ✅ Footer Links
            Positioned(
              left: 0,
              right: 0,
              bottom: 18,
              child: Column(
                children: [
             
                  const SizedBox(height: 10),
                  const Text(
                    "© 2026 Freelancer Supermarket. All rights reserved.",
                    style: TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

