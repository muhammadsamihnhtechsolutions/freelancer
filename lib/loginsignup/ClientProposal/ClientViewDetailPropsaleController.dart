import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientViewDetailsProposalController extends GetxController {

  RxBool isLoading = false.obs;

  /// ==================================================
  /// ACCEPT PROPOSAL
  /// ==================================================
  Future<void> acceptProposal(String proposalId) async {

    print("--------------------------------------------------");
    print("🚀 ACCEPT PROPOSAL BUTTON CLICKED");
    print("➡️ PROPOSAL ID RECEIVED → $proposalId");
    print("--------------------------------------------------");

    if (proposalId.isEmpty) {

      print("❌ ERROR → PROPOSAL ID IS EMPTY");

      Get.snackbar("Error", "Invalid proposal ID");

      return;
    }

    try {

      print("⏳ CALLING ACCEPT PROPOSAL API...");

      isLoading.value = true;

      final res =
          await ClientViewDetailsProposalRepo.acceptProposal(proposalId);

      print("⬇️ ACCEPT API RESPONSE → $res");

      isLoading.value = false;

      if (res != null && res["success"] == true) {

        print("✅ PROPOSAL ACCEPTED SUCCESSFULLY");

        Get.snackbar("Success", "Proposal Accepted");

      } else {

        print("❌ ACCEPT FAILED → ${res["message"]}");

        Get.snackbar("Error", res["message"] ?? "Failed to accept proposal");

      }

    } catch (e) {

      isLoading.value = false;

      print("❌ ACCEPT ERROR → $e");

      Get.snackbar("Error", "Something went wrong");

    }

    print("--------------------------------------------------");
  }



  /// ==================================================
  /// REJECT PROPOSAL
  /// ==================================================
  Future<void> rejectProposal(String proposalId) async {

    print("--------------------------------------------------");
    print("🚀 REJECT PROPOSAL BUTTON CLICKED");
    print("➡️ PROPOSAL ID RECEIVED → $proposalId");
    print("--------------------------------------------------");

    if (proposalId.isEmpty) {

      print("❌ ERROR → PROPOSAL ID IS EMPTY");

      Get.snackbar("Error", "Invalid proposal ID");

      return;
    }

    try {

      print("⏳ CALLING REJECT PROPOSAL API...");

      isLoading.value = true;

      final res =
          await ClientViewDetailsProposalRepo.rejectProposal(proposalId);

      print("⬇️ REJECT API RESPONSE → $res");

      isLoading.value = false;

      if (res != null && res["success"] == true) {

        print("✅ PROPOSAL REJECTED SUCCESSFULLY");

        Get.snackbar("Success", "Proposal Rejected");

      } else {

        print("❌ REJECT FAILED → ${res["message"]}");

        Get.snackbar("Error", res["message"] ?? "Failed to reject proposal");

      }

    } catch (e) {

      isLoading.value = false;

      print("❌ REJECT ERROR → $e");

      Get.snackbar("Error", "Something went wrong");

    }

    print("--------------------------------------------------");
  }



  /// ==================================================
  /// APPROVE WORK
  /// ==================================================
  Future<void> approveWork(String jobId) async {

    print("--------------------------------------------------");
    print("🚀 APPROVE WORK BUTTON CLICKED");
    print("➡️ JOB ID RECEIVED → $jobId");
    print("--------------------------------------------------");

    if (jobId.isEmpty) {

      print("❌ ERROR → JOB ID IS EMPTY");

      Get.snackbar("Error", "Invalid job ID");

      return;
    }

    try {

      print("⏳ CALLING APPROVE WORK API...");

      isLoading.value = true;

      final res =
          await ClientViewDetailsProposalRepo.approveWork(jobId);

      print("⬇️ APPROVE WORK API RESPONSE → $res");

      isLoading.value = false;

      if (res != null && res["success"] == true) {

        print("✅ WORK APPROVED SUCCESSFULLY");

        Get.snackbar("Success", "Work Approved");

      } else {

        print("❌ APPROVE FAILED → ${res["message"]}");

        Get.snackbar("Error", res["message"] ?? "Failed to approve work");

      }

    } catch (e) {

      isLoading.value = false;

      print("❌ APPROVE ERROR → $e");

      Get.snackbar("Error", "Something went wrong");

    }

    print("--------------------------------------------------");
  }
}