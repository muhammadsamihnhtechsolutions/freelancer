

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/StartWorkController.dart';
// import 'package:get/get.dart';

// class ViewProposal extends StatefulWidget {
//   const ViewProposal({super.key});

//   @override
//   State<ViewProposal> createState() => _ViewProposalState();
// }

// class _ViewProposalState extends State<ViewProposal> {
//   late final dynamic proposal;
//   late final StartWorkController controller;

//   bool hasStartedWork = false;

//   @override
//   void initState() {
//     super.initState();
//     proposal = Get.arguments;
//     controller = Get.put(StartWorkController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String status = proposal.status.toString().trim().toLowerCase();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),

//       /// ===============================
//       /// APP BAR (Back Arrow + Title)
//       /// ===============================
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded,
//               color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: const Text(
//           "View Proposal",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: Column(
//           children: [
//             /// ===============================
//             /// TOP PROFILE SECTION
//             /// ===============================
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: Colors.blue,
//                     child: Text(
//                       proposal.jobTitle[0].toUpperCase(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           proposal.jobTitle,
//                           style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           "freelancer@email.com",
//                           style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 14, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(.15),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       proposal.status.toUpperCase(),
//                       style: const TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             /// ===============================
//             /// BID + DELIVERY SECTION
//             /// ===============================
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _infoCard(
//                       icon: Icons.attach_money,
//                       title: "Bid Amount",
//                       value: "£${proposal.price}",
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: _infoCard(
//                       icon: Icons.access_time,
//                       title: "Delivery",
//                       value: "${proposal.days} days",
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// ===============================
//             /// COVER LETTER
//             /// ===============================
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.description_outlined,
//                             size: 18,
//                             color: Colors.black54),
//                         SizedBox(width: 8),
//                         Text(
//                           "Cover Letter",
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF4F6FA),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         "Cover letter content goes here...",
//                         style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black87),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const Spacer(),

//             /// ===============================
//             /// BUTTON FLOW LOGIC
//             /// ===============================
//             if (status == "accepted")
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Obx(() {
//                   final bool isLoading =
//                       controller.isStarting.value || controller.isSubmitting.value;

//                   return Align(
//                     alignment: Alignment.centerLeft,
//                     child: ElevatedButton(
//                       onPressed: isLoading
//                           ? null
//                           : () async {
//                               if (!hasStartedWork) {
//                                 final bool success =
//                                     await controller.startWork(proposal.jobId);

//                                 if (success) {
//                                   setState(() {
//                                     hasStartedWork = true;
//                                   });
//                                 }
//                               } else {
//                                 final bool success =
//                                     await controller.submitWork(proposal.jobId);

//                                 if (success) {
//                                   /// yahan agar chaho to back ya refresh kara sakte ho
//                                   /// Get.back();

//                                   Get.snackbar(
//                                     "Success",
//                                     "Work flow completed successfully",
//                                     snackPosition: SnackPosition.BOTTOM,
//                                   );
//                                 }
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4A7CFF),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: isLoading
//                           ? const SizedBox(
//                               height: 18,
//                               width: 18,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : Text(
//                               hasStartedWork ? "Submit" : "Start Work",
//                               style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                     ),
//                   );
//                 }),
//               ),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 18, color: Colors.black54),
//               const SizedBox(width: 6),
//               Text(
//                 title,
//                 style: const TextStyle(
//                     fontSize: 13,
//                     color: Colors.black54),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             value,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/StartWorkController.dart';
// import 'package:get/get.dart';

// class ViewProposal extends StatefulWidget {
//   const ViewProposal({super.key});

//   @override
//   State<ViewProposal> createState() => _ViewProposalState();
// }

// class _ViewProposalState extends State<ViewProposal> {
//   late final dynamic proposal;
//   late final StartWorkController controller;

//   bool hasStartedWork = false;

//   /// local instant UI state
//   late String currentStatus;

//   /// review UI state
//   int selectedRating = 0;
//   final TextEditingController reviewCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     proposal = Get.arguments;

//     controller = Get.isRegistered<StartWorkController>()
//         ? Get.find<StartWorkController>()
//         : Get.put(StartWorkController());

//     currentStatus = proposal.status.toString().trim().toLowerCase();

//     /// agar backend se kabhi started/submitted status aaye to yahan handle ho sakta hai
//     hasStartedWork = currentStatus == "started" || currentStatus == "submitted";

//     print("📄 VIEW PROPOSAL OPEN");
//     print("➡️ INITIAL STATUS => $currentStatus");
//     print("➡️ JOB ID => ${proposal.jobId}");
//   }

//   @override
//   void dispose() {
//     reviewCtrl.dispose();
//     super.dispose();
//   }

//   Color get _statusBgColor {
//     switch (currentStatus) {
//       case "accepted":
//         return Colors.green.withOpacity(.15);
//       case "completed":
//         return Colors.blue.withOpacity(.15);
//       case "submitted":
//         return Colors.orange.withOpacity(.15);
//       default:
//         return Colors.grey.withOpacity(.15);
//     }
//   }

//   Color get _statusTextColor {
//     switch (currentStatus) {
//       case "accepted":
//         return Colors.green;
//       case "completed":
//         return Colors.blue;
//       case "submitted":
//         return Colors.orange;
//       default:
//         return Colors.black54;
//     }
//   }

//   String get _statusLabel {
//     if (currentStatus == "completed") return "COMPLETED";
//     if (currentStatus == "submitted") return "SUBMITTED";
//     if (currentStatus == "accepted") return "ACCEPTED";
//     return currentStatus.toUpperCase();
//   }

//   Widget _buildReviewSection() {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Reviews",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 18),

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF9FAFB),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: const Color(0xFFE5E7EB)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Leave a Review",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 14),

//                 Row(
//                   children: List.generate(5, (index) {
//                     final starIndex = index + 1;
//                     final isSelected = selectedRating >= starIndex;

//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedRating = starIndex;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 4),
//                         child: Icon(
//                           isSelected ? Icons.star_rounded : Icons.star_border_rounded,
//                           size: 30,
//                           color: isSelected ? const Color(0xFFFFC107) : const Color(0xFFD1D5DB),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),

//                 const SizedBox(height: 14),

//                 TextField(
//                   controller: reviewCtrl,
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                     hintText: "Write your review",
//                     contentPadding: const EdgeInsets.all(14),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6366F1)),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.4),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 ElevatedButton(
//                   onPressed: () {
//                     Get.snackbar(
//                       "Review UI Ready",
//                       "API aane par review submit connect kar denge",
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4F46E5),
//                     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit Review",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 28),

