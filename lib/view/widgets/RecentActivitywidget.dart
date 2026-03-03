import 'package:flutter/material.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

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
          // TITLE
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

          // LIST
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activityList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = activityList[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ACTION
                  SizedBox(
                    width: 55,
                    child: Text(
                      item['action'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // JOB TITLE
                  Expanded(
                    child: Text(
                      item['job'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // DATE
                  SizedBox(
                    width: 70,
                    child: Text(
                      item['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // STATUS BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF7E4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------
// DUMMY DATA
// ---------------------------------------

final List<Map<String, dynamic>> activityList = [
  {
    "action": "Hired",
    "job": "QWASADADADAS",
    "date": "2/04/2026",
  },
  {
    "action": "Hired",
    "job": "the example job",
    "date": "2/01/2026",
  },
  {
    "action": "Hired",
    "job": "hello a job anddwwwww",
    "date": "2/01/2026",
  },
  {
    "action": "Hired",
    "job": "ddddwwwwwwwwwwww",
    "date": "2/01/2026",
  },
  {
    "action": "Hired",
    "job": "example job !!!!!!!!!!!!!!!!!!!!!!!",
    "date": "2/01/2026",
  },
  {
    "action": "Hired",
    "job": "This is job a-776",
    "date": "2/01/2026",
  },
];