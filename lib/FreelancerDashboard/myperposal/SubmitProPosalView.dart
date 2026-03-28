
// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/SubmitProposalController.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class SubmitProposalView extends StatefulWidget {
//   final String jobId;

//   const SubmitProposalView({
//     super.key,
//     required this.jobId,
//   });

//   @override
//   State<SubmitProposalView> createState() => _SubmitProposalViewState();
// }

// class _SubmitProposalViewState extends State<SubmitProposalView> {

//   final coverCtrl = TextEditingController();
//   final bidCtrl = TextEditingController();
//   final deliveryCtrl = TextEditingController();

//   final controller = Get.put(SubmitProposalController());

//   @override
//   void initState() {
//     super.initState();

//     print("------------------------------------------------");
//     print("📨 SUBMIT PROPOSAL SCREEN OPENED");
//     print("📌 JOB ID RECEIVED IN VIEW → ${widget.jobId}");
//     print("------------------------------------------------");
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),

//       appBar: AppBar(
//         title: const Text("Submit Proposal"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             const Center(
//               child: Text(
//                 "Submit Your Proposal",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 4),

//             const Center(
//               child: Text(
//                 "Make a strong first impression with a clear proposal.",
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// COVER LETTER
//             const Text(
//               "Cover Letter",
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),

//             const SizedBox(height: 6),

//             TextField(
//               controller: coverCtrl,
//               maxLines: 6,
//               decoration: InputDecoration(
//                 hintText: "Explain why you're the perfect fit for this job.",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// CV UPLOAD BOX
//             const Text(
//               "Upload CV (PDF)",
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),

//             const SizedBox(height: 8),

//             Container(
//               height: 120,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: const Center(
//                 child: Text(
//                   "Tap to upload your CV",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// BID + DELIVERY
//             Row(
//               children: [

//                 Expanded(
//                   child: TextField(
//                     controller: bidCtrl,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Your Bid (£)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: TextField(
//                     controller: deliveryCtrl,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Delivery Time (Days)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 26),

//             /// SUBMIT BUTTON
//             Obx(() => SizedBox(
//               width: double.infinity,

//               child: ElevatedButton(

//                 onPressed: controller.loading.value
//                     ? null
//                     : () {

//                         print("📤 SUBMIT PROPOSAL CLICKED");
//                         print("📌 JOB ID FROM VIEW → ${widget.jobId}");

//                         if (widget.jobId.isEmpty) {

//                           print("❌ JOB ID EMPTY IN VIEW");

//                           Get.snackbar(
//                             "Error",
//                             "Job ID missing",
//                           );

//                           return;
//                         }

//                         if (coverCtrl.text.isEmpty ||
//                             bidCtrl.text.isEmpty ||
//                             deliveryCtrl.text.isEmpty) {

//                           print("❌ VALIDATION FAILED");

//                           Get.snackbar(
//                             "Error",
//                             "Please fill all fields",
//                           );

//                           return;
//                         }

//                         controller.submitProposal(
//                           jobId: widget.jobId,
//                           coverLetter: coverCtrl.text,
//                           bid: bidCtrl.text,
//                           deliveryDays: deliveryCtrl.text,
//                         );
//                       },

//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryStart,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),

//                 child: controller.loading.value
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                         "Submit Proposal",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//               ),
//             )),

//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/SubmitProposalController.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class SubmitProposalView extends StatefulWidget {
//   final String jobId;

//   const SubmitProposalView({
//     super.key,
//     required this.jobId,
//   });

//   @override
//   State<SubmitProposalView> createState() => _SubmitProposalViewState();
// }

// class _SubmitProposalViewState extends State<SubmitProposalView> {
//   final coverCtrl = TextEditingController();
//   final bidCtrl = TextEditingController();
//   final deliveryCtrl = TextEditingController();

//   final controller = Get.put(SubmitProposalController());

//   File? selectedCvFile;
//   String? selectedCvName;

//   @override
//   void initState() {
//     super.initState();

//     print("------------------------------------------------");
//     print("📨 SUBMIT PROPOSAL SCREEN OPENED");
//     print("📌 JOB ID RECEIVED IN VIEW → ${widget.jobId}");
//     print("------------------------------------------------");
//   }

