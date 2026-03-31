import 'package:flutter/material.dart';
import 'package:freelancer_app/clientsideReview/ClientSideReviewController.dart';
import 'package:get/get.dart';

class ClientGetReviewsWidget extends StatefulWidget {
  final String jobId;

  const ClientGetReviewsWidget({
    super.key,
    required this.jobId,
  });

  @override
  State<ClientGetReviewsWidget> createState() => _ClientGetReviewsWidgetState();
}

class _ClientGetReviewsWidgetState extends State<ClientGetReviewsWidget> {
  late final ClientSideReviewController controller;

@override
void initState() {
  super.initState();

  controller = Get.isRegistered<ClientSideReviewController>()
      ? Get.find<ClientSideReviewController>()
      : Get.put(ClientSideReviewController());

  WidgetsBinding.instance.addPostFrameCallback((_) {
        print("==================================================");
    print("📌 CLIENT GET REVIEWS WIDGET INIT");
    print("➡️ JOB ID → ${widget.jobId}");
    print("==================================================");
    _loadReviews(); 
  });
}



  

  Future<void> _loadReviews() async {
    final cleanJobId = widget.jobId.trim();

    print("--------------------------------------------------");
    print("🚀 WIDGET LOAD REVIEWS START");
    print("➡️ JOB ID → $cleanJobId");
    print("--------------------------------------------------");

    if (cleanJobId.isEmpty) {
      print("❌ WIDGET LOAD REVIEWS ERROR → JOB ID EMPTY");
      return;
    }

    await controller.loadReviews(jobId: cleanJobId);

    print("✅ WIDGET LOAD REVIEWS DONE");
    print("➡️ REVIEWS LENGTH → ${controller.reviews.length}");
    print("➡️ STATS → ${controller.stats.value?.avgRating}");
    print("--------------------------------------------------");
  }

  Widget _buildStars(int rating) {
    return Row(
      children: List.generate(
        5,
        (i) => Icon(
          i < rating ? Icons.star : Icons.star_border,
          size: 16,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("==================================================");
      print("🔄 CLIENT GET REVIEWS UI REBUILD");
      print("➡️ isLoadingReviews → ${controller.isLoadingReviews.value}");
      print("➡️ reviews.length → ${controller.reviews.length}");
      print("➡️ stats → ${controller.stats.value}");
      print("==================================================");

      if (controller.isLoadingReviews.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (widget.jobId.trim().isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "Job id missing",
            style: TextStyle(
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        );
      }

      if (controller.reviews.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            "No reviews yet",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        );
      }

      final stats = controller.stats.value;

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
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "${stats?.avgRating.toStringAsFixed(1) ?? "0.0"} / 5 (${stats?.totalReviews ?? controller.reviews.length} reviews)",
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 165,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.reviews.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = controller.reviews[index];

                return Container(
                  width: 270,
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
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
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
                              item.reviewerName.isNotEmpty
                                  ? item.reviewerName[0].toUpperCase()
                                  : "?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.reviewerName.isNotEmpty
                                      ? item.reviewerName
                                      : "Unknown User",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.reviewerEmail.isNotEmpty
                                      ? item.reviewerEmail
                                      : "No email",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildStars(item.rating),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          item.review.isNotEmpty ? item.review : "No review text",
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.createdAt,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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