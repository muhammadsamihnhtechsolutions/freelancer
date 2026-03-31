// import 'package:flutter/material.dart';
// import 'package:freelancer_app/clientsideReview/ClientSideReviewModel.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class ClientSideReviewController extends GetxController {
//   final TextEditingController reviewCtrl = TextEditingController();

//   RxBool isLoadingReviews = false.obs;
//   RxBool isSubmittingReview = false.obs;
//   RxBool hasSubmittedReview = false.obs;

//   RxInt selectedRating = 0.obs;

//   RxList<ClientSideReviewModel> reviews = <ClientSideReviewModel>[].obs;
//   Rxn<ClientSideReviewStatsModel> stats = Rxn<ClientSideReviewStatsModel>();
//   Rxn<ClientSideReviewModel> submittedReview = Rxn<ClientSideReviewModel>();

//   Future<bool> loadReviews({
//     required String jobId,
//   }) async {
//     print("==================================================");
//     print("🚀 LOAD REVIEWS CALLED");
//     print("➡️ JOB ID → $jobId");
//     print("==================================================");

//     if (jobId.trim().isEmpty) {
//       print("❌ LOAD REVIEWS ERROR → INVALID JOB ID");
//       return false;
//     }

//     try {
//       isLoadingReviews.value = true;

//       final res = await ClientSideReviewRepo.getReviews(jobId);

//       print("⬇️ RAW REVIEWS RESPONSE → $res");

//       final bool success = res != null &&
//           (res["success"] == true ||
//               res["reviews"] != null ||
//               res["stats"] != null);

//       if (success) {
//         final parsed = ClientSideReviewListResponseModel.fromJson(
//           Map<String, dynamic>.from(res),
//         );

//         reviews.assignAll(parsed.reviews);
//         stats.value = parsed.stats;

//         print("✅ REVIEWS LOADED SUCCESSFULLY");
//         print("➡️ TOTAL REVIEWS → ${parsed.reviews.length}");
//         print("➡️ AVG RATING → ${parsed.stats.avgRating}");

//         return true;
//       } else {
//         final message = res?["message"] ?? "Failed to load reviews";
//         print("❌ LOAD REVIEWS FAILED → $message");
//         return false;
//       }
//     } catch (e) {
//       print("❌ LOAD REVIEWS EXCEPTION → $e");
//       return false;
//     } finally {
//       isLoadingReviews.value = false;
//       print("🔄 isLoadingReviews → ${isLoadingReviews.value}");
//       print("==================================================");
//     }
//   }

//  Future<bool> submitReview({
//   required String jobId,
// }) async {
//   print("==================================================");
//   print("🚀 SUBMIT REVIEW CALLED");
//   print("➡️ JOB ID → $jobId");
//   print("➡️ SELECTED RATING → ${selectedRating.value}");
//   print("➡️ REVIEW TEXT → ${reviewCtrl.text.trim()}");
//   print("==================================================");

//   if (hasSubmittedReview.value) {
//     Get.snackbar("Info", "You have already submitted a review");
//     print("ℹ️ REVIEW ALREADY SUBMITTED FOR THIS SCREEN");
//     return false;
//   }

//   if (jobId.trim().isEmpty) {
//     Get.snackbar("Error", "Invalid job ID");
//     print("❌ SUBMIT REVIEW ERROR → INVALID JOB ID");
//     return false;
//   }

//   if (selectedRating.value <= 0) {
//     Get.snackbar("Error", "Please select rating");
//     print("❌ SUBMIT REVIEW ERROR → NO RATING SELECTED");
//     return false;
//   }

//   if (reviewCtrl.text.trim().isEmpty) {
//     Get.snackbar("Error", "Please write review");
//     print("❌ SUBMIT REVIEW ERROR → EMPTY REVIEW");
//     return false;
//   }

//   try {
//     isSubmittingReview.value = true;

//     final res = await ClientSideReviewRepo.submitReview(
//       jobId: jobId,
//       rating: selectedRating.value,
//       review: reviewCtrl.text.trim(),
//     );

//     print("⬇️ RAW SUBMIT REVIEW RESPONSE → $res");

//     final bool success =
//         res != null &&
//         (
//           res["success"] == true ||
//           res["review"] != null ||
//           (res["message"]?.toString().toLowerCase().contains("successfully") ?? false)
//         );

//     if (success) {
//       final parsed = ClientSideSubmitReviewResponseModel.fromJson(
//         Map<String, dynamic>.from(res),
//       );

//       hasSubmittedReview.value = true;
//       submittedReview.value = parsed.review;

//       if (parsed.review != null) {
//         reviews.insert(0, parsed.review!);
//         selectedRating.value = parsed.review!.rating;
//         reviewCtrl.text = parsed.review!.review;
//       }

//       final currentStats = stats.value;
//       if (currentStats != null) {
//         final int newTotal = currentStats.totalReviews + 1;
//         final double newAvg =
//             ((currentStats.avgRating * currentStats.totalReviews) +
//                     selectedRating.value) /
//                 newTotal;

//         stats.value = ClientSideReviewStatsModel(
//           totalReviews: newTotal,
//           avgRating: double.parse(newAvg.toStringAsFixed(1)),
//         );
//       } else {
//         stats.value = ClientSideReviewStatsModel(
//           totalReviews: 1,
//           avgRating: selectedRating.value.toDouble(),
//         );
//       }

//       final message = parsed.message.isNotEmpty
//           ? parsed.message
//           : "Review submitted successfully";

