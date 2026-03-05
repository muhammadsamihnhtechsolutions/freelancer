// import 'package:flutter/material.dart';

// const int pageSize = 10;

// class AdminJobsPage extends StatefulWidget {
//   const AdminJobsPage({super.key});

//   @override
//   State<AdminJobsPage> createState() => _AdminJobsPageState();
// }

// class _AdminJobsPageState extends State<AdminJobsPage> {
//   List<Job> jobs = [];
//   bool loading = false;

//   String search = "";
//   String statusFilter = "all";
//   int currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     fetchJobs();
//   }

//   Future<void> fetchJobs() async {
//     setState(() => loading = true);

//     // Demo Data
//     jobs = List.generate(
//       27,
//       (i) => Job(
//         id: i + 1,
//         title: "Job Title ${i + 1}",
//         postedBy: "Client ${((i % 5) + 1)}",
//         budgetMin: 50,
//         budgetMax: 200,
//         jobType: (i % 2 == 0) ? "remote" : "onsite",
//         status: (i % 3 == 0)
//             ? "open"
//             : (i % 3 == 1)
//                 ? "closed"
//                 : "pending",
//         proposalsCount: (i % 6),
//       ),
//     );

//     setState(() => loading = false);
//   }

//   List<Job> get filteredJobs {
//     return jobs
//         .where((j) => j.title.toLowerCase().contains(search.toLowerCase()))
//         .where((j) => statusFilter == "all" ? true : j.status == statusFilter)
//         .toList();
//   }

//   int get totalPages {
//     final total = filteredJobs.length;
//     return (total / pageSize).ceil().clamp(1, 999999);
//   }

//   List<Job> get paginatedJobs {
//     final start = (currentPage - 1) * pageSize;
//     final end = (start + pageSize).clamp(0, filteredJobs.length);
//     if (start >= filteredJobs.length) return [];
//     return filteredJobs.sublist(start, end);
//   }

//   Future<void> handleAction(int jobId, String action) async {
//     final idx = jobs.indexWhere((j) => j.id == jobId);
//     if (idx != -1) {
//       setState(() {
//         jobs[idx] = jobs[idx].copyWith(
//           status: action == "approve" ? "open" : "closed",
//         );
//       });
//     }
//   }

//   void _toast(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg)),
//     );
//   }

