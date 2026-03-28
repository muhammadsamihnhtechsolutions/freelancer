

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/service/Repo.dart';

// class SubmitProposalController extends GetxController {

//   /// -------------------------------
//   /// LOADING STATE
//   /// -------------------------------
//   RxBool loading = false.obs;

//   /// Optional CV file (if needed later)
//   File? cvFile;

//   /// -------------------------------
//   /// SUBMIT PROPOSAL FUNCTION
//   /// -------------------------------
//   Future<void> submitProposal({
//     required String jobId,
//     required String coverLetter,
//     required String bid,
//     required String deliveryDays,
//   }) async {

//     try {

//       print("=================================");
//       print("🚀 SUBMIT PROPOSAL CONTROLLER");
//       print("📌 JOB ID → $jobId");
//       print("💰 BID → $bid");
//       print("📦 DELIVERY DAYS → $deliveryDays");
//       print("=================================");

//       loading.value = true;

//       /// Request Body
//       final body = {
//         "job_id": jobId,
//         "cover_letter": coverLetter,
//         "bid_amount": bid,
//         "delivery_days": deliveryDays,
//       };

//       print("📤 REQUEST BODY → $body");

//       /// API CALL
//       final res = await SubmitProposalRepo.submitProposal(body);

//       print("⬇️ API RESPONSE → $res");

//       /// Safe success check
//       if (res != null && res["success"] == true) {

//         print("✅ PROPOSAL SUBMITTED SUCCESSFULLY");

//         Get.snackbar(
//           "Success",
//           res["message"] ?? "Proposal submitted successfully",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.withOpacity(.1),
//           colorText: Colors.green,
//         );

//         /// Go back to previous screen
//         Get.back();

//       } else {

//         print("❌ PROPOSAL FAILED → ${res?["message"]}");

//         Get.snackbar(
//           "Error",
//           res?["message"] ?? "Proposal submission failed",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(.1),
//           colorText: Colors.red,
//         );
//       }

//     } catch (e) {

//       print("❌ CONTROLLER ERROR → $e");

//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(.1),
//         colorText: Colors.red,
//       );

//     } finally {

//       loading.value = false;

//       print("=================================");
//     }
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:freelancer_app/service/Repo.dart';

// class SubmitProposalController extends GetxController {
//   /// -------------------------------
//   /// LOADING STATE
//   /// -------------------------------
//   RxBool loading = false.obs;

//   /// -------------------------------
//   /// SUBMIT PROPOSAL FUNCTION
//   /// -------------------------------
//   Future<void> submitProposal({
//     required String jobId,
//     required String coverLetter,
//     required String bid,
//     required String deliveryDays,
//     required File cvFile,
//   }) async {
//     try {
//       print("==================================================");
//       print("🚀 SUBMIT PROPOSAL CONTROLLER CALLED");
//       print("📌 JOB ID           → $jobId");
//       print("📝 COVER LETTER     → $coverLetter");
//       print("💰 BID              → $bid");
//       print("📦 DELIVERY DAYS    → $deliveryDays");
//       print("📄 CV FILE NAME     → ${cvFile.path.split('/').last}");
//       print("📁 CV FILE PATH     → ${cvFile.path}");
//       print("==================================================");

//       loading.value = true;

//       /// Request body
//       final body = {
//         "job_id": jobId,
//         "cover_letter": coverLetter,
//         "bid_amount": bid,
//         "delivery_days": deliveryDays,
//       };

//       print("📤 REQUEST BODY PREPARED");
//       print("➡️ BODY → $body");
//       print("➡️ CV   → ${cvFile.path}");

//       /// API CALL
//       final res = await SubmitProposalRepo.submitProposal(
//         body: body,
//         cvFile: cvFile,
//       );

//       print("⬇️ API RESPONSE RECEIVED");
//       print("➡️ RESPONSE → $res");

//       /// Safe success check
//       if (res != null && res["success"] == true) {
//         print("✅ PROPOSAL SUBMITTED SUCCESSFULLY");
//         print("💬 MESSAGE → ${res["message"]}");

//         Get.snackbar(
//           "Success",
//           res["message"] ?? "Proposal submitted successfully",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.withOpacity(.1),
//           colorText: Colors.green,
//         );

//         Get.back();
//       } else {
//         print("❌ PROPOSAL SUBMISSION FAILED");
//         print("💬 ERROR MESSAGE → ${res?["message"]}");

//         Get.snackbar(
//           "Error",
//           res?["message"] ?? "Proposal submission failed",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(.1),
//           colorText: Colors.red,
//         );
//       }
//     } catch (e) {
//       print("❌ CONTROLLER EXCEPTION OCCURRED");
//       print("⚠️ ERROR → $e");

//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.withOpacity(.1),
//         colorText: Colors.red,
//       );
//     } finally {
//       loading.value = false;

//       print("🔁 LOADING RESET → ${loading.value}");
//       print("==================================================");
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/service/Repo.dart';

class SubmitProposalController extends GetxController {
  RxBool loading = false.obs;

  Future<void> submitProposal({
    required String jobId,
    required String coverLetter,
    required String bid,
    required String deliveryDays,
    File? cvFile,
  }) async {
    try {
      print("==================================================");
      print("🚀 SUBMIT PROPOSAL CONTROLLER CALLED");
      print("📌 JOB ID           → $jobId");
      print("📝 COVER LETTER     → $coverLetter");
      print("💰 BID              → $bid");
      print("📦 DELIVERY DAYS    → $deliveryDays");
      print("📄 CV FILE NAME     → ${cvFile?.path.split('/').last ?? "No CV"}");
      print("📁 CV FILE PATH     → ${cvFile?.path ?? "No CV"}");
      print("==================================================");

      loading.value = true;

      final body = {
        "job_id": jobId,
        "cover_letter": coverLetter,
        "price": bid,
        "delivery_days": deliveryDays,
      };

      print("📤 REQUEST BODY PREPARED");
      print("➡️ BODY → $body");
      print("➡️ CV   → ${cvFile?.path ?? "No CV"}");

      final res = await SubmitProposalRepo.submitProposal(
        body: body,
        cvFile: cvFile,
      );

      print("⬇️ API RESPONSE RECEIVED");
      print("➡️ RESPONSE → $res");

      if (res != null && res["success"] == true) {
        print("✅ PROPOSAL SUBMITTED SUCCESSFULLY");
        print("💬 MESSAGE → ${res["message"]}");

        Get.snackbar(
          "Success",
          res["message"] ?? "Proposal submitted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(.1),
          colorText: Colors.green,
        );

        Get.back();
      } else {
        final message = res?["message"] ?? "Proposal submission failed";

        print("❌ PROPOSAL SUBMISSION FAILED");
        print("💬 ERROR MESSAGE → $message");

        Get.snackbar(
          "Error",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      final errorMessage = e.toString();

      print("❌ CONTROLLER EXCEPTION OCCURRED");
      print("! ERROR → $errorMessage");

      Get.snackbar(
        "Error",
        errorMessage.replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(.1),
        colorText: Colors.red,
      );
    } finally {
      loading.value = false;

      print("🔁 LOADING RESET → ${loading.value}");
      print("==================================================");
    }
  }
}