//           const Center(
//             child: Text(
//               "No reviews yet. Be the first one.",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _handleWorkFlow() async {
//     final bool isLoading =
//         controller.isStarting.value || controller.isSubmitting.value;

//     if (isLoading) return;

//     if (!hasStartedWork) {
//       final bool success = await controller.startWork(proposal.jobId);

//       if (success) {
//         setState(() {
//           hasStartedWork = true;
//           /// status accepted hi rehne do, kyun ke tumhari desired UI me
//           /// accepted ke andar hi next step Submit aana hai
//           currentStatus = "accepted";
//         });

//         Get.snackbar(
//           "Success",
//           "Work started successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } else {
//       final bool success = await controller.submitWork(proposal.jobId);

//       if (success) {
//         setState(() {
//           /// yahan foran local UI update hogi
//           currentStatus = "completed";
//           hasStartedWork = true;
//         });

//         Get.snackbar(
//           "Success",
//           "Work submitted successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool showWorkButton = currentStatus == "accepted";
//     final bool showReviewForm = currentStatus == "completed";

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: const Text(
//           "View Proposal",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: Column(
//           children: [
//             /// TOP PROFILE SECTION
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: Colors.blue,
//                     child: Text(
//                       proposal.jobTitle[0].toUpperCase(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           proposal.jobTitle,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           "freelancer@email.com",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: _statusBgColor,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       _statusLabel,
//                       style: TextStyle(
//                         color: _statusTextColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             /// main content scrollable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     /// BID + DELIVERY SECTION
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _infoCard(
//                               icon: Icons.attach_money,
//                               title: "Bid Amount",
//                               value: "£${proposal.price}",
//                             ),
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: _infoCard(
//                               icon: Icons.access_time,
//                               title: "Delivery",
//                               value: "${proposal.days} days",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// COVER LETTER
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(.05),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             )
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Row(
//                               children: [
//                                 Icon(
//                                   Icons.description_outlined,
//                                   size: 18,
//                                   color: Colors.black54,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "Cover Letter",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFF4F6FA),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: const Text(
//                                 "Cover letter content goes here...",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     if (showReviewForm) _buildReviewSection(),

//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),

//             /// BUTTON FLOW
//             if (showWorkButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Obx(() {
//                   final bool isLoading =
//                       controller.isStarting.value || controller.isSubmitting.value;

//                   return Align(
//                     alignment: Alignment.centerLeft,
//                     child: ElevatedButton(
//                       onPressed: isLoading ? null : _handleWorkFlow,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4A7CFF),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 14,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: isLoading
//                           ? const SizedBox(
//                               height: 18,
//                               width: 18,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : Text(
//                               hasStartedWork ? "Submit" : "Start Work",
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                     ),
//                   );
//                 }),
//               ),

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 18, color: Colors.black54),
//               const SizedBox(width: 6),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:freelancer_app/FreelancerDashboard/myperposal/StartWorkController.dart';
// import 'package:freelancer_app/FreelancerReviewsubmitModel/FreelancerSubmitReviewController.dart';
// import 'package:get/get.dart';

// class ViewProposal extends StatefulWidget {
//   const ViewProposal({super.key});

//   @override
//   State<ViewProposal> createState() => _ViewProposalState();
// }

// class _ViewProposalState extends State<ViewProposal> {
//   late final dynamic proposal;
//   late final StartWorkController controller;
//   late final FreelancerSubmitReviewController reviewController;

//   bool hasStartedWork = false;

//   /// local instant UI state
//   late String currentStatus;

//   @override
//   void initState() {
//     super.initState();
//     proposal = Get.arguments;

//     controller = Get.isRegistered<StartWorkController>()
//         ? Get.find<StartWorkController>()
//         : Get.put(StartWorkController());

//     reviewController = Get.isRegistered<FreelancerSubmitReviewController>()
//         ? Get.find<FreelancerSubmitReviewController>()
//         : Get.put(FreelancerSubmitReviewController());

//     currentStatus = proposal.status.toString().trim().toLowerCase();

//     /// agar backend se kabhi started/submitted status aaye to yahan handle ho sakta hai
//     hasStartedWork = currentStatus == "started" || currentStatus == "submitted";

//     print("📄 VIEW PROPOSAL OPEN");
//     print("➡️ INITIAL STATUS => $currentStatus");
//     print("➡️ JOB ID => ${proposal.jobId}");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Color get _statusBgColor {
//     switch (currentStatus) {
//       case "accepted":
//         return Colors.green.withOpacity(.15);
//       case "completed":
//         return Colors.blue.withOpacity(.15);
//       case "submitted":
//         return Colors.orange.withOpacity(.15);
//       default:
//         return Colors.grey.withOpacity(.15);
//     }
//   }

//   Color get _statusTextColor {
//     switch (currentStatus) {
//       case "accepted":
//         return Colors.green;
//       case "completed":
//         return Colors.blue;
//       case "submitted":
//         return Colors.orange;
//       default:
//         return Colors.black54;
//     }
//   }

//   String get _statusLabel {
//     if (currentStatus == "completed") return "COMPLETED";
//     if (currentStatus == "submitted") return "SUBMITTED";
//     if (currentStatus == "accepted") return "ACCEPTED";
//     return currentStatus.toUpperCase();
//   }
//  String _resolveRevieweeId() {
//   if (proposal.clientId.toString().trim().isNotEmpty) {
//     print("✅ REVIEWEE ID (clientId) → ${proposal.clientId}");
//     return proposal.clientId.toString();
//   }

//   if (proposal.userId.toString().trim().isNotEmpty) {
//     print("✅ REVIEWEE ID (userId) → ${proposal.userId}");
//     return proposal.userId.toString();
//   }

//   print("❌ CLIENT/USER ID NOT FOUND IN PROPOSAL");
//   return "";
// }



//   Widget _buildReviewSection() {
//     return Obx(() {
//       final submittedData = reviewController.submittedReview.value;
//       final bool hasSubmitted = reviewController.hasSubmittedReview.value;

//       return Container(
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(horizontal: 16),
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Reviews",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 18),

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF9FAFB),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: const Color(0xFFE5E7EB)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Leave a Review",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 14),

