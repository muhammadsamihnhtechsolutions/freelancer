
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'ClientProfileController.dart';

// class CreateClientProfilePage extends StatelessWidget {
//   CreateClientProfilePage({super.key});

//   final controller = Get.put(ClientProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff5f5f7),

//       appBar: AppBar(
//         title: const Text("Create Client Profile"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Container(
//           padding: const EdgeInsets.all(16),

//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               )
//             ],
//           ),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               /// PROFILE IMAGE
//               Center(
//                 child: Column(
//                   children: [

//                     const CircleAvatar(
//                       radius: 45,
//                       backgroundImage:
//                           NetworkImage("https://i.pravatar.cc/150?img=3"),
//                     ),

//                     const SizedBox(height: 8),

//                     ElevatedButton(
//                       onPressed: () {},
//                       child: const Text("Upload Photo"),
//                     )
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 25),

//               _buildField("Company Name", controller.companyNameCtrl),
//               _buildField("Company Website", controller.websiteCtrl),
//               _buildField("Company Size", controller.sizeCtrl),
//               _buildField("Contact Email", controller.emailCtrl),
//               _buildField("LinkedIn URL", controller.linkedinCtrl),
//               _buildField("Industry", controller.industryCtrl),
//               _buildField("Location", controller.locationCtrl),
//               _buildField("Phone", controller.phoneCtrl),

//               _buildField(
//                 "Company Description",
//                 controller.descriptionCtrl,
//                 maxLines: 4,
//               ),

//               const SizedBox(height: 20),

//               /// BUTTONS
//               Obx(() => Row(
//                     children: [

//                       Expanded(
//                         child: ElevatedButton(

//                           onPressed: controller.isLoading.value
//                               ? null
//                               : () {
//                                   controller.saveProfile(isEdit: true);
//                                 },

//                           style: ElevatedButton.styleFrom(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 14),
//                           ),

//                           child: controller.isLoading.value
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )
//                               : const Text("Save Profile"),
//                         ),
//                       ),

//                       const SizedBox(width: 10),

//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             Get.back();
//                           },

//                           style: OutlinedButton.styleFrom(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 14),
//                           ),

//                           child: const Text("Cancel"),
//                         ),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// TEXT FIELD
//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),

//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,

//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: const Color(0xfff7f7f7),

//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';
// import 'ClientProfileController.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class CreateClientProfilePage extends StatelessWidget {

//   CreateClientProfilePage({super.key});

//   /// Use existing controller instance
//   final controller = Get.find<ClientProfileController>();

//   @override
//   Widget build(BuildContext context) {

//     print("==================================================");
//     print("🖥️ CreateClientProfilePage BUILD");
//     print("==================================================");

//     return Scaffold(
//       backgroundColor: const Color(0xfff5f5f7),

//       appBar: AppBar(
//         title: const Text("Create Client Profile"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Container(
//           padding: const EdgeInsets.all(16),

//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               )
//             ],
//           ),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               /// ==========================
//               /// PROFILE IMAGE SECTION
//               /// ==========================

//               Center(
//                 child: Column(
//                   children: [

//                     Obx(() {

//                       print("🖼️ LOGO UI REFRESH → ${controller.logoUrl.value}");

//                       if (controller.logoUrl.value.isEmpty) {
//                         return const CircleAvatar(
//                           radius: 45,
//                           child: Icon(Icons.business, size: 40),
//                         );
//                       }

//                       return CircleAvatar(
//                         radius: 45,
//                         backgroundImage:
//                             NetworkImage(controller.logoUrl.value),
//                       );
//                     }),

//                     const SizedBox(height: 8),

//                     Obx(() => ElevatedButton(

//                       onPressed: controller.isLogoUploading.value
//     ? null
//     : () async {

//         print("📤 Upload Photo Button Clicked");

//         _showImagePickerOptions(context);
//       },

//                           child: controller.isLogoUploading.value
//                               ? const SizedBox(
//                                   height: 18,
//                                   width: 18,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 2,
//                                   ),
//                                 )
//                               : const Text("Upload Photo"),
//                         ))
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 25),

//               /// ==========================
//               /// FORM FIELDS
//               /// ==========================

//               _buildField("Company Name", controller.companyNameCtrl),
//               _buildField("Company Website", controller.websiteCtrl),
//               _buildField("Company Size", controller.sizeCtrl),
//               _buildField("Contact Email", controller.emailCtrl),
//               _buildField("LinkedIn URL", controller.linkedinCtrl),
//               _buildField("Industry", controller.industryCtrl),
//               _buildField("Location", controller.locationCtrl),
//               _buildField("Phone", controller.phoneCtrl),

//               _buildField(
//                 "Company Description",
//                 controller.descriptionCtrl,
//                 maxLines: 4,
//               ),

//               const SizedBox(height: 20),

//               /// ==========================
//               /// BUTTONS SECTION
//               /// ==========================

//               Obx(() {

//                 print("🔄 Save Button Loading State → ${controller.isLoading.value}");

//                 return Row(
//                   children: [

//                     Expanded(
//                       child: ElevatedButton(

