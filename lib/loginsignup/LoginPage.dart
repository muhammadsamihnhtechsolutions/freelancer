

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/loginsignup/LoginController.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/Routes/AppRoutes.dart';

// class LoginPage extends GetView<LoginController> {
//   const LoginPage({super.key});

//   InputDecoration _dec(String label, String hint, {Widget? suffix}) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       suffixIcon: suffix,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: Colors.blue.shade700, width: 1.4),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Top Left Logo
//             Positioned(
//               left: 24,
//               top: 18,
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade700,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "FS",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Freelancer",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w900, fontSize: 16),
//                       ),
//                       Text(
//                         "Supermarket",
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),

//             // Center Card
//             Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 520),
//                   child: Card(
//                     elevation: 0,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                       side: BorderSide(color: Colors.grey.shade200),
//                     ),
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
//                       child: Form(
//                         key: controller.formKey,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Text(
//                               "Log in to Freelancer Supermarket",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             const Text(
//                               "Welcome back! Access verified jobs, manage credits, and\n"
//                               "grow your freelance career.",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 13,
//                               ),
//                             ),
//                             const SizedBox(height: 26),

//                             // Email
//                             TextFormField(
//                               controller: controller.email,
//                               decoration: _dec(
//                                 "Email",
//                                 "you@example.com",
//                               ),
//                               validator: (v) {
//                                 if (v == null || v.isEmpty) return "Email required";
//                                 if (!v.contains("@")) return "Enter valid email";
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 14),

//                             // Password
//                             Obx(
//                               () => TextFormField(
//                                 controller: controller.password,
//                                 obscureText: controller.obscure.value,
//                                 decoration: _dec(
//                                   "Password",
//                                   "Your password",
//                                   suffix: IconButton(
//                                     onPressed: controller.togglePassword,
//                                     icon: Icon(
//                                       controller.obscure.value
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                     ),
//                                   ),
//                                 ),
//                                 validator: (v) {
//                                   if (v == null || v.isEmpty) return "Password required";
//                                   return null;
//                                 },
//                               ),
//                             ),

//                             const SizedBox(height: 8),

//                             // Forgot password
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: InkWell(
//                                 onTap: () {},
//                                 child: Text(
//                                   "Forgot password?",
//                                   style: TextStyle(
//                                     color: Colors.blue.shade700,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 18),

//                             // Login Button
//                             Obx(
//                               () => SizedBox(
//                                 width: double.infinity,
//                                 height: 46,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.blue.shade700,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   onPressed: controller.loading.value
//                                       ? null
//                                       : () => controller.loginUser(), // <-- API FLOW
//                                   child: controller.loading.value
//                                       ? const CircularProgressIndicator(
//                                           color: Colors.white,
//                                         )
//                                       : const Text(
//                                           "Log in",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w800,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 16),

//                             // Signup link
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   "Don’t have an account? ",
//                                   style: TextStyle(color: Colors.black54),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Get.offAllNamed(AppRoutes.SIGNUP);
//                                   },
//                                   child: Text(
//                                     "Sign up",
//                                     style: TextStyle(
//                                       color: Colors.blue.shade700,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 22),

//                             const Text(
//                               "Secure login • Trusted by freelancers & clients",
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.black54),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Footer
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 18,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _footer("Terms"),
//                       _footer("Privacy"),
//                       _footer("Cookie Policy"),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "© 2026 Freelancer Supermarket. All rights reserved.",
//                     style: TextStyle(color: Colors.black45, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _footer(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: InkWell(
//         onTap: () {},
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.black54,
//             fontSize: 12,
//             decoration: TextDecoration.underline,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/LoginController.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/Routes/AppRoutes.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  InputDecoration _dec(String label, String hint, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF6F7FB),

        body: SafeArea(
          child: Stack(
            children: [

              /// LOGO
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
                            fontSize: 18,
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
                              fontWeight: FontWeight.w900, fontSize: 16),
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

              /// CENTER LOGIN CARD
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 30),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              const Text(
                                "Log in to Freelancer Supermarket",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Welcome back! Access verified jobs, manage credits, and\n"
                                "grow your freelance career.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 26),

                              /// EMAIL
                              TextFormField(
                                controller: controller.email,
                                decoration: _dec(
                                  "Email",
                                  "you@example.com",
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) return "Email required";
                                  if (!v.contains("@")) return "Enter valid email";
                                  return null;
                                },
                              ),

                              const SizedBox(height: 14),

                              /// PASSWORD
                              Obx(
                                () => TextFormField(
                                  controller: controller.password,
                                  obscureText: controller.obscure.value,
                                  decoration: _dec(
                                    "Password",
                                    "Your password",
                                    suffix: IconButton(
                                      onPressed: controller.togglePassword,
                                      icon: Icon(
                                        controller.obscure.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v == null || v.isEmpty)
                                      return "Password required";
                                    return null;
                                  },
                                ),
                              ),

                              const SizedBox(height: 8),

                              /// FORGOT PASSWORD
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// LOGIN BUTTON
                              Obx(
                                () => SizedBox(
                                  width: double.infinity,
                                  height: 46,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade700,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: controller.loading.value
                                        ? null
                                        : () => controller.loginUser(),
                                    child: controller.loading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Log in",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              /// SIGNUP
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don’t have an account? ",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.offAllNamed(AppRoutes.SIGNUP);
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 22),

                              const Text(
                                "Secure login • Trusted by freelancers & clients",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// FOOTER (keyboard open hone par hide)
              if (!keyboardOpen)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 18,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _footer("Terms"),
                          _footer("Privacy"),
                          _footer("Cookie Policy"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "© 2026 Freelancer Supermarket. All rights reserved.",
                        style:
                            TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}