//                   Row(
//                     children: List.generate(5, (index) {
//                       final starIndex = index + 1;
//                       final isSelected =
//                           (hasSubmitted
//                                   ? (submittedData?.rating ?? 0)
//                                   : reviewController.selectedRating.value) >=
//                               starIndex;

//                       return GestureDetector(
//                         onTap: hasSubmitted
//                             ? null
//                             : () {
//                                 reviewController.setRating(starIndex);
//                               },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 4),
//                           child: Icon(
//                             isSelected
//                                 ? Icons.star_rounded
//                                 : Icons.star_border_rounded,
//                             size: 30,
//                             color: isSelected
//                                 ? const Color(0xFFFFC107)
//                                 : const Color(0xFFD1D5DB),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),

//                   const SizedBox(height: 14),

//                   TextField(
//                     controller: reviewController.reviewCtrl,
//                     maxLines: 4,
//                     readOnly: hasSubmitted,
//                     decoration: InputDecoration(
//                       hintText: "Write your review",
//                       contentPadding: const EdgeInsets.all(14),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(color: Color(0xFF6366F1)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF6366F1),
//                           width: 1.4,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   if (!hasSubmitted)
//                     ElevatedButton(
//                       onPressed: reviewController.isSubmittingReview.value
//                           ? null
//                           : () async {
//                               final revieweeId = _resolveRevieweeId();

