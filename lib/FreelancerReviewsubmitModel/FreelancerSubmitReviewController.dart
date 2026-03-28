// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerReviewsubmitModel/FreelancerSubmitReviewModel.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';


// class FreelancerSubmitReviewController extends GetxController {
//   final TextEditingController reviewCtrl = TextEditingController();

//   RxInt selectedRating = 0.obs;
//   RxBool isSubmittingReview = false.obs;
//   RxBool hasSubmittedReview = false.obs;

//   Rxn<FreelancerSubmitReviewModel> submittedReview =
//       Rxn<FreelancerSubmitReviewModel>();

//   void setRating(int rating) {
//     print("⭐ RATING SELECTED → $rating");
//     selectedRating.value = rating;
//   }

//   void clearForm() {
//     print("🧹 CLEARING REVIEW FORM");
//     reviewCtrl.clear();
//     selectedRating.value = 0;
//   }

//   Future<bool> submitReview({
//     required String jobId,
//   }) async {
//     final reviewText = reviewCtrl.text.trim();
//     final rating = selectedRating.value;

//     print("--------------------------------------------------");
//     print("🟣 CONTROLLER: SUBMIT REVIEW START");
//     print("➡️ jobId → $jobId");
//     print("➡️ rating → $rating");
//     print("➡️ reviewText → $reviewText");
//     print("--------------------------------------------------");

//     if (rating <= 0) {
//       print("⚠️ VALIDATION FAILED → RATING EMPTY");
//       Get.snackbar(
//         "Rating Required",
//         "Please select a rating",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }

//     if (reviewText.isEmpty) {
//       print("⚠️ VALIDATION FAILED → REVIEW TEXT EMPTY");
//       Get.snackbar(
//         "Review Required",
//         "Please write a review",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }

//     try {
//       isSubmittingReview.value = true;

//       print("🔁 API CALL STARTED...");

//       final res = await FreelancerSubmitReviewRepo.submitReview(
//         jobId: jobId,
//         rating: rating,
//         review: reviewText,
//       );

//       print("📥 CONTROLLER RECEIVED RESPONSE → $res");

//       if (res["review"] != null) {
//         print("✅ REVIEW MODEL PARSED SUCCESSFULLY");
//         submittedReview.value = res["review"];
//         hasSubmittedReview.value = true;
//       }

//       Get.snackbar(
//         "Success",
//         res["message"] ?? "Review submitted successfully",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       print("🎉 REVIEW SUBMITTED SUCCESSFULLY");
//       return true;
//     } catch (e) {
//       print("❌ SUBMIT REVIEW CONTROLLER ERROR → $e");

//       Get.snackbar(
//         "Error",
//         e.toString().replaceAll("Exception: ", ""),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     } finally {
//       isSubmittingReview.value = false;
//       print("🔁 LOADING STATE RESET → isSubmittingReview = false");
//       print("--------------------------------------------------");
//     }
//   }

//   @override
//   void onClose() {
//     print("🧹 CONTROLLER DISPOSED");
//     reviewCtrl.dispose();
//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerReviewsubmitModel/FreelancerSubmitReviewModel.dart';

class FreelancerSubmitReviewController extends GetxController {
  final TextEditingController reviewCtrl = TextEditingController();

  RxBool isSubmittingReview = false.obs;
  RxBool isLoadingSubmittedReview = false.obs;
  RxBool hasSubmittedReview = false.obs;

  RxInt selectedRating = 0.obs;

  Rxn<FreelancerSubmitReviewModel> submittedReview =
      Rxn<FreelancerSubmitReviewModel>();

  void setRating(int value) {
    if (hasSubmittedReview.value) return;
    selectedRating.value = value;
    print("⭐ RATING SET => $value");
  }

  void clearForm() {
    reviewCtrl.clear();
    selectedRating.value = 0;
    hasSubmittedReview.value = false;
    submittedReview.value = null;
    print("🧹 REVIEW FORM CLEARED");
  }