//   Future<void> pickCv() async {
//     try {
//       print("📂 OPENING FILE PICKER FOR CV");

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx'],
//       );

//       if (result != null && result.files.single.path != null) {
//         setState(() {
//           selectedCvFile = File(result.files.single.path!);
//           selectedCvName = result.files.single.name;
//         });

//         print("✅ CV SELECTED → $selectedCvName");
//         print("📁 CV PATH → ${selectedCvFile!.path}");
//       } else {
//         print("⚠️ CV PICK CANCELLED");
//       }
//     } catch (e) {
//       print("❌ CV PICK ERROR → $e");
//       Get.snackbar("Error", "Failed to pick CV");
//     }
//   }

//   @override
//   void dispose() {
//     coverCtrl.dispose();
//     bidCtrl.dispose();
//     deliveryCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         title: const Text("Submit Proposal"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text(
//                 "Submit Your Proposal",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Center(
//               child: Text(
//                 "Make a strong first impression with a clear proposal.",
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ),
//             const SizedBox(height: 20),

//             const Text(
//               "Cover Letter",
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 6),
//             TextField(
//               controller: coverCtrl,
//               maxLines: 6,
//               decoration: InputDecoration(
//                 hintText: "Explain why you're the perfect fit for this job.",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             const Text(
//               "Upload CV",
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),

