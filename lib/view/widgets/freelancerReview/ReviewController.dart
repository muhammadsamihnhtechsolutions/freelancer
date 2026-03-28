// import 'package:freelancer_app/service/Repo.dart';
// import 'package:freelancer_app/view/widgets/freelancerReview/ReviewModel.dart';
// import 'package:get/get.dart';

// class ReviewController extends GetxController {

//   final repo = ReviewsRepo();

//   RxBool loading = false.obs;

//   RxList<ReviewModel> reviews = <ReviewModel>[].obs;

//   RxDouble avgRating = 0.0.obs;

//   RxInt totalReviews = 0.obs;

//   Future fetchReviews(String userId) async {

//     print("--------------------------------------------------");
//     print("🟢 FETCH REVIEWS CALLED");
//     print("➡️ USER ID → $userId");
//     print("--------------------------------------------------");

//     loading.value = true;

//     try {

//       final data = await ReviewsRepo.getUserReviews(userId);

//       print("📦 REVIEWS RECEIVED FROM REPO → ${data.length}");

//       reviews.assignAll(data);

//       totalReviews.value = data.length;

//       /// CALCULATE AVERAGE RATING
//       if (data.isNotEmpty) {

//         double total = 0;

//         for (var r in data) {

//           print("⭐ REVIEW → ${r.name} | Rating: ${r.rating}");

//           total += r.rating;
//         }

//         avgRating.value = total / data.length;

//         print("⭐ AVG RATING → ${avgRating.value}");

//       } else {

//         avgRating.value = 0;

//         print("⚠️ NO REVIEWS FOUND");
//       }

//       print("✅ REVIEWS STORED IN CONTROLLER → ${reviews.length}");

//     } catch (e) {

//       print("❌ REVIEW CONTROLLER ERROR → $e");

//     } finally {

//       loading.value = false;

//       print("🔄 LOADING FINISHED");
//       print("--------------------------------------------------");
//     }
//   }
// }
import 'package:freelancer_app/service/Repo.dart';
import 'package:freelancer_app/view/widgets/freelancerReview/ReviewModel.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final repo = ReviewsRepo();

  RxBool loading = false.obs;
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  RxDouble avgRating = 0.0.obs;
  RxInt totalReviews = 0.obs;

  Future fetchReviews(String userId) async {
    print("--------------------------------------------------");
    print("🟢 FETCH REVIEWS CALLED");
    print("➡️ USER ID → $userId");
    print("--------------------------------------------------");

    if (userId.trim().isEmpty) {
      print("❌ FETCH REVIEWS STOPPED → USER ID EMPTY");
      reviews.clear();
      avgRating.value = 0.0;
      totalReviews.value = 0;
      loading.value = false;
      return;
    }

    loading.value = true;

    try {
      final data = await ReviewsRepo.getUserReviews(userId);

      print("📦 REVIEWS RECEIVED FROM REPO → ${data.length}");

      reviews.assignAll(data);
      totalReviews.value = data.length;

      if (data.isNotEmpty) {
        double total = 0;

        for (var r in data) {
          print("⭐ REVIEW → ${r.name} | Rating: ${r.rating}");
          total += r.rating;
        }

        avgRating.value = total / data.length;
        print("⭐ AVG RATING → ${avgRating.value}");
      } else {
        avgRating.value = 0;
        print("⚠️ NO REVIEWS FOUND");
      }

      print("✅ REVIEWS STORED IN CONTROLLER → ${reviews.length}");
    } catch (e) {
      print("❌ REVIEW CONTROLLER ERROR → $e");
    } finally {
      loading.value = false;
      print("🔄 LOADING FINISHED");
      print("--------------------------------------------------");
    }
  }
}