//   void openEditModal(Job job) {
//     final titleCtrl = TextEditingController(text: job.title);
//     final descCtrl = TextEditingController(text: job.description ?? "");
//     final minCtrl = TextEditingController(text: job.budgetMin.toString());
//     final maxCtrl = TextEditingController(text: job.budgetMax.toString());
//     String type = job.jobType;

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Edit Job", style: TextStyle(fontWeight: FontWeight.w700)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         content: SizedBox(
//           width: 520,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _Input(titleCtrl, hint: "Title"),
//               const SizedBox(height: 10),
//               _Textarea(descCtrl, hint: "Description"),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(child: _Input(minCtrl, hint: "Min", isNumber: true)),
//                   const SizedBox(width: 10),
//                   Expanded(child: _Input(maxCtrl, hint: "Max", isNumber: true)),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: type,
//                 decoration: _fieldDeco("Job Type"),
//                 items: const [
//                   DropdownMenuItem(value: "remote", child: Text("Remote")),
//                   DropdownMenuItem(value: "onsite", child: Text("Onsite")),
//                 ],
//                 onChanged: (v) => type = v ?? "remote",
//               ),
//             ],
//           ),
//         ),
//         actionsPadding: const EdgeInsets.only(bottom: 12, right: 12),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF2F6BFF),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//             onPressed: () {
//               final idx = jobs.indexWhere((j) => j.id == job.id);
//               if (idx != -1) {
//                 setState(() {
//                   jobs[idx] = jobs[idx].copyWith(
//                     title: titleCtrl.text.trim(),
//                     description: descCtrl.text.trim(),
//                     budgetMin: double.tryParse(minCtrl.text) ?? job.budgetMin,
//                     budgetMax: double.tryParse(maxCtrl.text) ?? job.budgetMax,
//                     jobType: type,
//                   );
//                 });
//               }
//               Navigator.pop(context);
//             },
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               child: Text("Save", style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> openProposals(int jobId) async {
//     final proposals = List.generate(
//       (jobId % 4),
//       (i) => Proposal(
//         id: (jobId * 100) + i,
//         freelancerName: "Freelancer ${i + 1}",
//         price: 120 + i * 30,
//         coverLetter: "Hello, I can do this job quickly and professionally.",
//         status: "pending",
//       ),
//     );

//     showDialog(
//       context: context,
//       builder: (_) => _ProposalsDialog(
//         proposals: proposals,
//         onAccept: (pid) async => _toast("Accepted #$pid"),
//         onReject: (pid) async => _toast("Rejected #$pid"),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isWide = MediaQuery.of(context).size.width >= 900;

//     if (currentPage > totalPages) currentPage = totalPages;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("All Jobs",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w800,
//                   )),
//               const SizedBox(height: 14),

//               // Search + Filter Bar
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: [
//                   SizedBox(
//                     width: isWide ? 300 : double.infinity,
//                     child: TextField(
//                       onChanged: (v) => setState(() {
//                         search = v;
//                         currentPage = 1;
//                       }),
//                       decoration: _fieldDeco("Search jobs..."),
//                     ),
//                   ),
//                   SizedBox(
//                     width: isWide ? 180 : double.infinity,
//                     child: DropdownButtonFormField<String>(
//                       value: statusFilter,
//                       decoration: _fieldDeco("Status"),
//                       items: const [
//                         DropdownMenuItem(value: "all", child: Text("All Status")),
//                         DropdownMenuItem(value: "open", child: Text("Open")),
//                         DropdownMenuItem(value: "closed", child: Text("Closed")),
//                         DropdownMenuItem(value: "pending", child: Text("Pending")),
//                       ],
//                       onChanged: (v) => setState(() {
//                         statusFilter = v ?? "all";
//                         currentPage = 1;
//                       }),
//                     ),
//                   ),
//                   OutlinedButton.icon(
//                     onPressed: fetchJobs,
//                     icon: const Icon(Icons.refresh, size: 18),
//                     label: const Text("Refresh"),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // Jobs Table / List
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(color: const Color(0xFFE5E7EB)),
//                   ),
//                   child: loading
//                       ? const Center(child: CircularProgressIndicator())
//                       : isWide
//                           ? _JobsDataTable(
//                               jobs: paginatedJobs,
//                               onApprove: (id) => handleAction(id, "approve"),
//                               onReject: (id) => handleAction(id, "reject"),
//                               onEdit: openEditModal,
//                               onProposals: openProposals,
//                             )
//                           : _JobsList(
//                               jobs: paginatedJobs,
//                               onApprove: (id) => handleAction(id, "approve"),
//                               onReject: (id) => handleAction(id, "reject"),
//                               onEdit: openEditModal,
//                               onProposals: openProposals,
//                             ),
//                 ),
//               ),

//               const SizedBox(height: 14),

//               // Pagination
//               if (totalPages > 1)
//                 Row(
//                   children: List.generate(totalPages, (i) {
//                     final page = i + 1;
//                     final active = page == currentPage;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: InkWell(
//                         onTap: () => setState(() => currentPage = page),
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: active ? const Color(0xFF2F6BFF) : Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: active ? const Color(0xFF2F6BFF) : const Color(0xFFE5E7EB),
//                             ),
//                           ),
//                           child: Text(
//                             "$page",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: active ? Colors.white : const Color(0xFF111827),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /* ------------------ Shared UI ------------------ */
// class _ProposalsDialog extends StatefulWidget {
//   final List<Proposal> proposals;
//   final Future<void> Function(int proposalId) onAccept;
//   final Future<void> Function(int proposalId) onReject;

//   const _ProposalsDialog({
//     required this.proposals,
//     required this.onAccept,
//     required this.onReject,
//     super.key,
//   });

//   @override
//   State<_ProposalsDialog> createState() => _ProposalsDialogState();
// }

// class _ProposalsDialogState extends State<_ProposalsDialog> {
//   late List<Proposal> list;

//   @override
//   void initState() {
//     super.initState();
//     list = [...widget.proposals];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: const Text(
//         "Proposals",
//         style: TextStyle(fontWeight: FontWeight.w800),
//       ),
//       content: SizedBox(
//         width: 600,
//         child: list.isEmpty
//             ? const Text("No proposals yet")
//             : SingleChildScrollView(
//                 child: Column(
//                   children: list.map((p) {
//                     Color statusColor;

//                     switch (p.status) {
//                       case "accepted":
//                         statusColor = const Color(0xFF12B76A);
//                         break;
//                       case "rejected":
//                         statusColor = const Color(0xFFF04438);
//                         break;
//                       default:
//                         statusColor = const Color(0xFF667085);
//                     }

//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: const Color(0xFFE5E7EB)),
//                         color: Colors.white,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${p.freelancerName} • £${p.price}",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w800, fontSize: 15),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(p.coverLetter),
//                           const SizedBox(height: 6),
//                           Row(
//                             children: [
//                               const Text("Status: ",
//                                   style: TextStyle(fontWeight: FontWeight.w600)),
//                               Text(
//                                 p.status.toUpperCase(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w800,
//                                   color: statusColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (p.status == "pending") ...[
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 _MiniBtn(
//                                   text: "Accept",
//                                   bg: const Color(0xFF12B76A),
//                                   onTap: () async {
//                                     await widget.onAccept(p.id);
//                                     setState(() {
//                                       list = list.map((x) => x.id == p.id
//                                           ? x.copyWith(status: "accepted")
//                                           : x).toList();
//                                     });
//                                   },
//                                 ),
//                                 const SizedBox(width: 10),
//                                 _MiniBtn(
//                                   text: "Reject",
//                                   bg: const Color(0xFFF04438),
//                                   onTap: () async {
//                                     await widget.onReject(p.id);
//                                     setState(() {
//                                       list = list.map((x) => x.id == p.id
//                                           ? x.copyWith(status: "rejected")
//                                           : x).toList();
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ]
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("Close"),
//         ),
//       ],
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
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(999),
//         color: bg,
//       ),
//       child: Text(
//         status.toUpperCase(),
//         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: fg),
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
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
//         ),
//       ),
//     );
//   }
// }

// class _JobsDataTable extends StatelessWidget {
//   final List<Job> jobs;
//   final void Function(int id) onApprove;
//   final void Function(int id) onReject;
//   final void Function(Job job) onEdit;
//   final void Function(int jobId) onProposals;

//   const _JobsDataTable({
//     required this.jobs,
//     required this.onApprove,
//     required this.onReject,
//     required this.onEdit,
//     required this.onProposals,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(12),
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         headingRowColor: WidgetStateProperty.all(const Color(0xFFF1F3F7)),
//         headingRowHeight: 48,
//         dataRowMaxHeight: 60,
//         columns: const [
//           DataColumn(label: Text("Title", style: TextStyle(fontWeight: FontWeight.w700))),
//           DataColumn(label: Text("Client")),
//           DataColumn(label: Text("Budget")),
//           DataColumn(label: Text("Type")),
//           DataColumn(label: Text("Status")),
//           DataColumn(label: Text("Proposals")),
//           DataColumn(label: Text("Actions")),
//         ],
//         rows: jobs.map((job) {
//           return DataRow(
//             cells: [
//               DataCell(Text(job.title)),
//               DataCell(Text(job.postedBy)),
//               DataCell(Text("£${job.budgetMin} - £${job.budgetMax}")),
//               DataCell(Text(job.jobType)),
//               DataCell(StatusBadge(status: job.status)),
//               DataCell(Text("${job.proposalsCount}")),
//               DataCell(
//                 Row(
//                   children: [
//                     _MiniBtn(
//                       text: "Approve",
//                       bg: const Color(0xFF12B76A),
//                       onTap: () => onApprove(job.id),
//                     ),
//                     const SizedBox(width: 6),
//                     _MiniBtn(
//                       text: "Reject",
//                       bg: const Color(0xFFF04438),
//                       onTap: () => onReject(job.id),
//                     ),
//                     const SizedBox(width: 6),
//                     _MiniBtn(
//                       text: "Edit",
//                       bg: const Color(0xFFE5E7EB),
//                       fg: Colors.black87,
//                       onTap: () => onEdit(job),
//                     ),
//                     const SizedBox(width: 6),
//                     _MiniBtn(
//                       text: "Proposals",
//                       bg: const Color(0xFF2F6BFF),
//                       onTap: () => onProposals(job.id),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// /* ---------- MOBILE LIST VERSION ---------- */

// class _JobsList extends StatelessWidget {
//   final List<Job> jobs;
//   final void Function(int id) onApprove;
//   final void Function(int id) onReject;
//   final void Function(Job job) onEdit;
//   final void Function(int jobId) onProposals;

//   const _JobsList({
//     required this.jobs,
//     required this.onApprove,
//     required this.onReject,
//     required this.onEdit,
//     required this.onProposals,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (jobs.isEmpty) {
//       return const Center(child: Text("No jobs found"));
//     }

//     return ListView.separated(
//       padding: const EdgeInsets.all(12),
//       itemBuilder: (_, i) {
//         final job = jobs[i];
//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: const Color(0xFFE5E7EB)),
//             color: Colors.white,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       job.title,
//                       style: const TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   StatusBadge(status: job.status),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               Text("Client: ${job.postedBy}"),
//               Text("Budget: £${job.budgetMin} - £${job.budgetMax}"),
//               Text("Type: ${job.jobType}"),
//               Text("Proposals: ${job.proposalsCount}"),
//               const SizedBox(height: 12),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: [
//                   _MiniBtn(
//                     text: "Approve",
//                     bg: const Color(0xFF12B76A),
//                     onTap: () => onApprove(job.id),
//                   ),
//                   _MiniBtn(
//                     text: "Reject",
//                     bg: const Color(0xFFF04438),
//                     onTap: () => onReject(job.id),
//                   ),
//                   _MiniBtn(
//                     text: "Edit",
//                     bg: const Color(0xFFE5E7EB),
//                     fg: Colors.black87,
//                     onTap: () => onEdit(job),
//                   ),
//                   _MiniBtn(
//                     text: "Proposals",
//                     bg: const Color(0xFF2F6BFF),
//                     onTap: () => onProposals(job.id),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//       separatorBuilder: (_, __) => const SizedBox(height: 12),
//       itemCount: jobs.length,
//     );
//   }
// }

// /* ------------------ MODELS ------------------ */

// class Job {
//   final int id;
//   final String title;
//   final String postedBy;
//   final double budgetMin;
//   final double budgetMax;
//   final String jobType;
//   final String status;
//   final int proposalsCount;
//   final String? description;

//   Job({
//     required this.id,
//     required this.title,
//     required this.postedBy,
//     required this.budgetMin,
//     required this.budgetMax,
//     required this.jobType,
//     required this.status,
//     required this.proposalsCount,
//     this.description,
//   });

//   Job copyWith({
//     String? title,
//     String? postedBy,
//     double? budgetMin,
//     double? budgetMax,
//     String? jobType,
//     String? status,
//     int? proposalsCount,
//     String? description,
//   }) {
//     return Job(
//       id: id,
//       title: title ?? this.title,
//       postedBy: postedBy ?? this.postedBy,
//       budgetMin: budgetMin ?? this.budgetMin,
//       budgetMax: budgetMax ?? this.budgetMax,
//       jobType: jobType ?? this.jobType,
//       status: status ?? this.status,
//       proposalsCount: proposalsCount ?? this.proposalsCount,
//       description: description ?? this.description,
//     );
//   }
// }

// class Proposal {
//   final int id;
//   final String freelancerName;
//   final double price;
//   final String coverLetter;
//   final String status;

//   Proposal({
//     required this.id,
//     required this.freelancerName,
//     required this.price,
//     required this.coverLetter,
//     required this.status,
//   });

//   Proposal copyWith({String? status}) {
//     return Proposal(
//       id: id,
//       freelancerName: freelancerName,
//       price: price,
//       coverLetter: coverLetter,
//       status: status ?? this.status,
//     );
//   }
// }class _Textarea extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;

//   const _Textarea(
//     this.controller, {
//     required this.hint,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       minLines: 3,
//       maxLines: 6,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF2F6BFF)),
//         ),
//       ),
//     );
//   }
// }
// class _Input extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;
//   final bool isNumber;

//   const _Input(
//     this.controller, {
//     required this.hint,
//     this.isNumber = false,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF2F6BFF)),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AllJobsController.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
import 'package:get/get.dart';


class AdminJobsPage extends StatelessWidget {
  AdminJobsPage({super.key});

  final controller = Get.put(AdminJobsController());

  final RxString search = "".obs;
  final RxString statusFilter = "all".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "All Jobs",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),

              /// SEARCH + FILTER + REFRESH
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (v) => search.value = v,
                      decoration: _fieldDeco("Search jobs..."),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Obx(() => DropdownButton<String>(
                        value: statusFilter.value,
                        items: const [
                          DropdownMenuItem(value: "all", child: Text("All")),
                          DropdownMenuItem(value: "open", child: Text("Open")),
                          DropdownMenuItem(value: "closed", child: Text("Closed")),
                          DropdownMenuItem(value: "pending", child: Text("Pending")),
                        ],
                        onChanged: (v) => statusFilter.value = v ?? "all",
                      )),

                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    onPressed: controller.fetchJobs,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  ),
                ],
              ),

              const SizedBox(height: 16),

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
                    return const Center(child: Text("No jobs found"));
                  }

                  return ListView.builder(
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        color: Colors.white,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// TITLE
          Text(
            job.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          /// CLIENT
          Text("Client: ${job.clientName}"),

          /// BUDGET
          Text("Budget: £${job.budgetMin} - £${job.budgetMax}"),

          /// TYPE
          Text("Type: ${job.jobType}"),

          /// STATUS
          StatusBadge(status: job.status),

          const SizedBox(height: 12),

          /// ACTION BUTTONS
          Wrap(
            spacing: 8,
            runSpacing: 8,

            children: [

              /// APPROVE
              _MiniBtn(
                text: "Approve",
                bg: const Color(0xFF12B76A),
                onTap: () => c.approveJob(job.id)
              ),

              /// REJECT / CLOSE
              _MiniBtn(
                text: "Reject",
                bg: const Color(0xFFF04438),
                onTap: () => c.rejectJob(job.id),
              ),

              /// PROPOSALS
              _MiniBtn(
                text: "Proposals (${job.proposalsCount})",
                bg: const Color(0xFF2F6BFF),
                onTap: () {

                  Get.snackbar(
                    "Proposals",
                    "Job: ${job.title}",
                  );

                },
              ),

            ],
          )
        ],
      ),
    );
  }
}

