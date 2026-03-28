import 'package:flutter/material.dart';
import 'package:freelancer_app/clientsideReview/ClientSideReviewModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientSideReviewController extends GetxController {
  final TextEditingController reviewCtrl = TextEditingController();

  RxBool isLoadingReviews = false.obs;
  RxBool isSubmittingReview = false.obs;
  RxBool hasSubmittedReview = false.obs;

  RxInt selectedRating = 0.obs;

  RxList<ClientSideReviewModel> reviews = <ClientSideReviewModel>[].obs;
  Rxn<ClientSideReviewStatsModel> stats = Rxn<ClientSideReviewStatsModel>();
  Rxn<ClientSideReviewModel> submittedReview = Rxn<ClientSideReviewModel>();

  Future<bool> loadReviews({
    required String jobId,
  }) async {
    print("==================================================");
    print("🚀 LOAD REVIEWS CALLED");
    print("➡️ JOB ID → $jobId");
    print("==================================================");

    if (jobId.trim().isEmpty) {
      print("❌ LOAD REVIEWS ERROR → INVALID JOB ID");
      return false;
    }

    try {
      isLoadingReviews.value = true;

      final res = await ClientSideReviewRepo.getReviews(jobId);

      print("⬇️ RAW REVIEWS RESPONSE → $res");

      final bool success = res != null &&
          (res["success"] == true ||
              res["reviews"] != null ||
              res["stats"] != null);

      if (success) {
        final parsed = ClientSideReviewListResponseModel.fromJson(
          Map<String, dynamic>.from(res),
        );

        reviews.assignAll(parsed.reviews);
        stats.value = parsed.stats;

        print("✅ REVIEWS LOADED SUCCESSFULLY");
        print("➡️ TOTAL REVIEWS → ${parsed.reviews.length}");
        print("➡️ AVG RATING → ${parsed.stats.avgRating}");

        return true;
      } else {
        final message = res?["message"] ?? "Failed to load reviews";
        print("❌ LOAD REVIEWS FAILED → $message");
        return false;
      }
    } catch (e) {
      print("❌ LOAD REVIEWS EXCEPTION → $e");
      return false;
    } finally {
      isLoadingReviews.value = false;
      print("🔄 isLoadingReviews → ${isLoadingReviews.value}");
      print("==================================================");
    }
  }

 Future<bool> submitReview({
  required String jobId,
}) async {
  print("==================================================");
  print("🚀 SUBMIT REVIEW CALLED");
  print("➡️ JOB ID → $jobId");
  print("➡️ SELECTED RATING → ${selectedRating.value}");
  print("➡️ REVIEW TEXT → ${reviewCtrl.text.trim()}");
  print("==================================================");

  if (hasSubmittedReview.value) {
    Get.snackbar("Info", "You have already submitted a review");
    print("ℹ️ REVIEW ALREADY SUBMITTED FOR THIS SCREEN");
    return false;
  }

  if (jobId.trim().isEmpty) {
    Get.snackbar("Error", "Invalid job ID");
    print("❌ SUBMIT REVIEW ERROR → INVALID JOB ID");
    return false;
  }

  if (selectedRating.value <= 0) {
    Get.snackbar("Error", "Please select rating");
    print("❌ SUBMIT REVIEW ERROR → NO RATING SELECTED");
    return false;
  }

  if (reviewCtrl.text.trim().isEmpty) {
    Get.snackbar("Error", "Please write review");
    print("❌ SUBMIT REVIEW ERROR → EMPTY REVIEW");
    return false;
  }

  try {
    isSubmittingReview.value = true;

    final res = await ClientSideReviewRepo.submitReview(
      jobId: jobId,
      rating: selectedRating.value,
      review: reviewCtrl.text.trim(),
    );

    print("⬇️ RAW SUBMIT REVIEW RESPONSE → $res");

    final bool success =
        res != null &&
        (
          res["success"] == true ||
          res["review"] != null ||
          (res["message"]?.toString().toLowerCase().contains("successfully") ?? false)
        );

    if (success) {
      final parsed = ClientSideSubmitReviewResponseModel.fromJson(
        Map<String, dynamic>.from(res),
      );

      hasSubmittedReview.value = true;
      submittedReview.value = parsed.review;

      if (parsed.review != null) {
        reviews.insert(0, parsed.review!);
        selectedRating.value = parsed.review!.rating;
        reviewCtrl.text = parsed.review!.review;
      }

      final currentStats = stats.value;
      if (currentStats != null) {
        final int newTotal = currentStats.totalReviews + 1;
        final double newAvg =
            ((currentStats.avgRating * currentStats.totalReviews) +
                    selectedRating.value) /
                newTotal;

        stats.value = ClientSideReviewStatsModel(
          totalReviews: newTotal,
          avgRating: double.parse(newAvg.toStringAsFixed(1)),
        );
      } else {
        stats.value = ClientSideReviewStatsModel(
          totalReviews: 1,
          avgRating: selectedRating.value.toDouble(),
        );
      }

      final message = parsed.message.isNotEmpty
          ? parsed.message
          : "Review submitted successfully";

      print("✅ SUBMIT REVIEW SUCCESS → $message");
      print("➡️ hasSubmittedReview → ${hasSubmittedReview.value}");

      Get.snackbar("Success", message);
      return true;
    } else {
      final message = res?["message"] ?? "Failed to submit review";
      print("❌ SUBMIT REVIEW FAILED → $message");
      Get.snackbar("Error", message);
      return false;
    }
  } catch (e) {
    print("❌ SUBMIT REVIEW EXCEPTION → $e");
    Get.snackbar("Error", "Something went wrong");
    return false;
  } finally {
    isSubmittingReview.value = false;
    print("🔄 isSubmittingReview → ${isSubmittingReview.value}");
    print("==================================================");
  }
}

  void setRating(int value) {
    if (hasSubmittedReview.value) return;
    selectedRating.value = value;
    print("⭐ RATING SET → $value");
  }

  void clearForm() {
    reviewCtrl.clear();
    selectedRating.value = 0;
    hasSubmittedReview.value = false;
    submittedReview.value = null;
    print("🧹 REVIEW FORM CLEARED");
  }

  void setSubmittedReviewUi({
    required int rating,
    required String reviewText,
  }) {
    hasSubmittedReview.value = true;
    selectedRating.value = rating;
    reviewCtrl.text = reviewText;
    print("🧾 SUBMITTED REVIEW UI LOCKED");
  }

  @override
  void dispose() {
    reviewCtrl.dispose();
    super.dispose();
  }
}