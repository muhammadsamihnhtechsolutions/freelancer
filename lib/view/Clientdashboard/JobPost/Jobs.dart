

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalPage.dart';
// import 'package:freelancer_app/view/Clientdashboard/JobPost/AllJobsController.dart';
// import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
// import 'package:freelancer_app/view/Clientdashboard/PostJobPage.dart';
// import 'package:get/get.dart';



// import 'package:freelancer_app/theme/AppColors.dart';



// class AdminJobsPage extends StatelessWidget {
//   AdminJobsPage({super.key});

//   final controller = Get.put(AdminJobsController());
//   final RxString search = "".obs;
//   final RxString statusFilter = "all".obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               /// HEADER
//               const Text(
//                 "All Jobs",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               /// SEARCH + FILTER
//               Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.04),
//                       blurRadius: 12,
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   children: [

//                     /// Search
//                     TextField(
//                       onChanged: (v) => search.value = v,
//                       decoration: InputDecoration(
//                         hintText: "Search jobs or clients...",
//                         prefixIcon: const Icon(Icons.search),
//                         filled: true,
//                         fillColor: const Color(0xFFF4F6FA),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 14),

//                     Row(
//                       children: [

//                         /// Status Dropdown
//                         Expanded(
//                           child: Obx(() => Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFF4F6FA),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: DropdownButton<String>(
//                                   value: statusFilter.value,
//                                   isExpanded: true,
//                                   underline: const SizedBox(),
//                                   items: const [
//                                     DropdownMenuItem(value: "all", child: Text("All")),
//                                     DropdownMenuItem(value: "open", child: Text("Open")),
//                                     DropdownMenuItem(value: "closed", child: Text("Closed")),
//                                     DropdownMenuItem(value: "pending", child: Text("Pending")),
//                                   ],
//                                   onChanged: (v) => statusFilter.value = v ?? "all",
//                                 ),
//                               )),
//                         ),

//                         const SizedBox(width: 12),

//                         /// Refresh
//                         InkWell(
//                           onTap: controller.fetchJobs,
//                           borderRadius: BorderRadius.circular(12),
//                           child: Container(
//                             height: 48,
//                             width: 48,
//                             decoration: BoxDecoration(
//                               gradient: AppColors.primaryGradient,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(Icons.refresh, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               /// LIST
//               Expanded(
//                 child: Obx(() {
//                   if (controller.loading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final filtered = controller.jobs.where((job) {
//                     final s = search.value.toLowerCase().trim();
//                     final matchSearch = s.isEmpty
//                         ? true
//                         : job.title.toLowerCase().contains(s) ||
//                             job.clientName.toLowerCase().contains(s);

//                     final f = statusFilter.value;
//                     final matchStatus = (f == "all") ? true : job.status == f;

//                     return matchSearch && matchStatus;
//                   }).toList();

//                   if (filtered.isEmpty) {
//                     return const Center(child: Text("No jobs found"));
//                   }

//                   return ListView.builder(
//                     itemCount: filtered.length,
//                     itemBuilder: (_, i) => _JobCard(job: filtered[i]),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// class _JobCard extends StatelessWidget {
//   final AdminJobModel job;
//   const _JobCard({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.find<AdminJobsController>();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 15,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           Text(
//             job.title,
//             style: const TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 17,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text("Client: ${job.clientName}",
//               style: const TextStyle(color: Colors.grey)),

//           const SizedBox(height: 4),

//           Text("Budget: £${job.budgetMin} - £${job.budgetMax}",
//               style: const TextStyle(color: Colors.grey)),

//           const SizedBox(height: 4),

//           Text("Type: ${job.jobType}",
//               style: const TextStyle(color: Colors.grey)),

//           StatusBadge(status: job.status),

//           const SizedBox(height: 16),

//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: [

//               _MiniBtn(
//                 text: "Edit",
//                 bg: const Color(0xFF12B76A),
//                 onTap: () {
//                   Get.to(() => PostJob(), arguments: job);
//                 },
//               ),

//               _MiniBtn(
//                 text: "Close",
//                 bg: const Color(0xFFF04438),
//                 onTap: () => c.closeJob(job.id),
//               ),

//               _MiniBtn(
//                 text: "Proposals (${job.proposalsCount})",
//                 bg: AppColors.primaryStart,
//                 onTap: () {
//                   Get.to(() => const ClientProposalPage(),
//                       arguments: job.id);
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class StatusBadge extends StatelessWidget {
//   final String status;
//   const StatusBadge({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     Color bg;
//     Color fg;

//     switch (status) {
//       case "open":
//         bg = const Color(0xFFD1FADF);
//         fg = const Color(0xFF027A48);
//         break;
//       case "closed":
//         bg = const Color(0xFFFEE4E2);
//         fg = const Color(0xFFB42318);
//         break;
//       default:
//         bg = const Color(0xFFFEF0C7);
//         fg = const Color(0xFFB54708);
//     }

//     return Container(
//       margin: const EdgeInsets.only(top: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(999),
//         color: bg,
//       ),
//       child: Text(
//         status.toUpperCase(),
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w800,
//           color: fg,
//         ),
//       ),
//     );
//   }
// }

// class _MiniBtn extends StatelessWidget {
//   final String text;
//   final Color bg;
//   final Color fg;
//   final VoidCallback onTap;

//   const _MiniBtn({
//     required this.text,
//     required this.bg,
//     required this.onTap,
//     this.fg = Colors.white,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(8),
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: fg,
//             fontWeight: FontWeight.w700,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

// InputDecoration _fieldDeco(String hint) {
//   return InputDecoration(
//     hintText: hint,
//     filled: true,
//     fillColor: Colors.white,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: const BorderSide(color: Color(0xFF2F6BFF), width: 1.5),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalPage.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AllJobsController.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
import 'package:freelancer_app/view/Clientdashboard/PostJobPage.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/theme/AppColors.dart';

class AdminJobsPage extends StatelessWidget {
  AdminJobsPage({super.key});

  final controller = Get.put(AdminJobsController());
  final RxString search = "".obs;
  final RxString statusFilter = "all".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "All Jobs",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF101828),
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Manage, track and control posted jobs beautifully",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF667085),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              /// SEARCH + FILTER
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9EEF5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (v) => search.value = v,
                      decoration: InputDecoration(
                        hintText: "Search jobs or clients...",
                        hintStyle: const TextStyle(
                          color: Color(0xFF98A2B3),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF667085),
                          size: 22,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => Container(
                              height: 54,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFE6EBF3),
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: statusFilter.value,
                                isExpanded: true,
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF667085),
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF344054),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: "all",
                                    child: Text("All Status"),
                                  ),
                                  DropdownMenuItem(
                                    value: "open",
                                    child: Text("Open"),
                                  ),
                                  DropdownMenuItem(
                                    value: "closed",
                                    child: Text("Closed"),
                                  ),
                                  DropdownMenuItem(
                                    value: "pending",
                                    child: Text("Pending"),
                                  ),
                                ],
                                onChanged: (v) =>
                                    statusFilter.value = v ?? "all",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                       InkWell(
  onTap: controller.fetchJobs,
  borderRadius: BorderRadius.circular(16),
  child: Container(
    height: 54,
    width: 54,
    decoration: BoxDecoration(
      color: const Color(0xFF175CD3),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF175CD3).withOpacity(.35),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Icon(
      Icons.refresh_rounded,
      color: Colors.white,
    ),
  ),
),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// LIST
              Expanded(
                child: Obx(() {
                  if (controller.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filtered = controller.jobs.where((job) {
                    final s = search.value.toLowerCase().trim();
                    final matchSearch = s.isEmpty
                        ? true
                        : job.title.toLowerCase().contains(s) ||
                            job.clientName.toLowerCase().contains(s);

                    final f = statusFilter.value;
                    final matchStatus = (f == "all") ? true : job.status == f;

                    return matchSearch && matchStatus;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 26,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No jobs found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF344054),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Try changing search or status filter",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF667085),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => _JobCard(job: filtered[i]),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final AdminJobModel job;
  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdminJobsController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE7ECF3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: Color(0xFF101828),
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                StatusBadge(status: job.status),
              ],
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFD),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoText(
                    label: "Client",
                    value: job.clientName,
                  ),
                  const SizedBox(height: 8),
                  _InfoText(
                    label: "Budget",
                    value: "£${job.budgetMin} - £${job.budgetMax}",
                  ),
                  const SizedBox(height: 8),
                  _InfoText(
                    label: "Type",
                    value: job.jobType,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ACTIONS
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ActionBtn(
                  text: "Edit",
                  showIcon: true,
                  icon: Icons.edit,
                  iconSize: 14,
                  bg: const Color(0xFF175CD3),
                  textColor: Colors.white,
                  onTap: () {
                    Get.to(() => PostJob(), arguments: job);
                  },
                ),
                _ActionBtn(
                  text: "Close",
                  showIcon: true,
                  icon: Icons.close,
                  iconSize: 15,
                  bg: const Color(0xFFD92D20),
                  textColor: Colors.white,
                  onTap: () => c.closeJob(job.id),
                ),
                _ActionBtn(
                  text: "Proposal",
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryStart,
                      AppColors.primaryEnd,
                    ],
                  ),
                  textColor: Colors.white,
                  trailingCount: job.proposalsCount.toString(),
                  onTap: () {
                    Get.to(
                      () => const ClientProposalPage(),
                      arguments: job.id,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13.5,
          height: 1.45,
        ),
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              color: Color(0xFF667085),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Color(0xFF101828),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case "open":
        bg = const Color(0xFFDDF7E7);
        fg = const Color(0xFF067647);
        break;
      case "closed":
        bg = const Color(0xFFFEE4E2);
        fg = const Color(0xFFB42318);
        break;
      default:
        bg = const Color(0xFFFEF0C7);
        fg = const Color(0xFFB54708);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bg,
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          color: fg,
          letterSpacing: .3,
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String text;
  final bool showIcon;
  final IconData? icon;
  final double iconSize;
  final Color? bg;
  final Gradient? gradient;
  final Color textColor;
  final String? trailingCount;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.text,
    required this.onTap,
    this.showIcon = false,
    this.icon,
    this.iconSize = 15,
    this.bg,
    this.gradient,
    required this.textColor,
    this.trailingCount,
  });

  @override
  Widget build(BuildContext context) {
    final Color shadowColor = bg ?? AppColors.primaryStart;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          decoration: BoxDecoration(
            color: gradient == null ? bg : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(.18),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon && icon != null) ...[
                Icon(icon, size: iconSize, color: textColor),
                const SizedBox(width: 6),
              ],
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.8,
                ),
              ),
              if (trailingCount != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    trailingCount!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _fieldDeco(String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF2F6BFF), width: 1.5),
    ),
  );
}