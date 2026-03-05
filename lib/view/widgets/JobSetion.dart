// import 'package:flutter/material.dart';

// class JobsEmptyStateWidget extends StatefulWidget {
//   const JobsEmptyStateWidget({super.key});

//   @override
//   State<JobsEmptyStateWidget> createState() => _JobsEmptyStateWidgetState();
// }

// class _JobsEmptyStateWidgetState extends State<JobsEmptyStateWidget> {
//   int selectedIndex = 1; // 0=All, 1=Open, 2=Closed

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _FilterTabs(
//           selectedIndex: selectedIndex,
//           onChanged: (i) => setState(() => selectedIndex = i),
//         ),
//         const SizedBox(height: 14),
//         _EmptyJobsCard(
//           onPostJob: () {
//             // TODO: navigate to Post Job screen
//           },
//         ),
//       ],
//     );
//   }
// }

// /// -------------------------
// /// FILTER TABS (All/Open/Closed)
// /// -------------------------
// class _FilterTabs extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onChanged;

//   const _FilterTabs({
//     required this.selectedIndex,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final labels = const ["All", "Open", "Closed"];

//     return Wrap(
//       spacing: 10,
//       children: List.generate(labels.length, (i) {
//         final isActive = selectedIndex == i;
//         return InkWell(
//           onTap: () => onChanged(i),
//           borderRadius: BorderRadius.circular(20),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 180),
//             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//             decoration: BoxDecoration(
//               color: isActive ? const Color(0xFF2F6BFF) : const Color(0xFFF2F4F7),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               labels[i],
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: isActive ? Colors.white : const Color(0xFF344054),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// /// -------------------------
// /// EMPTY CARD (No jobs yet + button)
// /// -------------------------
// class _EmptyJobsCard extends StatelessWidget {
//   final VoidCallback onPostJob;

//   const _EmptyJobsCard({required this.onPostJob});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 18,
//             offset: const Offset(0, 8),
//           ),
//         ],
//         border: Border.all(color: const Color(0xFFEAECF0)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Icon ($)
//           Container(
//             height: 40,
//             width: 40,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: const Color(0xFFF2F4F7),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text(
//               "\$",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF475467),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),

//           const Text(
//             "No jobs yet",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF101828),
//             ),
//           ),
//           const SizedBox(height: 6),

//           const Text(
//             "Post a job to start hiring top talent.",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               height: 1.3,
//               color: Color(0xFF667085),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 12),

//           // + Post Job Button
//           ElevatedButton.icon(
//             onPressed: onPostJob,
//             icon: const Icon(Icons.add, size: 18),
//             label: const Text("Post Job"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2F6BFF),
//               foregroundColor: Colors.white,
//               elevation: 0,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               textStyle: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AllJobsController.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';


class JobsSectionWidget extends StatefulWidget {
  const JobsSectionWidget({super.key, required List<dynamic> jobs});

  @override
  State<JobsSectionWidget> createState() => _JobsSectionWidgetState();
}

class _JobsSectionWidgetState extends State<JobsSectionWidget> {

  final AdminJobsController controller = Get.find();

  int selectedIndex = 0; // 0=All 1=Open 2=Closed

  List<AdminJobModel> filterJobs(List<AdminJobModel> jobs) {
    if (selectedIndex == 1) {
      return jobs.where((e) => e.status == "open").toList();
    } else if (selectedIndex == 2) {
      return jobs.where((e) => e.status == "closed").toList();
    }
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final filtered = filterJobs(controller.jobs);

      final jobs = filtered.take(3).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// FILTER TABS
          _FilterTabs(
            selectedIndex: selectedIndex,
            onChanged: (i) {
              setState(() {
                selectedIndex = i;
              });
            },
          ),

          const SizedBox(height: 14),

          /// EMPTY STATE
          if (jobs.isEmpty)
            _EmptyJobsCard(
              onPostJob: () {},
            )

          /// JOB LIST
          else
            Column(
              children: jobs.map((job) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _JobCard(job: job),
                );
              }).toList(),
            ),
        ],
      );
    });
  }
}

class _FilterTabs extends StatelessWidget {

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _FilterTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final labels = ["All", "Open", "Closed"];

    return Wrap(
      spacing: 10,
      children: List.generate(labels.length, (i) {

        final active = selectedIndex == i;

        return InkWell(
          onTap: () => onChanged(i),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF2F6BFF) : const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : const Color(0xFF344054),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _JobCard extends StatelessWidget {

  final AdminJobModel job;

  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Text(
            job.title ?? "",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          /// DESCRIPTION
          Text(
            job.description ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 10),

          /// BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// BUDGET
              Text(
                "\$${job.budgetMin ?? ""} - \$${job.budgetMax ?? ""}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F6BFF),
                ),
              ),

              /// STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: job.status == "open"
                      ? const Color(0xFFE6F4EA)
                      : const Color(0xFFFEE4E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job.status?.toUpperCase() ?? "",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: job.status == "open"
                        ? const Color(0xFF027A48)
                        : const Color(0xFFB42318),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _EmptyJobsCard extends StatelessWidget {

  final VoidCallback onPostJob;

  const _EmptyJobsCard({required this.onPostJob});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Column(
        children: [

          const Icon(Icons.work_outline, size: 40),

          const SizedBox(height: 10),

          const Text(
            "No jobs yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Post a job to start hiring top talent.",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: onPostJob,
            icon: const Icon(Icons.add),
            label: const Text("Post Job"),
          )
        ],
      ),
    );
  }
}