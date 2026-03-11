// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class ClientViewDetailsProposalController extends GetxController {

//   RxBool isLoading = false.obs;

//   /// ==================================================
//   /// ACCEPT PROPOSAL
//   /// ==================================================
//   Future<void> acceptProposal(String proposalId) async {

//     print("--------------------------------------------------");
//     print("🚀 ACCEPT PROPOSAL BUTTON CLICKED");
//     print("➡️ PROPOSAL ID RECEIVED → $proposalId");
//     print("--------------------------------------------------");

//     if (proposalId.isEmpty) {

//       print("❌ ERROR → PROPOSAL ID IS EMPTY");

//       Get.snackbar("Error", "Invalid proposal ID");

//       return;
//     }

//     try {

//       print("⏳ CALLING ACCEPT PROPOSAL API...");

//       isLoading.value = true;

//       final res =
//           await ClientViewDetailsProposalRepo.acceptProposal(proposalId);

//       print("⬇️ ACCEPT API RESPONSE → $res");

//       isLoading.value = false;

//       if (res != null && res["success"] == true) {

//         print("✅ PROPOSAL ACCEPTED SUCCESSFULLY");

//         Get.snackbar("Success", "Proposal Accepted");

//       } else {

//         print("❌ ACCEPT FAILED → ${res["message"]}");

//         Get.snackbar("Error", res["message"] ?? "Failed to accept proposal");

//       }

//     } catch (e) {

//       isLoading.value = false;

//       print("❌ ACCEPT ERROR → $e");

//       Get.snackbar("Error", "Something went wrong");

//     }

//     print("--------------------------------------------------");
//   }



//   /// ==================================================
//   /// REJECT PROPOSAL
//   /// ==================================================
//   Future<void> rejectProposal(String proposalId) async {

//     print("--------------------------------------------------");
//     print("🚀 REJECT PROPOSAL BUTTON CLICKED");
//     print("➡️ PROPOSAL ID RECEIVED → $proposalId");
//     print("--------------------------------------------------");

//     if (proposalId.isEmpty) {

//       print("❌ ERROR → PROPOSAL ID IS EMPTY");

//       Get.snackbar("Error", "Invalid proposal ID");

//       return;
//     }

//     try {

//       print("⏳ CALLING REJECT PROPOSAL API...");

//       isLoading.value = true;

//       final res =
//           await ClientViewDetailsProposalRepo.rejectProposal(proposalId);

//       print("⬇️ REJECT API RESPONSE → $res");

//       isLoading.value = false;

//       if (res != null && res["success"] == true) {

//         print("✅ PROPOSAL REJECTED SUCCESSFULLY");

//         Get.snackbar("Success", "Proposal Rejected");

//       } else {

//         print("❌ REJECT FAILED → ${res["message"]}");

//         Get.snackbar("Error", res["message"] ?? "Failed to reject proposal");

//       }

//     } catch (e) {

//       isLoading.value = false;

//       print("❌ REJECT ERROR → $e");

//       Get.snackbar("Error", "Something went wrong");

//     }

//     print("--------------------------------------------------");
//   }



//   /// ==================================================
//   /// APPROVE WORK
//   /// ==================================================
//   Future<void> approveWork(String jobId) async {

//     print("--------------------------------------------------");
//     print("🚀 APPROVE WORK BUTTON CLICKED");
//     print("➡️ JOB ID RECEIVED → $jobId");
//     print("--------------------------------------------------");

//     if (jobId.isEmpty) {

//       print("❌ ERROR → JOB ID IS EMPTY");

//       Get.snackbar("Error", "Invalid job ID");

//       return;
//     }

//     try {

//       print("⏳ CALLING APPROVE WORK API...");

//       isLoading.value = true;

//       final res =
//           await ClientViewDetailsProposalRepo.approveWork(jobId);

//       print("⬇️ APPROVE WORK API RESPONSE → $res");

//       isLoading.value = false;

//       if (res != null && res["success"] == true) {