//             InkWell(
//               onTap: pickCv,
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: selectedCvFile != null
//                         ? AppColors.primaryStart
//                         : Colors.grey.shade300,
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 54,
//                       width: 54,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryStart.withOpacity(.10),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.cloud_upload_rounded,
//                         size: 28,
//                         color: AppColors.primaryStart,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       selectedCvName ?? "Tap to upload your CV",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: selectedCvName != null
//                             ? Colors.black
//                             : Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       selectedCvName != null
//                           ? "File selected successfully"
//                           : "PDF, DOC, or DOCX",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: selectedCvName != null
//                             ? Colors.green
//                             : Colors.black54,
//                       ),
//                     ),
//                     if (selectedCvName != null) ...[
//                       const SizedBox(height: 12),
//                       TextButton.icon(
//                         onPressed: pickCv,
//                         icon: const Icon(Icons.edit_outlined, size: 18),
//                         label: const Text("Change File"),
//                       ),
//                     ]
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: bidCtrl,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Your Bid (£)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextField(
//                     controller: deliveryCtrl,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Delivery Time (Days)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 26),

//             Obx(
//               () => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.loading.value
//                       ? null
//                       : () {
//                           print("📤 SUBMIT PROPOSAL CLICKED");
//                           print("📌 JOB ID FROM VIEW → ${widget.jobId}");

//                           if (widget.jobId.isEmpty) {
//                             Get.snackbar("Error", "Job ID missing");
//                             return;
//                           }

//                           if (coverCtrl.text.trim().isEmpty ||
//                               bidCtrl.text.trim().isEmpty ||
//                               deliveryCtrl.text.trim().isEmpty) {
//                             Get.snackbar("Error", "Please fill all fields");
//                             return;
//                           }

//                           if (selectedCvFile == null) {
//                             Get.snackbar("Error", "Please upload your CV");
//                             return;
//                           }

//                           controller.submitProposal(
//                             jobId: widget.jobId,
//                             coverLetter: coverCtrl.text.trim(),
//                             bid: bidCtrl.text.trim(),
//                             deliveryDays: deliveryCtrl.text.trim(),
//                             cvFile: selectedCvFile!,
//                           );
//                         },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryStart,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: controller.loading.value
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           "Submit Proposal",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/SubmitProposalController.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class SubmitProposalView extends StatefulWidget {
//   final String jobId;
//   final bool alreadySubmitted; // 👈 NEW

//   const SubmitProposalView({
//     super.key,
//     required this.jobId,
//     this.alreadySubmitted = false, // 👈 default false
//   });

//   @override
//   State<SubmitProposalView> createState() => _SubmitProposalViewState();
// }

// class _SubmitProposalViewState extends State<SubmitProposalView> {
//   final coverCtrl = TextEditingController();
//   final bidCtrl = TextEditingController();
//   final deliveryCtrl = TextEditingController();

//   final controller = Get.put(SubmitProposalController());

//   File? selectedCvFile;
//   String? selectedCvName;

//   @override
//   void initState() {
//     super.initState();

//     print("------------------------------------------------");
//     print("📨 SUBMIT PROPOSAL SCREEN OPENED");
//     print("📌 JOB ID RECEIVED IN VIEW → ${widget.jobId}");
//     print("📌 ALREADY SUBMITTED → ${widget.alreadySubmitted}");
//     print("------------------------------------------------");
//   }

//   Future<void> pickCv() async {
//     try {
//       if (widget.alreadySubmitted) return; // 👈 disable picker

//       print("📂 OPENING FILE PICKER FOR CV");

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx'],
//       );

//       if (result != null && result.files.single.path != null) {
//         setState(() {
//           selectedCvFile = File(result.files.single.path!);
//           selectedCvName = result.files.single.name;
//         });

//         print("✅ CV SELECTED → $selectedCvName");
//       } else {
//         print("⚠️ CV PICK CANCELLED");
//       }
//     } catch (e) {
//       print("❌ CV PICK ERROR → $e");
//       Get.snackbar("Error", "Failed to pick CV");
//     }
//   }

//   @override
//   void dispose() {
//     coverCtrl.dispose();
//     bidCtrl.dispose();
//     deliveryCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDisabled = widget.alreadySubmitted;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         title: const Text("Submit Proposal"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             const Center(
//               child: Text(
//                 "Submit Your Proposal",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 4),

//             const Center(
//               child: Text(
//                 "Make a strong first impression with a clear proposal.",
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// COVER LETTER
//             const Text("Cover Letter", style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(height: 6),
//             TextField(
//               controller: coverCtrl,
//               maxLines: 6,
//               enabled: !isDisabled, // 👈 disable
//               decoration: InputDecoration(
//                 hintText: "Explain why you're the perfect fit for this job.",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// CV
//             const Text("Upload CV", style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),

//             InkWell(
//               onTap: isDisabled ? null : pickCv,
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   children: [
//                     const Icon(Icons.cloud_upload_rounded, size: 28),
//                     const SizedBox(height: 8),
//                     Text(
//                       selectedCvName ?? "Tap to upload your CV",
//                       style: const TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// BID + DELIVERY
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: bidCtrl,
//                     enabled: !isDisabled,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Your Bid (£)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: TextField(
//                     controller: deliveryCtrl,
//                     enabled: !isDisabled,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: "Delivery Time (Days)",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 26),

//             /// BUTTON
//             Obx(() => SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: (controller.loading.value || isDisabled)
//                     ? null
//                     : () {

//                         if (widget.jobId.isEmpty) {
//                           Get.snackbar("Error", "Job ID missing");
//                           return;
//                         }

//                         if (coverCtrl.text.trim().isEmpty ||
//                             bidCtrl.text.trim().isEmpty ||
//                             deliveryCtrl.text.trim().isEmpty) {

//                           Get.snackbar("Error", "Please fill all fields");
//                           return;
//                         }

//                         if (selectedCvFile == null) {
//                           Get.snackbar("Error", "Please upload your CV");
//                           return;
//                         }

//                         controller.submitProposal(
//                           jobId: widget.jobId,
//                           coverLetter: coverCtrl.text.trim(),
//                           bid: bidCtrl.text.trim(),
//                           deliveryDays: deliveryCtrl.text.trim(),
//                           cvFile: selectedCvFile!,
//                         );
//                       },

//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isDisabled
//                       ? Colors.grey // 👈 disabled color
//                       : AppColors.primaryStart,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),

//                 child: controller.loading.value
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                         isDisabled
//                             ? "Already Submitted" // 👈 TEXT CHANGE
//                             : "Submit Proposal",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//               ),
//             )),

//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/SubmitProposalController.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class SubmitProposalView extends StatefulWidget {
  final String jobId;
  final bool alreadySubmitted;

  const SubmitProposalView({
    super.key,
    required this.jobId,
    this.alreadySubmitted = false,
  });

  @override
  State<SubmitProposalView> createState() => _SubmitProposalViewState();
}

class _SubmitProposalViewState extends State<SubmitProposalView> {
  final coverCtrl = TextEditingController();
  final bidCtrl = TextEditingController();
  final deliveryCtrl = TextEditingController();

  late final SubmitProposalController controller;

  File? selectedCvFile;
  String? selectedCvName;

  late bool _isAlreadySubmitted;

  @override
  void initState() {
    super.initState();

    _isAlreadySubmitted = widget.alreadySubmitted;

    controller = Get.isRegistered<SubmitProposalController>(tag: widget.jobId)
        ? Get.find<SubmitProposalController>(tag: widget.jobId)
        : Get.put(SubmitProposalController(), tag: widget.jobId);

    print("------------------------------------------------");
    print("📨 SUBMIT PROPOSAL SCREEN OPENED");
    print("📌 JOB ID RECEIVED IN VIEW → ${widget.jobId}");
    print("📌 ALREADY SUBMITTED (INITIAL) → ${widget.alreadySubmitted}");
    print("📌 LOCAL SUBMIT STATE → $_isAlreadySubmitted");
    print("------------------------------------------------");
  }

  Future<void> pickCv() async {
    try {
      if (_isAlreadySubmitted) return;

      print("📂 OPENING FILE PICKER FOR CV");

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedCvFile = File(result.files.single.path!);
          selectedCvName = result.files.single.name;
        });

        print("✅ CV SELECTED → $selectedCvName");
      } else {
        print("⚠️ CV PICK CANCELLED");
      }
    } catch (e) {
      print("❌ CV PICK ERROR → $e");
      Get.snackbar("Error", "Failed to pick CV");
    }
  }

  Future<void> _submitProposal() async {
    if (_isAlreadySubmitted) return;

    if (widget.jobId.isEmpty) {
      Get.snackbar("Error", "Job ID missing");
      return;
    }

    if (coverCtrl.text.trim().isEmpty ||
        bidCtrl.text.trim().isEmpty ||
        deliveryCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (selectedCvFile == null) {
      Get.snackbar("Error", "Please upload your CV");
      return;
    }

    try {
      await controller.submitProposal(
        jobId: widget.jobId,
        coverLetter: coverCtrl.text.trim(),
        bid: bidCtrl.text.trim(),
        deliveryDays: deliveryCtrl.text.trim(),
        cvFile: selectedCvFile!,
      );

      if (mounted) {
        setState(() {
          _isAlreadySubmitted = true;
        });
      }

      print("✅ PROPOSAL SUBMITTED FOR JOB → ${widget.jobId}");
      print("🔒 BUTTON DISABLED ONLY FOR THIS JOB");
    } catch (e) {
      print("❌ SUBMIT ERROR IN VIEW → $e");
    }
  }

  @override
  void dispose() {
    coverCtrl.dispose();
    bidCtrl.dispose();
    deliveryCtrl.dispose();

    if (Get.isRegistered<SubmitProposalController>(tag: widget.jobId)) {
      Get.delete<SubmitProposalController>(tag: widget.jobId);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = _isAlreadySubmitted;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Submit Proposal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Submit Your Proposal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                "Make a strong first impression with a clear proposal.",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),

            /// COVER LETTER
            const Text(
              "Cover Letter",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: coverCtrl,
              maxLines: 6,
              enabled: !isDisabled,
              decoration: InputDecoration(
                hintText: "Explain why you're the perfect fit for this job.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CV
            const Text(
              "Upload CV",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: isDisabled ? null : pickCv,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  color: isDisabled ? Colors.grey.shade100 : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_rounded,
                      size: 28,
                      color: isDisabled ? Colors.grey : Colors.black,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedCvName ??
                          (isDisabled
                              ? "Proposal already submitted for this job"
                              : "Tap to upload your CV"),
                      style: TextStyle(
                        color: isDisabled ? Colors.grey : Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// BID + DELIVERY
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: bidCtrl,
                    enabled: !isDisabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Your Bid (£)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: deliveryCtrl,
                    enabled: !isDisabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Delivery Time (Days)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            /// BUTTON
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (controller.loading.value || isDisabled)
                      ? null
                      : _submitProposal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDisabled ? Colors.grey : AppColors.primaryStart,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.loading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isDisabled
                              ? "Already Submitted"
                              : "Submit Proposal",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}