//                               if (revieweeId.isEmpty) {
//                                 Get.snackbar(
//                                   "Error",
//                                   "Reviewee id not found",
//                                   snackPosition: SnackPosition.BOTTOM,
//                                 );
//                                 return;
//                               }

//                             final bool success = await reviewController.submitReview(
//   jobId: proposal.jobId.toString(),
// );

//                               if (success) {
//                                 setState(() {});
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4F46E5),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 18,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: reviewController.isSubmittingReview.value
//                           ? const SizedBox(
//                               height: 18,
//                               width: 18,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : const Text(
//                               "Submit Review",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),

//                   if (hasSubmitted) ...[
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Review submitted successfully",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.green,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             if (!hasSubmitted)
//               const Center(
//                 child: Text(
//                   "No reviews yet. Be the first one.",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black38,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       );
//     });
//   }

//   Future<void> _handleWorkFlow() async {
//     final bool isLoading =
//         controller.isStarting.value || controller.isSubmitting.value;

//     if (isLoading) return;

//     if (!hasStartedWork) {
//       final bool success = await controller.startWork(proposal.jobId);

//       if (success) {
//         setState(() {
//           hasStartedWork = true;
//           /// status accepted hi rehne do, kyun ke tumhari desired UI me
//           /// accepted ke andar hi next step Submit aana hai
//           currentStatus = "accepted";
//         });

//         Get.snackbar(
//           "Success",
//           "Work started successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } else {
//       final bool success = await controller.submitWork(proposal.jobId);

//       if (success) {
//         setState(() {
//           /// yahan foran local UI update hogi
//           currentStatus = "completed";
//           hasStartedWork = true;
//         });

//         reviewController.clearForm();