//       print("✅ SUBMIT REVIEW SUCCESS → $message");
//       print("➡️ hasSubmittedReview → ${hasSubmittedReview.value}");

//       Get.snackbar("Success", message);
//       return true;
//     } else {
//       final message = res?["message"] ?? "Failed to submit review";
//       print("❌ SUBMIT REVIEW FAILED → $message");
//       Get.snackbar("Error", message);
//       return false;
//     }
//   } catch (e) {
//     print("❌ SUBMIT REVIEW EXCEPTION → $e");
//     Get.snackbar("Error", "Something went wrong");
//     return false;
//   } finally {
//     isSubmittingReview.value = false;
//     print("🔄 isSubmittingReview → ${isSubmittingReview.value}");
//     print("==================================================");
//   }
// }

//   void setRating(int value) {
//     if (hasSubmittedReview.value) return;
//     selectedRating.value = value;
//     print("⭐ RATING SET → $value");
//   }

//   void clearForm() {
//     reviewCtrl.clear();
//     selectedRating.value = 0;
//     hasSubmittedReview.value = false;
//     submittedReview.value = null;
//     print("🧹 REVIEW FORM CLEARED");
//   }

//   void setSubmittedReviewUi({
//     required int rating,
//     required String reviewText,
//   }) {
//     hasSubmittedReview.value = true;
//     selectedRating.value = rating;
//     reviewCtrl.text = reviewText;
//     print("🧾 SUBMITTED REVIEW UI LOCKED");
//   }

//   @override
//   void dispose() {
//     reviewCtrl.dispose();
//     super.dispose();
//   }
// }
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

  /// ==================================================
  /// GET REVIEWS
  /// ==================================================
  Future<bool> loadReviews({
    required String jobId,
  }) async {
    final cleanJobId = jobId.trim();

    print("==================================================");
    print("🚀 CLIENT LOAD REVIEWS CALLED");
    print("➡️ JOB ID → $cleanJobId");
    print("==================================================");

    if (cleanJobId.isEmpty) {
      print("❌ CLIENT LOAD REVIEWS ERROR → INVALID JOB ID");

      reviews.clear();
      stats.value = null;
      isLoadingReviews.value = false;

      return false;
    }

    try {
      isLoadingReviews.value = true;

      print("🔄 isLoadingReviews → ${isLoadingReviews.value}");
      print("📡 CALLING CLIENT GET REVIEW REPO...");

      final res = await ClientGetReviewRepo.getReviews(cleanJobId);

      print("--------------------------------------------------");
      print("⬇️ RAW CLIENT GET REVIEWS RESPONSE → $res");
      print("--------------------------------------------------");

      if (res == null) {
        print("❌ CLIENT LOAD REVIEWS FAILED → RESPONSE IS NULL");

        reviews.clear();
        stats.value = null;

        return false;
      }

      final bool success = res["success"] == true ||
          res["reviews"] != null ||
          res["stats"] != null;

      print("📦 CLIENT LOAD REVIEWS PARSE CHECK");
      print("➡️ success flag → ${res["success"]}");
      print("➡️ reviews exists → ${res["reviews"] != null}");
      print("➡️ stats exists → ${res["stats"] != null}");
      print("➡️ final success → $success");

      if (!success) {
        final message = res["message"] ?? "Failed to load reviews";

        print("❌ CLIENT LOAD REVIEWS FAILED → $message");

        reviews.clear();
        stats.value = null;

        return false;
      }

      final parsed = ClientSideReviewListResponseModel.fromJson(
        Map<String, dynamic>.from(res),
      );

      reviews.assignAll(parsed.reviews);
      stats.value = parsed.stats;

      print("✅ CLIENT REVIEWS LOADED SUCCESSFULLY");
      print("➡️ TOTAL REVIEWS → ${parsed.reviews.length}");
      print("➡️ STATS TOTAL REVIEWS → ${parsed.stats.totalReviews}");
      print("➡️ AVG RATING → ${parsed.stats.avgRating}");

      if (parsed.reviews.isNotEmpty) {
        for (int i = 0; i < parsed.reviews.length; i++) {
          final item = parsed.reviews[i];

          print("📝 REVIEW [$i]");
          print("   🆔 id → ${item.id}");
          print("   💼 jobId → ${item.jobId}");
          print("   ⭐ rating → ${item.rating}");
          print("   💬 review → ${item.review}");
          print("   👤 reviewerName → ${item.reviewerName}");
          print("   📧 reviewerEmail → ${item.reviewerEmail}");
          print("   🕒 createdAt → ${item.createdAt}");
        }
      } else {
        print("⚠️ CLIENT REVIEWS LIST EMPTY");
      }

      return true;
    } catch (e) {
      print("❌ CLIENT LOAD REVIEWS EXCEPTION → $e");

      reviews.clear();
      stats.value = null;

      return false;
    } finally {
      isLoadingReviews.value = false;

      print("🔄 isLoadingReviews → ${isLoadingReviews.value}");
      print("➡️ reviews.length → ${reviews.length}");
      print("➡️ stats.value → ${stats.value}");
      print("==================================================");
    }
  }

  /// ==================================================
  /// SUBMIT REVIEW
  /// ==================================================
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

      final bool success = res != null &&
          (res["success"] == true ||
              res["review"] != null ||
              (res["message"]
                      ?.toString()
                      .toLowerCase()
                      .contains("successfully") ??
                  false));

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
    reviews.clear();
    stats.value = null;
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