// class _JobCard extends StatelessWidget {
//   final AdminJobModel job;
//   const _JobCard({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.find<AdminJobsController>();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(job.title,
//               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
//           const SizedBox(height: 6),
//           Text("Client: ${job.clientName}"),
//           Text("Budget: £${job.budgetMin} - £${job.budgetMax}"),
//           Text("Type: ${job.jobType}"),
//           StatusBadge(status: job.status),
//           const SizedBox(height: 12),

//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: [
//               _MiniBtn(
//                 text: "Approve",
//                 bg: const Color(0xFF12B76A),
//                 onTap: () => c.approveJob(job.id),
//               ),
//               _MiniBtn(
//                 text: "Reject",
//                 bg: const Color(0xFFF04438),
//                 onTap: () => c.rejectJob(job.id),
//               ),
//               _MiniBtn(
//                 text: "Proposals (${job.proposalsCount})",
//                 bg: const Color(0xFF2F6BFF),
//                 onTap: () {
//                   Get.snackbar("Proposals", "Job: ${job.title}");
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case "open":
        bg = const Color(0xFFD1FADF);
        fg = const Color(0xFF027A48);
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
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bg,
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class _MiniBtn extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _MiniBtn({
    required this.text,
    required this.bg,
    required this.onTap,
    this.fg = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: Text(
          text,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w700,
            fontSize: 12,
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