//                         onPressed: controller.isLoading.value
//                             ? null
//                             : () {

//                                 print("💾 SAVE PROFILE BUTTON CLICKED");

//                                 controller.saveProfile(isEdit:true);
//                               },

//                         style: ElevatedButton.styleFrom(
//                           padding:
//                               const EdgeInsets.symmetric(vertical: 14),
//                         ),

//                         child: controller.isLoading.value
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : const Text("Save Profile"),
//                       ),
//                     ),

//                     const SizedBox(width: 10),

//                     Expanded(
//                       child: OutlinedButton(

//                         onPressed: () {

//                           print("↩️ Cancel Button Clicked");

//                           Get.back();
//                         },

//                         style: OutlinedButton.styleFrom(
//                           padding:
//                               const EdgeInsets.symmetric(vertical: 14),
//                         ),

//                         child: const Text("Cancel"),
//                       ),
//                     ),
//                   ],
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
      

//     );
//   }
//   void _showImagePickerOptions(BuildContext context) {

//   print("📂 Opening Image Picker Options");

//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return SafeArea(
//         child: Wrap(
//           children: [

//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text("Camera"),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.camera);
//               },
//             ),

//             ListTile(
//               leading: const Icon(Icons.photo),
//               title: const Text("Gallery"),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
// Future<void> _pickImage(ImageSource source) async {

//   try {

//     print("📸 Picking Image from → $source");

//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile == null) {
//       print("❌ No image selected");
//       return;
//     }

//     print("✅ Image Selected → ${pickedFile.path}");

//     final file = File(pickedFile.path);

//     final res = await ClientProfileRepo.uploadLogo(file);

//     print("⬇️ Upload Response → $res");

//     if (res != null && res["success"] == true) {

//       final uploadedUrl = res["url"];

//       print("🌐 Uploaded URL → $uploadedUrl");

//       await controller.updateLogo(uploadedUrl);

//     } else {

//       print("❌ Upload Failed → ${res?["message"]}");
//     }

//   } catch (e) {

//     print("❌ Image Pick Error → $e");
//   }
// }
//   /// ==========================
//   /// TEXT FIELD BUILDER
//   /// ==========================

//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     int maxLines = 1,
//   }) {

//     print("📝 Building Field → $label");

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),

//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,

//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: const Color(0xfff7f7f7),

//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';
import 'ClientProfileController.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:freelancer_app/theme/AppColors.dart';

class CreateClientProfilePage extends StatelessWidget {
  CreateClientProfilePage({super.key});

  final controller = Get.find<ClientProfileController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Create Client Profile",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        bottomNavigationBar: _bottomButtons(),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            child: Column(
              children: [

                /// ================= PROFILE IMAGE =================
                _profileImageSection(),

                const SizedBox(height: 30),

                /// ================= FORM =================
                _buildField("Company Name", controller.companyNameCtrl),
                _buildField("Company Website", controller.websiteCtrl),
                _buildField("Company Size", controller.sizeCtrl),
                _buildField("Contact Email", controller.emailCtrl),
                _buildField("LinkedIn URL", controller.linkedinCtrl),
                _buildField("Industry", controller.industryCtrl),
                _buildField("Location", controller.locationCtrl),
                _buildField("Phone", controller.phoneCtrl),
                _buildField(
                  "Company Description",
                  controller.descriptionCtrl,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= PROFILE IMAGE =================

  Widget _profileImageSection() {
    return Center(
      child: Column(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: controller.logoUrl.value.isNotEmpty
                    ? NetworkImage(controller.logoUrl.value)
                    : null,
                child: controller.logoUrl.value.isEmpty
                    ? const Icon(Icons.business,
                        size: 50, color: Colors.grey)
                    : null,
              ),
            );
          }),
          const SizedBox(height: 15),
          Obx(() => ElevatedButton(
                onPressed: controller.isLogoUploading.value
                    ? null
                    : () => _showImagePickerOptions(Get.context!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryStart,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isLogoUploading.value
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Upload Logo",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
              ))
        ],
      ),
    );
  }

  /// ================= BOTTOM BUTTONS =================

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Obx(() {
        return Row(
          children: [

            /// Save Button
            Expanded(
              child: InkWell(
                onTap: controller.isLoading.value
                    ? null
                    : () => controller.saveProfile(isEdit: true),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white)
                      : const Text(
                          "Save Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// Cancel Button
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                      color: AppColors.primaryStart),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.primaryStart,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  /// ================= IMAGE PICKER =================

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt,
                  color: AppColors.primaryStart),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo,
                  color: AppColors.primaryStart),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: source);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final res =
        await ClientProfileRepo.uploadLogo(file);

    if (res != null && res["success"] == true) {
      final uploadedUrl = res["url"];
      await controller.updateLogo(uploadedUrl);
    }
  }

  /// ================= TEXT FIELD =================

  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding:
              const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 16),

          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(14),
            borderSide: BorderSide(
                color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(14),
            borderSide: BorderSide(
                color: AppColors.primaryStart,
                width: 1.6),
          ),
        ),
      ),
    );
  }
}