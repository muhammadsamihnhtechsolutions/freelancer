// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class StartWorkController extends GetxController {

//   /// --------------------------
//   /// LOADING STATE
//   /// --------------------------
//   RxBool isStarting = false.obs;

//   /// --------------------------
//   /// START WORK FUNCTION
//   /// --------------------------
//   Future<void> startWork(String jobId) async {

//     try {

//       isStarting.value = true;

//       print("--------------------------------------------------");
//       print("🚀 START WORK CONTROLLER CALLED");
//       print("🆔 Job ID → $jobId");
//       print("--------------------------------------------------");

//       final response = await ProposalRepo.startWork(jobId);

//       print("✅ START WORK SUCCESS");
//       print("📦 Response → $response");

//       Get.snackbar(
//         "Success",
//         "Work started successfully",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       /// 🔁 OPTIONAL: Agar proposals refresh karna ho
//       /// final proposalController = Get.find<ProposalController>();
//       /// await proposalController.fetchMyProposals();

//     } catch (e) {

//       print("--------------------------------------------------");
//       print("❌ START WORK FAILED");
//       print("⚠ Error → $e");
//       print("--------------------------------------------------");

//       Get.snackbar(
//         "Error",
//         "Failed to start work",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//     } finally {

//       isStarting.value = false;
//     }
//   }
// }

// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class StartWorkController extends GetxController {
//   /// --------------------------
//   /// LOADING STATE
//   /// --------------------------
//   RxBool isStarting = false.obs;

//   /// --------------------------
//   /// START WORK FUNCTION
//   /// --------------------------
//   Future<bool> startWork(String jobId) async {
//     try {
//       isStarting.value = true;

//       print("--------------------------------------------------");
//       print("🚀 START WORK CONTROLLER CALLED");
//       print("🆔 Job ID → $jobId");
//       print("--------------------------------------------------");

//       final response = await ProposalRepo.startWork(jobId);

//       print("✅ START WORK SUCCESS");
//       print("📦 Response → $response");

//       Get.snackbar(
//         "Success",
//         "Work started successfully",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return true;
//     } catch (e) {
//       print("--------------------------------------------------");
//       print("❌ START WORK FAILED");
//       print("⚠ Error → $e");
//       print("--------------------------------------------------");

//       Get.snackbar(
//         "Error",
//         "Failed to start work",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     } finally {
//       isStarting.value = false;
//     }
//   }
// }
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class StartWorkController extends GetxController {
  /// --------------------------
  /// LOADING STATES
  /// --------------------------
  RxBool isStarting = false.obs;
  RxBool isSubmitting = false.obs;

  /// --------------------------
  /// START WORK FUNCTION
  /// --------------------------
  Future<bool> startWork(String jobId) async {
    try {
      isStarting.value = true;

      print("--------------------------------------------------");
      print("🚀 START WORK CONTROLLER CALLED");
      print("🆔 Job ID → $jobId");
      print("--------------------------------------------------");

      final response = await ProposalRepo.startWork(jobId);

      print("✅ START WORK SUCCESS");
      print("📦 Response → $response");

      Get.snackbar(
        "Success",
        "Work started successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      print("--------------------------------------------------");
      print("❌ START WORK FAILED");
      print("⚠ Error → $e");
      print("--------------------------------------------------");

      Get.snackbar(
        "Error",
        "Failed to start work",
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isStarting.value = false;
    }
  }

  /// --------------------------
  /// SUBMIT WORK FUNCTION
  /// --------------------------
  Future<bool> submitWork(String jobId) async {
    try {
      isSubmitting.value = true;

      print("--------------------------------------------------");
      print("📤 SUBMIT WORK CONTROLLER CALLED");
      print("🆔 Job ID → $jobId");
      print("--------------------------------------------------");

      final response = await ProposalRepo.submitWork(jobId);

      print("✅ SUBMIT WORK SUCCESS");
      print("📦 Response → $response");

      Get.snackbar(
        "Success",
        "Work submitted successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      print("--------------------------------------------------");
      print("❌ SUBMIT WORK FAILED");
      print("⚠ Error → $e");
      print("--------------------------------------------------");

      Get.snackbar(
        "Error",
        "Failed to submit work",
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}