//         print("✅ WORK APPROVED SUCCESSFULLY");

//         Get.snackbar("Success", "Work Approved");

//       } else {

//         print("❌ APPROVE FAILED → ${res["message"]}");

//         Get.snackbar("Error", res["message"] ?? "Failed to approve work");

//       }

//     } catch (e) {

//       isLoading.value = false;

//       print("❌ APPROVE ERROR → $e");

//       Get.snackbar("Error", "Something went wrong");

//     }

//     print("--------------------------------------------------");
//   }
// }

import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientViewDetailsProposalController extends GetxController {

  RxBool isLoading = false.obs;

  /// 🔥 NEW STATES FOR APPROVE FLOW
  RxBool isApproving = false.obs;
  RxBool isApproved = false.obs;

  /// ==================================================
  /// ACCEPT PROPOSAL
  /// ==================================================
  Future<void> acceptProposal(String proposalId) async {

    print("--------------------------------------------------");
    print("🚀 ACCEPT PROPOSAL BUTTON CLICKED");
    print("➡️ PROPOSAL ID RECEIVED → $proposalId");
    print("--------------------------------------------------");

    if (proposalId.isEmpty) {
      Get.snackbar("Error", "Invalid proposal ID");
      return;
    }

    try {

      isLoading.value = true;

      final res =
          await ClientViewDetailsProposalRepo.acceptProposal(proposalId);

      isLoading.value = false;

      if (res != null && res["success"] == true) {

        Get.snackbar("Success", "Proposal Accepted");

      } else {

        Get.snackbar("Error", res?["message"] ?? "Failed to accept proposal");
      }

    } catch (e) {

      isLoading.value = false;

      Get.snackbar("Error", "Something went wrong");
    }
  }

  /// ==================================================
  /// REJECT PROPOSAL
  /// ==================================================
  Future<void> rejectProposal(String proposalId) async {

    if (proposalId.isEmpty) {
      Get.snackbar("Error", "Invalid proposal ID");
      return;
    }

    try {

      isLoading.value = true;

      final res =
          await ClientViewDetailsProposalRepo.rejectProposal(proposalId);

      isLoading.value = false;

      if (res != null && res["success"] == true) {

        Get.snackbar("Success", "Proposal Rejected");

      } else {

        Get.snackbar("Error", res?["message"] ?? "Failed to reject proposal");
      }

    } catch (e) {

      isLoading.value = false;

      Get.snackbar("Error", "Something went wrong");
    }
  }

  /// ==================================================
  /// APPROVE WORK (FINAL FLOW)
  /// ==================================================
  Future<void> approveWork(String proposalId) async {

  print("--------------------------------------------------");
  print("🚀 APPROVE WORK BUTTON CLICKED");
  print("➡️ PROPOSAL ID RECEIVED → $proposalId");
  print("--------------------------------------------------");

  if (proposalId.isEmpty) {
    Get.snackbar("Error", "Invalid proposal ID");
    return;
  }

  /// Already approved guard (extra safety)
  if (isApproved.value) {
    print("ℹ️ Already Approved - Skipping API Call");
    return;
  }

  try {

    isApproving.value = true;

    final res =
        await ClientViewDetailsProposalRepo.approveWork(proposalId);

    print("⬇️ APPROVE RESPONSE → $res");

    if (res is Map && res["success"] == true) {

      isApproved.value = true;

      print("✅ WORK APPROVED SUCCESSFULLY");

      Get.snackbar(
        "Success",
        res["message"] ?? "Work Approved Successfully",
      );

    } else {

      print("❌ APPROVE FAILED → ${res?["message"]}");

      Get.snackbar(
        "Error",
        res?["message"] ?? "Failed to approve work",
      );
    }

  } catch (e) {

    print("❌ APPROVE ERROR → $e");

    Get.snackbar("Error", "Something went wrong");

  } finally {

    isApproving.value = false;

  }

  print("--------------------------------------------------");
}
}