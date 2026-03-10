import 'package:flutter/material.dart';
import 'package:freelancer_app/graphweeklyrecntlyclient.dart/GraphActivityController.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class RecentActivityWidget extends StatelessWidget {
  RecentActivityWidget({super.key});

  final controller = Get.find<GraphActivityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Icon(Icons.trending_up, size: 18),
              SizedBox(width: 6),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// DATA
          Obx(() {

            /// LOADING
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            /// EMPTY
            if (controller.activities.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "No recent activity found",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.activities.length > 6
                  ? 6
                  : controller.activities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {

                final item = controller.activities[index];

                final DateTime date = item["date"];

                final formattedDate =
                    DateFormat("dd/MM/yyyy").format(date);

                final status = item["status"] ?? "pending";

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ACTION
                    SizedBox(
                      width: 55,
                      child: Text(
                        item['action'] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// JOB TITLE
                    Expanded(
                      child: Text(
                        item['job'] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// DATE
                    SizedBox(
                      width: 75,
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// STATUS BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: status == "accepted"
                            ? const Color(0xFFDDF7E4)
                            : const Color(0xFFFFF4D6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          color: status == "accepted"
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}