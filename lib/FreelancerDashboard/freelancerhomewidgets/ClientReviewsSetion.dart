import 'package:flutter/material.dart';

class ClientReviewsSection extends StatelessWidget {
  const ClientReviewsSection({super.key});

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
              "Client Reviews",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        const Text(
          "3.9 / 5 (15 reviews)",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 8),
            itemCount: dummyReviews.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final review = dummyReviews[index];

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
                            review['name'],
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

                    // Stars Row
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
                        review['text'],
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

// ----------------------
// DUMMY DATA
// ----------------------
final List<Map<String, dynamic>> dummyReviews = [
  {
    "name": "SYED AMEEN AHMED",
    "rating": 5,
    "text": "asdddddddddd",
    "time": "2 days ago"
  },
  {
    "name": "SYED AMEEN AHMED",
    "rating": 4,
    "text": "2:59 reviewq",
    "time": "2 days ago"
  },
  {
    "name": "SYED AMEEN AHMED",
    "rating": 5,
    "text": "nice man freelancer 122121",
    "time": "2 days ago"
  },
  {
    "name": "SYED AMEEN AHMED",
    "rating": 4,
    "text": "nice freelancer work aadsasdada",
    "time": "2 days ago"
  },
  {
    "name": "SYED AMEEN AHMED",
    "rating": 5,
    "text": "hy this job client",
    "time": "2 days ago"
  },
];