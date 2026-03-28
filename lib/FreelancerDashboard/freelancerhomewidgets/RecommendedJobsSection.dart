// import 'package:flutter/material.dart';

// class RecommendedJobsSection extends StatelessWidget {
//   const RecommendedJobsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title Row
//         Row(
//           children: const [
//             Icon(Icons.work_outline, size: 18),
//             SizedBox(width: 6),
//             Text(
//               "Recommended Jobs",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 16),

//         // JOB CARDS - SCROLLABLE
//         SizedBox(
//           height: 165,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.only(right: 8),
//             itemCount: dummyJobs.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final job = dummyJobs[index];

//               return Container(
//                 width: 260,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),

//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title + "New" Tag
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             job['title'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 3),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade100,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             "New",
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.green.shade800,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 6),

//                     // Job Overview (Dummy)
//                     Text(
//                       job['overview'],
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.black87,
//                       ),
//                     ),

//                     const Spacer(),

//                     // APPLY BUTTON
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: Text(
//                         "Apply →",
//                         style: TextStyle(
//                           color: Colors.indigo.shade600,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),

//         const SizedBox(height: 20),

//         // VIEW MORE JOBS BUTTON
//         Center(
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF5A5BFF),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: const Text(
//               "View More Jobs →",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// // ----------------------
// // DUMMY JOBS LIST
// // ----------------------
// final List<Map<String, dynamic>> dummyJobs = [
//   {
//     "title": "asiiii",
//     "overview":
//         "**Job Overview** — *Responsibility* — *Requirements* — details...",
//   },
//   {
//     "title": "2adasdsad23123oooooooooooooooooo",
//     "overview":
//         "**Job Overview** — *Responsibility* — *Requirements* — details...",
//   },
//   {
//     "title": "q122021",
//     "overview":
//         "**Job Overview** — *Responsibility* — *Requirements* — details...",
//   },
//   {
//     "title": "hello jobbbbbbb",
//     "overview":
//         "**Job Overview** — *Responsibility* — *Requirements* — details...",
//   },
// ];
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FindJobController.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelDetailsView.dart';

class RecommendedJobsSection extends StatelessWidget {
  const RecommendedJobsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------
        // Title
        // -----------------------------
        Row(
          children: const [
            Icon(Icons.work_outline, size: 18),
            SizedBox(width: 6),
            Text(
              "Recommended Jobs",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // -----------------------------
        // Dynamic Jobs List
        // -----------------------------
        SizedBox(
          height: 165,
          child: Obx(() {

            if (controller.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.jobs.isEmpty) {
              return const Center(child: Text("No recommended jobs"));
            }

            // 🔥 Sirf 5 jobs
            final recommendedJobs = controller.jobs.take(5).toList();

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8),
              itemCount: recommendedJobs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {

                final JobModel job = recommendedJobs[index];

                return _jobCard(job);
              },
            );
          }),
        ),

        const SizedBox(height: 20),

        // -----------------------------
        // View More Button
        // -----------------------------
        Center(
          child: GestureDetector(
            onTap: () {
              // Navigate to full jobs screen
              Get.toNamed('/find-jobs'); // adjust route if needed
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF5A5BFF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "View More Jobs →",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // ---------------------------------------------------
  // Job Card (UI same as your static version)
  // ---------------------------------------------------
  Widget _jobCard(JobModel job) {
    return Container(
      width: 260,
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

          // Title + New Tag
          Row(
            children: [
              Expanded(
                child: Text(
                  job.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),

              // Optional: show New if job is recent (example logic)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Overview (using description)
          Text(
            job.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),

          const Spacer(),

          // APPLY BUTTON
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Get.to(() => ProposalDetailsView(job: job));
              },
              child: Text(
                "Apply →",
                style: TextStyle(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}