//         Get.snackbar(
//           "Success",
//           "Work submitted successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool showWorkButton = currentStatus == "accepted";
//     final bool showReviewForm = currentStatus == "completed";

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: const Text(
//           "View Proposal",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: Column(
//           children: [
//             /// TOP PROFILE SECTION
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: Colors.blue,
//                     child: Text(
//                       proposal.jobTitle[0].toUpperCase(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           proposal.jobTitle,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           "freelancer@email.com",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: _statusBgColor,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       _statusLabel,
//                       style: TextStyle(
//                         color: _statusTextColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             /// main content scrollable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     /// BID + DELIVERY SECTION
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _infoCard(
//                               icon: Icons.attach_money,
//                               title: "Bid Amount",
//                               value: "£${proposal.price}",
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                         Expanded(
//   child: _infoCard(
//     icon: Icons.schedule,
//     title: "Delivery Time",
//     value: "${proposal.days} days",
//   ),
// ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     /// COVER LETTER / DESCRIPTION
//                     Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.symmetric(horizontal: 16),
//                       padding: const EdgeInsets.all(18),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Cover Letter",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             proposal.coverLetter ?? "No cover letter provided.",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               height: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     /// REVIEWS SECTION
//                     if (showReviewForm) _buildReviewSection(),

//                     const SizedBox(height: 120),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       /// bottom action area
//       bottomNavigationBar: showWorkButton
//           ? Obx(() {
//               final bool isLoading =
//                   controller.isStarting.value || controller.isSubmitting.value;

//               final String btnText = !hasStartedWork ? "Start Work" : "Submit Work";

//               return SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//                   child: SizedBox(
//                     height: 54,
//                     child: ElevatedButton(
//                       onPressed: isLoading ? null : _handleWorkFlow,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4F46E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: isLoading
//                           ? const SizedBox(
//                               height: 22,
//                               width: 22,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.5,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : Text(
//                               btnText,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               );
//             })
//           : null,
//     );
//   }

//   Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 42,
//             width: 42,
//             decoration: BoxDecoration(
//               color: const Color(0xFFEEF2FF),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: const Color(0xFF4F46E5),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/StartWorkController.dart';
import 'package:freelancer_app/FreelancerReviewsubmitModel/FreelancerSubmitReviewController.dart';
import 'package:get/get.dart';

class ViewProposal extends StatefulWidget {
  const ViewProposal({super.key});

  @override
  State<ViewProposal> createState() => _ViewProposalState();
}

class _ViewProposalState extends State<ViewProposal> {
  late final dynamic proposal;
  late final StartWorkController controller;
  late final FreelancerSubmitReviewController reviewController;

  bool hasStartedWork = false;

  /// local instant UI state
  late String currentStatus;
@override
void initState() {
  super.initState();
  proposal = Get.arguments;

  controller = Get.isRegistered<StartWorkController>()
      ? Get.find<StartWorkController>()
      : Get.put(StartWorkController());

  reviewController = Get.isRegistered<FreelancerSubmitReviewController>()
      ? Get.find<FreelancerSubmitReviewController>()
      : Get.put(FreelancerSubmitReviewController());

  currentStatus = proposal.status.toString().trim().toLowerCase();

  hasStartedWork = currentStatus == "started" || currentStatus == "submitted";

  print("📄 VIEW PROPOSAL OPEN");
  print("➡️ INITIAL STATUS => $currentStatus");
  print("➡️ JOB ID => ${proposal.jobId}");

  if (currentStatus == "completed") {
    reviewController.loadSubmittedReview(jobId: proposal.jobId.toString());
  }
}
  @override
  void dispose() {
    super.dispose();
  }

  Color get _statusBgColor {
    switch (currentStatus) {
      case "accepted":
        return Colors.green.withOpacity(.15);
      case "completed":
        return Colors.blue.withOpacity(.15);
      case "submitted":
        return Colors.orange.withOpacity(.15);
      default:
        return Colors.grey.withOpacity(.15);
    }
  }

  Color get _statusTextColor {
    switch (currentStatus) {
      case "accepted":
        return Colors.green;
      case "completed":
        return Colors.blue;
      case "submitted":
        return Colors.orange;
      default:
        return Colors.black54;
    }
  }

  String get _statusLabel {
    if (currentStatus == "completed") return "COMPLETED";
    if (currentStatus == "submitted") return "SUBMITTED";
    if (currentStatus == "accepted") return "ACCEPTED";
    return currentStatus.toUpperCase();
  }

  Widget _buildReviewSection() {
    return Obx(() {
      final submittedData = reviewController.submittedReview.value;
      final bool hasSubmitted = reviewController.hasSubmittedReview.value;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Leave a Review",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      final isSelected =
                          (hasSubmitted
                                  ? (submittedData?.rating ?? 0)
                                  : reviewController.selectedRating.value) >=
                              starIndex;

                      return GestureDetector(
                        onTap: hasSubmitted
                            ? null
                            : () {
                                reviewController.setRating(starIndex);
                              },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            isSelected
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 30,
                            color: isSelected
                                ? const Color(0xFFFFC107)
                                : const Color(0xFFD1D5DB),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: reviewController.reviewCtrl,
                    maxLines: 4,
                    readOnly: hasSubmitted,
                    decoration: InputDecoration(
                      hintText: "Write your review",
                      contentPadding: const EdgeInsets.all(14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF6366F1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF6366F1),
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  if (!hasSubmitted)
                    ElevatedButton(
                      onPressed: reviewController.isSubmittingReview.value
                          ? null
                          : () async {
                              final bool success =
                                  await reviewController.submitReview(
                                jobId: proposal.jobId.toString(),
                              );

                              if (success) {
                                setState(() {});
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: reviewController.isSubmittingReview.value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Submit Review",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),

                  if (hasSubmitted) ...[
                    const SizedBox(height: 10),
                    const Text(
                      "Review submitted successfully",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 28),

            if (!hasSubmitted)
              const Center(
                child: Text(
                  "No reviews yet. Be the first one.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Future<void> _handleWorkFlow() async {
    final bool isLoading =
        controller.isStarting.value || controller.isSubmitting.value;

    if (isLoading) return;

    if (!hasStartedWork) {
      final bool success = await controller.startWork(proposal.jobId);

      if (success) {
        setState(() {
          hasStartedWork = true;
          /// status accepted hi rehne do, kyun ke tumhari desired UI me
          /// accepted ke andar hi next step Submit aana hai
          currentStatus = "accepted";
        });

        Get.snackbar(
          "Success",
          "Work started successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      final bool success = await controller.submitWork(proposal.jobId);

      if (success) {
        setState(() {
          /// yahan foran local UI update hogi
          currentStatus = "completed";
          hasStartedWork = true;
        });

        reviewController.clearForm();

        Get.snackbar(
          "Success",
          "Work submitted successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showWorkButton = currentStatus == "accepted";
    final bool showReviewForm = currentStatus == "completed";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "View Proposal",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// TOP PROFILE SECTION
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue,
                    child: Text(
                      proposal.jobTitle[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proposal.jobTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "freelancer@email.com",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
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
                      color: _statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        color: _statusTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// main content scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// BID + DELIVERY SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _infoCard(
                              icon: Icons.attach_money,
                              title: "Bid Amount",
                              value: "£${proposal.price}",
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _infoCard(
                              icon: Icons.schedule,
                              title: "Delivery Time",
                              value: "${proposal.days} days",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// COVER LETTER / DESCRIPTION
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cover Letter",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            proposal.coverLetter ?? "No cover letter provided.",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// REVIEWS SECTION
                    if (showReviewForm) _buildReviewSection(),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// bottom action area
      bottomNavigationBar: showWorkButton
          ? Obx(() {
              final bool isLoading =
                  controller.isStarting.value || controller.isSubmitting.value;

              final String btnText = !hasStartedWork ? "Start Work" : "Submit Work";

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleWorkFlow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              btnText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            })
          : null,
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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