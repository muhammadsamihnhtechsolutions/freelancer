// import 'package:flutter/material.dart';
// import 'package:freelancer_app/view/widgets/freelancerReview/ReviewController.dart';
// import 'package:get/get.dart';

// class FreelancerReviewsSection extends StatefulWidget {
//   final String userId;

//   const FreelancerReviewsSection({
//     super.key,
//     required this.userId,
//   });

//   @override
//   State<FreelancerReviewsSection> createState() =>
//       _FreelancerReviewsSectionState();
// }

// class _FreelancerReviewsSectionState extends State<FreelancerReviewsSection> {
//   late final ReviewController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = Get.isRegistered<ReviewController>()
//         ? Get.find<ReviewController>()
//         : Get.put(ReviewController());

//     print("==================================================");
//     print("📌 FREELANCER REVIEWS SECTION INIT");
//     print("➡️ widget.userId → ${widget.userId}");
//     print("==================================================");

//     _loadReviews();
//   }

//   Future<void> _loadReviews() async {
//     final userId = widget.userId.trim();

//     print("--------------------------------------------------");
//     print("🟣 LOAD FREELANCER REVIEWS START");
//     print("➡️ userId → $userId");
//     print("--------------------------------------------------");

//     if (userId.isEmpty) {
//       print("❌ FREELANCER REVIEWS ERROR → userId is empty");

//       controller.reviews.clear();
//       controller.avgRating.value = 0.0;
//       controller.totalReviews.value = 0;
//       controller.loading.value = false;

//       return;
//     }

//     try {
//       await controller.fetchReviews(userId);

//       print("✅ FREELANCER REVIEWS FETCH COMPLETED");
//       print("➡️ totalReviews → ${controller.totalReviews.value}");
//       print("➡️ avgRating → ${controller.avgRating.value}");
//       print("➡️ listLength → ${controller.reviews.length}");

//       if (controller.reviews.isNotEmpty) {
//         for (int i = 0; i < controller.reviews.length; i++) {
//           final item = controller.reviews[i];
//           print("📝 REVIEW [$i]");
//           print("   👤 name → ${item.name}");
//           print("   ⭐ rating → ${item.rating}");
//           print("   💬 review → ${item.review}");
//           print("   🕒 time → ${item.time}");
//         }
//       } else {
//         print("⚠️ NO REVIEWS FOUND FOR THIS USER");
//       }
//     } catch (e) {
//       print("❌ FREELANCER REVIEWS SECTION ERROR → $e");
//     }

//     print("--------------------------------------------------");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       print("🔄 REVIEWS UI REBUILD");
//       print("➡️ loading → ${controller.loading.value}");
//       print("➡️ reviews.length → ${controller.reviews.length}");
//       print("➡️ avgRating → ${controller.avgRating.value}");
//       print("➡️ totalReviews → ${controller.totalReviews.value}");

//       if (controller.loading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (widget.userId.trim().isEmpty) {
//         return const Text("Freelancer id missing");
//       }

//       if (controller.reviews.isEmpty) {
//         return const Text("No reviews yet");
//       }

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: const [
//               Icon(Icons.star_border, size: 18),
//               SizedBox(width: 6),
//               Text(
//                 "Freelancer Reviews",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "${controller.avgRating.value.toStringAsFixed(1)} / 5 (${controller.totalReviews.value} reviews)",
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 150,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: controller.reviews.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (_, index) {
//                 final review = controller.reviews[index];

//                 return Container(
//                   width: 250,
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.06),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 18,
//                             backgroundColor: Colors.indigo.shade100,
//                             child: Text(
//                               review.name.isNotEmpty
//                                   ? review.name[0].toUpperCase()
//                                   : "?",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.indigo.shade600,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               "${review.name} (Freelancer)",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 13,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: List.generate(
//                           5,
//                           (i) => Icon(
//                             i < review.rating
//                                 ? Icons.star
//                                 : Icons.star_border,
//                             size: 16,
//                             color: Colors.amber,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Expanded(
//                         child: Text(
//                           review.review,
//                           style: const TextStyle(fontSize: 12),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         review.time,
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/view/widgets/freelancerReview/ReviewController.dart';
import 'package:get/get.dart';

class FreelancerReviewsSection extends StatefulWidget {
  final String userId;

  const FreelancerReviewsSection({
    super.key,
    required this.userId,
  });

  @override
  State<FreelancerReviewsSection> createState() =>
      _FreelancerReviewsSectionState();
}

class _FreelancerReviewsSectionState extends State<FreelancerReviewsSection> {
  late final ReviewController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<ReviewController>()
        ? Get.find<ReviewController>()
        : Get.put(ReviewController());

    print("==================================================");
    print("📌 CLIENT REVIEWS SECTION INIT");
    print("➡️ widget.userId → ${widget.userId}");
    print("==================================================");

    _loadReviews();
  }

  Future<void> _loadReviews() async {
    final userId = widget.userId.trim();

    print("--------------------------------------------------");
    print("🟣 LOAD CLIENT REVIEWS START");
    print("➡️ userId → $userId");
    print("--------------------------------------------------");

    if (userId.isEmpty) {
      print("❌ CLIENT REVIEWS ERROR → userId is empty");

      controller.reviews.clear();
      controller.avgRating.value = 0.0;
      controller.totalReviews.value = 0;
      controller.loading.value = false;

      return;
    }

    try {
      await controller.fetchReviews(userId);

      print("✅ CLIENT REVIEWS FETCH COMPLETED");
      print("➡️ totalReviews → ${controller.totalReviews.value}");
      print("➡️ avgRating → ${controller.avgRating.value}");
      print("➡️ listLength → ${controller.reviews.length}");

      if (controller.reviews.isNotEmpty) {
        for (int i = 0; i < controller.reviews.length; i++) {
          final item = controller.reviews[i];
          print("📝 REVIEW [$i]");
          print("   👤 name → ${item.name}");
          print("   ⭐ rating → ${item.rating}");
          print("   💬 review → ${item.review}");
          print("   🕒 time → ${item.time}");
        }
      } else {
        print("⚠️ NO REVIEWS FOUND FOR THIS USER");
      }
    } catch (e) {
      print("❌ CLIENT REVIEWS SECTION ERROR → $e");
    }

    print("--------------------------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("🔄 REVIEWS UI REBUILD");
      print("➡️ loading → ${controller.loading.value}");
      print("➡️ reviews.length → ${controller.reviews.length}");
      print("➡️ avgRating → ${controller.avgRating.value}");
      print("➡️ totalReviews → ${controller.totalReviews.value}");

      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (widget.userId.trim().isEmpty) {
        return const Text("Client id missing");
      }

      if (controller.reviews.isEmpty) {
        return const Text("No reviews yet");
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.star_border, size: 18),
              SizedBox(width: 6),
              Text(
                "Client Reviews",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${controller.avgRating.value.toStringAsFixed(1)} / 5 (${controller.totalReviews.value} reviews)",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.reviews.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) {
                final review = controller.reviews[index];

                return Container(
                  width: 250,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.indigo.shade100,
                            child: Text(
                              review.name.isNotEmpty
                                  ? review.name[0].toUpperCase()
                                  : "?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "${review.name} (Client)",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          review.review,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}