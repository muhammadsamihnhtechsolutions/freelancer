

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart';
// import 'package:freelancer_app/theme/AppColors.dart';

// class ProposalDetailsView extends StatelessWidget {

//   final JobModel job;

//   const ProposalDetailsView({
//     super.key,
//     required this.job,
//   });

//   @override
//   Widget build(BuildContext context) {

//     print("--------------------------------------------------");
//     print("📄 PROPOSAL DETAILS SCREEN OPENED");
//     print("🆔 Job ID → ${job.id}");
//     print("🧾 Title → ${job.title}");
//     print("💰 Budget Min → ${job.minBudget}");
//     print("💰 Budget Max → ${job.maxBudget}");
//     print("📦 Category → ${job.category}");
//     print("📝 Description → ${job.description}");
//     print("--------------------------------------------------");

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () {
//             print("⬅️ BACK PRESSED");
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "Proposal Detail",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w800,
//             color: Colors.black,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             const Text(
//               "Manage your proposal efficiently",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),

//             const SizedBox(height: 18),

//             /// USER CARD
//             _userInfoCard(),

//             const SizedBox(height: 18),

//             /// BID INFO
//             Row(
//               children: [

//                 Expanded(
//                   child: _infoTile(
//                     "Budget",
//                     "£${job.minBudget} - £${job.maxBudget}",
//                     Icons.attach_money,
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: _infoTile(
//                     "Category",
//                     job.category,
//                     Icons.category,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 22),

//             /// JOB DESCRIPTION
//             const Text(
//               "Job Description",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//               ),
//             ),

//             const SizedBox(height: 10),

//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),

//               child: Text(
//                 job.description.isNotEmpty
//                     ? job.description
//                     : "No description provided",

//                 style: const TextStyle(
//                   color: Colors.black87,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- USER INFO CARD ----------------

//   Widget _userInfoCard() {

//     print("👤 BUILDING USER CARD");

//     return Container(
//       padding: const EdgeInsets.all(16),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),

//       child: Row(
//         children: [

//           /// AVATAR
//           CircleAvatar(
//             radius: 26,
//             backgroundColor: AppColors.primaryStart,

//             child: Text(
//               job.title.isNotEmpty
//                   ? job.title.substring(0,1).toUpperCase()
//                   : "J",

//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//           ),

//           const SizedBox(width: 12),

//           /// JOB TITLE
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Text(
//                   job.title.isNotEmpty ? job.title : "Untitled Job",

//                   style: const TextStyle(
//                     fontWeight: FontWeight.w800,
//                     fontSize: 16,
//                   ),
//                 ),

//                 const Text(
//                   "Client Job Post",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// STATUS BADGE
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 14,
//               vertical: 6,
//             ),

//             decoration: BoxDecoration(
//               color: AppColors.primaryEnd.withOpacity(0.18),
//               borderRadius: BorderRadius.circular(20),
//             ),

//             child: Text(
//               job.status.toUpperCase(),

//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.primaryStart,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------- INFO TILE ----------------

//   Widget _infoTile(String label, String value, IconData icon) {

//     print("📊 BUILD INFO TILE → $label : $value");

//     return Container(
//       padding: const EdgeInsets.all(14),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),

//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),

//       child: Row(
//         children: [

//           Icon(
//             icon,
//             size: 20,
//             color: AppColors.primaryStart,
//           ),

//           const SizedBox(width: 10),

//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.black54,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/SubmitProPosalView.dart';
import 'package:freelancer_app/theme/AppColors.dart';
import 'package:get/get.dart';

class ProposalDetailsView extends StatelessWidget {

  final JobModel job;

  const ProposalDetailsView({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {

    print("--------------------------------------------------");
    print("📄 PROPOSAL DETAILS SCREEN OPENED");
    print("🆔 Job ID → ${job.id}");
    print("🧾 Title → ${job.title}");
    print("💰 Budget Min → ${job.minBudget}");
    print("💰 Budget Max → ${job.maxBudget}");
    print("📦 Category → ${job.category}");
    print("📝 Description → ${job.description}");
    print("--------------------------------------------------");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            print("⬅️ BACK PRESSED");
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Proposal Detail",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Manage your proposal efficiently",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 18),

            /// USER CARD
            _userInfoCard(),

            const SizedBox(height: 18),

            /// BID INFO
            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    "Budget",
                    "£${job.minBudget} - £${job.maxBudget}",
                    Icons.attach_money,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoTile(
                    "Category",
                    job.category,
                    Icons.category,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            /// JOB DESCRIPTION
            const Text(
              "Job Description",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Container(
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

              child: Text(
                job.description.isNotEmpty
                    ? job.description
                    : "No description provided",
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// APPLY BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: () {

                  print("=================================");
                  print("🚀 APPLY BUTTON PRESSED");
                  print("📌 JOB ID → ${job.id}");
                  print("=================================");

                  if (job.id.isEmpty) {

                    print("❌ JOB ID EMPTY");

                    Get.snackbar(
                      "Error",
                      "Invalid job ID",
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    return;
                  }

                  Get.to(
                    () => SubmitProposalView(
                      jobId: job.id,
                        alreadySubmitted: job.alreadySubmitted,
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryStart,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  "Apply For Job",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- USER INFO CARD ----------------

  Widget _userInfoCard() {

    print("👤 BUILDING USER CARD");

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryStart,

            child: Text(
              job.title.isNotEmpty
                  ? job.title.substring(0,1).toUpperCase()
                  : "J",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  job.title.isNotEmpty ? job.title : "Untitled Job",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),

                const Text(
                  "Client Job Post",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryEnd.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              job.status.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryStart,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- INFO TILE ----------------

  Widget _infoTile(String label, String value, IconData icon) {

    print("📊 BUILD INFO TILE → $label : $value");

    return Container(
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

      child: Row(
        children: [

          Icon(
            icon,
            size: 20,
            color: AppColors.primaryStart,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}