  Future<void> loadSubmittedReview({
    required String jobId,
  }) async {
    print("==================================================");
    print("🚀 LOAD SUBMITTED REVIEW CALLED");
    print("➡️ JOB ID => $jobId");
    print("==================================================");

    if (jobId.trim().isEmpty) return;

    try {
      isLoadingSubmittedReview.value = true;

      final res = await FreelancerSubmitReviewRepo.getReviews(jobId: jobId);

      print("⬇️ LOAD SUBMITTED REVIEW RESPONSE => $res");

      final reviews = res["reviews"];

      if (reviews is List && reviews.isNotEmpty) {
        final first = FreelancerSubmitReviewModel.fromJson(
          Map<String, dynamic>.from(reviews.first),
        );

        submittedReview.value = first;
        hasSubmittedReview.value = true;
        selectedRating.value = first.rating;
        reviewCtrl.text = first.review;

        print("✅ EXISTING REVIEW FOUND");
        print("➡️ REVIEW ID => ${first.id}");
      } else {
        hasSubmittedReview.value = false;
        submittedReview.value = null;
        print("ℹ️ NO EXISTING REVIEW FOUND");
      }
    } catch (e) {
      print("❌ LOAD SUBMITTED REVIEW ERROR => $e");
    } finally {
      isLoadingSubmittedReview.value = false;
      print("==================================================");
    }
  }

  Future<bool> submitReview({
    required String jobId,
  }) async {
    print("==================================================");
    print("🚀 SUBMIT REVIEW CALLED");
    print("➡️ JOB ID => $jobId");
    print("➡️ SELECTED RATING => ${selectedRating.value}");
    print("➡️ REVIEW TEXT => ${reviewCtrl.text.trim()}");
    print("==================================================");

    if (hasSubmittedReview.value) {
      Get.snackbar("Info", "Review already submitted");
      print("ℹ️ BLOCKED => REVIEW ALREADY SUBMITTED");
      return false;
    }

    if (jobId.trim().isEmpty) {
      Get.snackbar("Error", "Invalid job ID");
      return false;
    }

    if (selectedRating.value <= 0) {
      Get.snackbar("Error", "Please select rating");
      return false;
    }

    if (reviewCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "Please write review");
      return false;
    }

    try {
      isSubmittingReview.value = true;

      final res = await FreelancerSubmitReviewRepo.submitReview(
        jobId: jobId,
        rating: selectedRating.value,
        review: reviewCtrl.text.trim(),
      );

      print("⬇️ RAW SUBMIT REVIEW RESPONSE => $res");

      final bool success =
          res != null &&
          (res["success"] == true ||
              res["review"] != null ||
              (res["message"]?.toString().toLowerCase().contains("success") ??
                  false));

      if (success) {
        final reviewJson = res["review"];

        if (reviewJson != null) {
          final parsed = FreelancerSubmitReviewModel.fromJson(
            Map<String, dynamic>.from(reviewJson),
          );

          submittedReview.value = parsed;
          selectedRating.value = parsed.rating;
          reviewCtrl.text = parsed.review;
        }

        hasSubmittedReview.value = true;

        Get.snackbar(
          "Success",
          res["message"] ?? "Review submitted successfully",
        );

        print("✅ REVIEW SUBMITTED SUCCESSFULLY");
        print("➡️ hasSubmittedReview => ${hasSubmittedReview.value}");

        return true;
      } else {
        final message = res?["message"] ?? "Failed to submit review";

        if (message.toString().toLowerCase().contains("already")) {
          hasSubmittedReview.value = true;
        }

        Get.snackbar("Error", message);
        print("❌ SUBMIT REVIEW FAILED => $message");
        return false;
      }
    } catch (e) {
      print("❌ SUBMIT REVIEW ERROR => $e");
      Get.snackbar("Error", "Something went wrong");
      return false;
    } finally {
      isSubmittingReview.value = false;
      print("==================================================");
    }
  }

  @override
  void dispose() {
    reviewCtrl.dispose();
    super.dispose();
  }
}