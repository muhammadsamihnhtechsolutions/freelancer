import 'package:flutter/material.dart';

class FreelancerReviewsSection extends StatelessWidget {
  const FreelancerReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
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

        const Text(
          "4.1 / 5 (13 reviews)",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const SizedBox(height: 16),

        // SCROLLABLE ROW
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 8),
            itemCount: freelancerReviews.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final review = freelancerReviews[index];

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
                    // Avatar + Title Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.indigo.shade100,
                          child: Text(
                            review['name'][0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${review['name']} (Freelancer)",
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

                    // ⭐ Stars Row
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < review['rating']
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Review text
                    Expanded(
                      child: Text(
                        review['review'],
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      review['time'],
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
  }
}

// ---------------------------
// DUMMY DATA
// ---------------------------
final List<Map<String, dynamic>> freelancerReviews = [
  {
    "name": "Abdul rahim",
    "rating": 4,
    "review": "nicee I like this man",
    "time": "1 day ago",
  },
  {
    "name": "Abdul rahim",
    "rating": 3,
    "review": "d",
    "time": "1 day ago",
  },
  {
    "name": "Abdul rahim",
    "rating": 5,
    "review": "excellent freelancer!",
    "time": "2 days ago",
  },
  {
    "name": "Abdul rahim",
    "rating": 4,
    "review": "good job delivered",
    "time": "3 days ago",
  },
];