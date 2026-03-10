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

class _FreelancerReviewsSectionState
    extends State<FreelancerReviewsSection> {

  final controller = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();

    print("📌 REVIEW USER ID → ${widget.userId}");

    controller.fetchReviews(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
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
                "Freelancer Reviews",
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
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          CircleAvatar(
                            radius: 18,
                            backgroundColor:
                                Colors.indigo.shade100,
                            child: Text(
                              review.name[0],
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors
                                    .indigo.shade600,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              "${review.name} (Freelancer)",
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.w700,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
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
                          style:
                              const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
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