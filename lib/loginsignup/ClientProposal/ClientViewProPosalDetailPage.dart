
// import 'package:flutter/material.dart';
// import 'package:freelancer_app/clientsideReview/ClientSideReviewController.dart';
// import 'package:freelancer_app/loginsignup/ClientProposal/ClientViewDetailPropsaleController.dart';
// import 'package:get/get.dart';

// class ClientViewDetailsProposalPage extends StatefulWidget {
//   const ClientViewDetailsProposalPage({
//     super.key,
//     required this.proposalId,
//     required this.jobId,
//     required this.freelancerName,
//     required this.freelancerEmail,
//     required this.status,
//     required this.coverLetter,
//     required this.price,
//     required this.deliveryDays,
//     this.workStatus = "",
//   });

//   final String proposalId;
//   final String jobId;
//   final String freelancerName;
//   final String freelancerEmail;
//   final String status;
//   final String coverLetter;
//   final String price;
//   final String deliveryDays;
//   final String workStatus;

//   @override
//   State<ClientViewDetailsProposalPage> createState() =>
//       _ClientViewDetailsProposalPageState();
// }

// class _ClientViewDetailsProposalPageState
//     extends State<ClientViewDetailsProposalPage> {
//   late final ClientViewDetailsProposalController controller;
//   late final ClientSideReviewController clientSideReviewController;

//   late final RxString currentProposalStatus;
//   late final RxString currentWorkStatus;

//   final RxBool isAccepting = false.obs;
//   final RxBool isRejecting = false.obs;
//   final RxBool isApprovingLocal = false.obs;
//   final RxBool showReviewForm = false.obs;

//   @override
//   void initState() {
//     super.initState();

//     controller = Get.isRegistered<ClientViewDetailsProposalController>(
//       tag: widget.proposalId,
//     )
//         ? Get.find<ClientViewDetailsProposalController>(tag: widget.proposalId)
//         : Get.put(
//             ClientViewDetailsProposalController(),
//             tag: widget.proposalId,
//           );

//     clientSideReviewController =
//         Get.isRegistered<ClientSideReviewController>(tag: widget.jobId)
//             ? Get.find<ClientSideReviewController>(tag: widget.jobId)
//             : Get.put(
//                 ClientSideReviewController(),
//                 tag: widget.jobId,
//               );

//     currentProposalStatus = _normalizeProposalStatus(widget.status).obs;
//     currentWorkStatus = _normalizeWorkStatus(widget.workStatus).obs;

//     showReviewForm.value = currentProposalStatus.value == "completed" ||
//         currentWorkStatus.value == "completed";

//     if (showReviewForm.value) {
//       clientSideReviewController.loadReviews(jobId: widget.jobId);
//     }

//     debugPrint("📄 OPEN PROPOSAL DETAIL PAGE");
//     debugPrint("➡️ INITIAL PROPOSAL STATUS → ${widget.status}");
//     debugPrint("➡️ INITIAL WORK STATUS → ${widget.workStatus}");
//     debugPrint("➡️ NORMALIZED PROPOSAL STATUS → ${currentProposalStatus.value}");
//     debugPrint("➡️ NORMALIZED WORK STATUS → ${currentWorkStatus.value}");
//     debugPrint("➡️ PROPOSAL ID → ${widget.proposalId}");
//     debugPrint("➡️ JOB ID → ${widget.jobId}");
//   }

//   String _normalizeProposalStatus(String value) {
//     final v = value.trim().toLowerCase();

//     if (v.isEmpty) return "";
//     if (v.contains("pending")) return "pending";
//     if (v.contains("accept")) return "accepted";
//     if (v.contains("reject")) return "rejected";
//     if (v == "subbmited") return "submitted";
//     if (v.contains("submit")) return "submitted";
//     if (v.contains("deliver")) return "submitted";
//     if (v.contains("complete")) return "completed";
//     if (v.contains("approve")) return "approved";

//     return v;
//   }

//   String _normalizeWorkStatus(String value) {
//     final v = value.trim().toLowerCase();

//     if (v.isEmpty) return "";
//     if (v == "subbmited") return "submitted";
//     if (v.contains("submit")) return "submitted";
//     if (v.contains("deliver")) return "submitted";
//     if (v.contains("complete")) return "completed";
//     if (v.contains("approve")) return "approved";

//     return v;
//   }

//   bool get _isCompleted =>
//       currentProposalStatus.value == "completed" ||
//       currentWorkStatus.value == "completed";

//   bool get _isPending => currentProposalStatus.value == "pending";

//   bool get _isAccepted => currentProposalStatus.value == "accepted";

//   bool get _isSubmittedFromStatus =>
//       currentProposalStatus.value == "submitted";

//   bool get _isWorkSubmitted => currentWorkStatus.value == "submitted";

//   bool get _canApprove =>
//       (_isAccepted && _isWorkSubmitted) ||
//       (_isSubmittedFromStatus && !_isCompleted);

//   Future<void> _handleAccept() async {
//     if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
//       return;
//     }

//     try {
//       isAccepting.value = true;

//       debugPrint("🟢 ACCEPT BUTTON CLICKED");
//       debugPrint("➡️ BEFORE ACCEPT STATUS → ${currentProposalStatus.value}");

//       final success = await controller.acceptProposal(widget.proposalId);

//       if (success) {
//         currentProposalStatus.value = "accepted";

//         debugPrint("✅ ACCEPT SUCCESS");
//         debugPrint("➡️ AFTER ACCEPT STATUS → ${currentProposalStatus.value}");

//         Get.snackbar(
//           "Success",
//           "Proposal accepted successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint("❌ ACCEPT ERROR → $e");
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isAccepting.value = false;
//     }
//   }

//   Future<void> _handleReject() async {
//     if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
//       return;
//     }

//     try {
//       isRejecting.value = true;

//       debugPrint("🔴 REJECT BUTTON CLICKED");
//       debugPrint("➡️ BEFORE REJECT STATUS → ${currentProposalStatus.value}");

//       final success = await controller.rejectProposal(widget.proposalId);

//       if (success) {
//         currentProposalStatus.value = "rejected";

//         debugPrint("✅ REJECT SUCCESS");
//         debugPrint("➡️ AFTER REJECT STATUS → ${currentProposalStatus.value}");

//         Get.snackbar(
//           "Success",
//           "Proposal rejected successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint("❌ REJECT ERROR → $e");
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isRejecting.value = false;
//     }
//   }

//   Future<void> _handleApprove() async {
//     if (!_canApprove || isApprovingLocal.value) return;

//     try {
//       isApprovingLocal.value = true;

//       debugPrint("🟣 APPROVE BUTTON PRESSED");
//       debugPrint("➡️ PROPOSAL STATUS → ${currentProposalStatus.value}");
//       debugPrint("➡️ WORK STATUS → ${currentWorkStatus.value}");
//       debugPrint("➡️ APPROVE WITH JOB ID → ${widget.jobId}");
//       debugPrint("➡️ PROPOSAL ID FOR REFERENCE → ${widget.proposalId}");

//       final success = await controller.approveWork(widget.jobId);

//       if (success) {
//         currentProposalStatus.value = "completed";
//         currentWorkStatus.value = "completed";
//         showReviewForm.value = true;

//         clientSideReviewController.clearForm();
//         await clientSideReviewController.loadReviews(jobId: widget.jobId);

//         Get.snackbar(
//           "Success",
//           "Work approved & job completed",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint("❌ APPROVE ERROR → $e");
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isApprovingLocal.value = false;
//     }
//   }

// Future<void> _submitReviewApi() async {
//   final success = await clientSideReviewController.submitReview(
//     jobId: widget.jobId,
//   );

//   if (success) {
//     final submitted = clientSideReviewController.submittedReview.value;

//     if (submitted != null) {
//       clientSideReviewController.setSubmittedReviewUi(
//         rating: submitted.rating,
//         reviewText: submitted.review,
//       );
//     }

//     await clientSideReviewController.loadReviews(jobId: widget.jobId);
//     setState(() {});
//   }
// }

//   Widget _buildReviewSection() {
//     return Obx(
//       () => Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(top: 16),
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
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
//             const SizedBox(height: 12),

//             if (clientSideReviewController.stats.value != null)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF9FAFB),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                 ),
//                 child: Text(
//                   "Total Reviews: ${clientSideReviewController.stats.value!.totalReviews}   |   Avg Rating: ${clientSideReviewController.stats.value!.avgRating}",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),

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
//                       final hasSubmitted =
//                           clientSideReviewController.hasSubmittedReview.value;
//                       final submittedData =
//                           clientSideReviewController.submittedReview.value;

//                       final isSelected = (hasSubmitted
//                                   ? (submittedData?.rating ?? 0)
//                                   : clientSideReviewController
//                                       .selectedRating.value) >=
//                               starIndex;

//                       return GestureDetector(
//                         onTap: hasSubmitted
//                             ? null
//                             : () {
//                                 clientSideReviewController.setRating(starIndex);
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
//                     controller: clientSideReviewController.reviewCtrl,
//                     maxLines: 4,
//                     readOnly:
//                         clientSideReviewController.hasSubmittedReview.value,
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

//                   if (!clientSideReviewController.hasSubmittedReview.value)
//                     ElevatedButton(
//                       onPressed:
//                           clientSideReviewController.isSubmittingReview.value
//                               ? null
//                               : _submitReviewApi,
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
//                       child:
//                           clientSideReviewController.isSubmittingReview.value
//                               ? const SizedBox(
//                                   height: 18,
//                                   width: 18,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               : const Text(
//                                   "Submit Review",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                     ),

//                   if (clientSideReviewController.hasSubmittedReview.value) ...[
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

//             const SizedBox(height: 20),

//             if (clientSideReviewController.isLoadingReviews.value)
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(12),
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             else if (clientSideReviewController.reviews.isEmpty)
//               const Center(
//                 child: Text(
//                   "No reviews yet. Be the first one.",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black38,
//                   ),
//                 ),
//               )
//             else
//               Column(
//                 children: clientSideReviewController.reviews.map((item) {
//                   return Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 10),
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF9FAFB),
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: const Color(0xFFE5E7EB)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.reviewerName.isEmpty
//                               ? "Client Review"
//                               : item.reviewerName,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Row(
//                           children: List.generate(5, (index) {
//                             return Icon(
//                               index < item.rating
//                                   ? Icons.star_rounded
//                                   : Icons.star_border_rounded,
//                               size: 18,
//                               color: index < item.rating
//                                   ? const Color(0xFFFFC107)
//                                   : const Color(0xFFD1D5DB),
//                             );
//                           }),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(item.review),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final avatarLetter = widget.freelancerName.isNotEmpty
//         ? widget.freelancerName[0].toUpperCase()
//         : "?";

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F6F8),
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text("Proposal Details"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Obx(() {
//             final proposalStatus = currentProposalStatus.value;
//             final workStatus = currentWorkStatus.value;

//             debugPrint("🔄 UI REBUILD");
//             debugPrint("➡️ proposalStatus → $proposalStatus");
//             debugPrint("➡️ workStatus → $workStatus");
//             debugPrint("➡️ isAccepted → $_isAccepted");
//             debugPrint("➡️ isSubmittedFromStatus → $_isSubmittedFromStatus");
//             debugPrint("➡️ isWorkSubmitted → $_isWorkSubmitted");
//             debugPrint("➡️ canApprove → $_canApprove");
//             debugPrint("➡️ showReviewForm → ${showReviewForm.value}");

//             return Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.blue,
//                                 child: Text(
//                                   avatarLetter,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       widget.freelancerName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       widget.freelancerEmail,
//                                       style: const TextStyle(color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: _statusBgColor(proposalStatus),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   proposalStatus.toUpperCase(),
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: _infoCard("PRICE", "£${widget.price}"),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: _infoCard(
//                                 "DELIVERY",
//                                 "${widget.deliveryDays} days",
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Cover Letter",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(widget.coverLetter),
//                             ],
//                           ),
//                         ),

//                         if (workStatus.isNotEmpty) ...[
//                           const SizedBox(height: 16),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 14,
//                               vertical: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.work_history_outlined,
//                                   size: 18,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     "Work Status: ${workStatus.toUpperCase()}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],

//                         if (showReviewForm.value) _buildReviewSection(),

//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),

//                 if (!_isCompleted)
//                   if (_isPending)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             onPressed: (isAccepting.value ||
//                                     isRejecting.value ||
//                                     isApprovingLocal.value)
//                                 ? null
//                                 : _handleAccept,
//                             child: isAccepting.value
//                                 ? const Text("Please wait...")
//                                 : const Text("Accept"),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             onPressed: (isAccepting.value ||
//                                     isRejecting.value ||
//                                     isApprovingLocal.value)
//                                 ? null
//                                 : _handleReject,
//                             child: isRejecting.value
//                                 ? const Text("Please wait...")
//                                 : const Text("Reject"),
//                           ),
//                         ),
//                       ],
//                     )
//                   else if ((_isAccepted || _isSubmittedFromStatus) &&
//                       !showReviewForm.value)
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               _canApprove ? Colors.blue : Colors.grey,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         onPressed: (!_canApprove || isApprovingLocal.value)
//                             ? null
//                             : _handleApprove,
//                         child: isApprovingLocal.value
//                             ? const Text("Please wait approving...")
//                             : _canApprove
//                                 ? const Text("Approve Work")
//                                 : const Text("Waiting for Submit"),
//                       ),
//                     ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget _infoCard(String title, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _statusBgColor(String status) {
//     switch (status.toLowerCase()) {
//       case "pending":
//         return Colors.orange.shade100;
//       case "accepted":
//         return Colors.green.shade100;
//       case "rejected":
//         return Colors.red.shade100;
//       case "completed":
//         return Colors.blueGrey.shade100;
//       case "submitted":
//         return Colors.blue.shade100;
//       default:
//         return Colors.grey.shade200;
//     }
//   }

//   @override
//   void dispose() {
//     if (Get.isRegistered<ClientViewDetailsProposalController>(
//       tag: widget.proposalId,
//     )) {
//       Get.delete<ClientViewDetailsProposalController>(
//         tag: widget.proposalId,
//       );
//     }

//     if (Get.isRegistered<ClientSideReviewController>(tag: widget.jobId)) {
//       Get.delete<ClientSideReviewController>(tag: widget.jobId);
//     }

//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:freelancer_app/chatboot/ClientChatBottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancer_app/clientsideReview/ClientSideReviewController.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientViewDetailPropsaleController.dart';
import 'package:get/get.dart';

class ClientViewDetailsProposalPage extends StatefulWidget {
  const ClientViewDetailsProposalPage({
    super.key,
    required this.proposalId,
    required this.jobId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.status,
    required this.coverLetter,
    required this.price,
    required this.deliveryDays,
    this.workStatus = "",
  });

  final String proposalId;
  final String jobId;
  final String freelancerName;
  final String freelancerEmail;
  final String status;
  final String coverLetter;
  final String price;
  final String deliveryDays;
  final String workStatus;

  @override
  State<ClientViewDetailsProposalPage> createState() =>
      _ClientViewDetailsProposalPageState();
}

class _ClientViewDetailsProposalPageState
    extends State<ClientViewDetailsProposalPage> {
  late final ClientViewDetailsProposalController controller;
  late final ClientSideReviewController clientSideReviewController;

  late final RxString currentProposalStatus;
  late final RxString currentWorkStatus;

  final RxBool isAccepting = false.obs;
  final RxBool isRejecting = false.obs;
  final RxBool isApprovingLocal = false.obs;
  final RxBool showReviewForm = false.obs;

  final RxString currentUserId = "".obs;

  @override
  void initState() {
    super.initState();

    debugPrint("==================================================");
    debugPrint("📄 CLIENT PROPOSAL DETAILS PAGE OPEN");
    debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
    debugPrint("➡️ JOB ID => ${widget.jobId}");
    debugPrint("➡️ FREELANCER NAME => ${widget.freelancerName}");
    debugPrint("➡️ STATUS => ${widget.status}");
    debugPrint("➡️ WORK STATUS => ${widget.workStatus}");
    debugPrint("==================================================");

    controller = Get.isRegistered<ClientViewDetailsProposalController>(
      tag: widget.proposalId,
    )
        ? Get.find<ClientViewDetailsProposalController>(tag: widget.proposalId)
        : Get.put(
            ClientViewDetailsProposalController(),
            tag: widget.proposalId,
          );

    clientSideReviewController =
        Get.isRegistered<ClientSideReviewController>(tag: widget.jobId)
            ? Get.find<ClientSideReviewController>(tag: widget.jobId)
            : Get.put(
                ClientSideReviewController(),
                tag: widget.jobId,
              );

    currentProposalStatus = _normalizeProposalStatus(widget.status).obs;
    currentWorkStatus = _normalizeWorkStatus(widget.workStatus).obs;

    debugPrint("✅ NORMALIZED STATUS READY");
    debugPrint("➡️ currentProposalStatus => ${currentProposalStatus.value}");
    debugPrint("➡️ currentWorkStatus => ${currentWorkStatus.value}");

    showReviewForm.value = currentProposalStatus.value == "completed" ||
        currentWorkStatus.value == "completed";

    debugPrint("➡️ showReviewForm initial => ${showReviewForm.value}");

    if (showReviewForm.value) {
      debugPrint("📥 LOADING REVIEWS ON INIT...");
      clientSideReviewController.loadReviews(jobId: widget.jobId);
    }

    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    try {
      debugPrint("==================================================");
      debugPrint("👤 LOAD CURRENT USER ID START");
      debugPrint("==================================================");

      final prefs = await SharedPreferences.getInstance();

      final clientId = prefs.getString("client_id");
      final userId = prefs.getString("user_id");
      final id = prefs.getString("id");

      debugPrint("➡️ PREF client_id => $clientId");
      debugPrint("➡️ PREF user_id => $userId");
      debugPrint("➡️ PREF id => $id");

      currentUserId.value = (clientId ?? userId ?? id ?? "").toString();

      debugPrint("✅ FINAL CURRENT USER ID => ${currentUserId.value}");

      if (currentUserId.value.isEmpty) {
        debugPrint("⚠️ USER ID IS EMPTY");
      }
    } catch (e) {
      debugPrint("❌ LOAD CURRENT USER ID ERROR => $e");
    }
  }

  String _normalizeProposalStatus(String value) {
    final v = value.trim().toLowerCase();

    if (v.isEmpty) return "";
    if (v.contains("pending")) return "pending";
    if (v.contains("accept")) return "accepted";
    if (v.contains("reject")) return "rejected";
    if (v == "subbmited") return "submitted";
    if (v.contains("submit")) return "submitted";
    if (v.contains("deliver")) return "submitted";
    if (v.replaceAll(" ", "").contains("inprogress")) return "inprogress";
    if (v.contains("complete")) return "completed";
    if (v.contains("approve")) return "approved";

    return v;
  }

  String _normalizeWorkStatus(String value) {
    final v = value.trim().toLowerCase();

    if (v.isEmpty) return "";
    if (v == "subbmited") return "submitted";
    if (v.contains("submit")) return "submitted";
    if (v.contains("deliver")) return "submitted";
    if (v.replaceAll(" ", "").contains("inprogress")) return "inprogress";
    if (v.contains("complete")) return "completed";
    if (v.contains("approve")) return "approved";

    return v;
  }

  bool get _isCompleted =>
      currentProposalStatus.value == "completed" ||
      currentWorkStatus.value == "completed";

  bool get _isPending => currentProposalStatus.value == "pending";

  bool get _isAccepted => currentProposalStatus.value == "accepted";

  bool get _isSubmittedFromStatus =>
      currentProposalStatus.value == "submitted";

  bool get _isWorkSubmitted => currentWorkStatus.value == "submitted";

  bool get _isInProgress =>
      currentProposalStatus.value == "inprogress" ||
      currentWorkStatus.value == "inprogress";

  bool get _canApprove =>
      (_isAccepted && _isWorkSubmitted) ||
      (_isSubmittedFromStatus && !_isCompleted);

  bool get _canOpenChat {
    final canChat = !_isPending &&
        !_isCompleted &&
        (_isAccepted ||
            _isSubmittedFromStatus ||
            _isWorkSubmitted ||
            _isInProgress);

    debugPrint("==================================================");
    debugPrint("💬 CHAT VISIBILITY CHECK");
    debugPrint("➡️ proposalStatus => ${currentProposalStatus.value}");
    debugPrint("➡️ workStatus => ${currentWorkStatus.value}");
    debugPrint("➡️ _isPending => $_isPending");
    debugPrint("➡️ _isCompleted => $_isCompleted");
    debugPrint("➡️ _isAccepted => $_isAccepted");
    debugPrint("➡️ _isSubmittedFromStatus => $_isSubmittedFromStatus");
    debugPrint("➡️ _isWorkSubmitted => $_isWorkSubmitted");
    debugPrint("➡️ _isInProgress => $_isInProgress");
    debugPrint("➡️ _canOpenChat => $canChat");
    debugPrint("==================================================");

    return canChat;
  }

  Future<void> _handleAccept() async {
    if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
      debugPrint("⚠️ ACCEPT BLOCKED => another action already running");
      return;
    }

    try {
      isAccepting.value = true;

      debugPrint("==================================================");
      debugPrint("🟢 ACCEPT CLICKED");
      debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
      debugPrint("➡️ BEFORE STATUS => ${currentProposalStatus.value}");
      debugPrint("==================================================");

      final success = await controller.acceptProposal(widget.proposalId);

      debugPrint("➡️ ACCEPT API RESPONSE => $success");

      if (success) {
        currentProposalStatus.value = "accepted";

        debugPrint("✅ ACCEPT SUCCESS");
        debugPrint("➡️ AFTER STATUS => ${currentProposalStatus.value}");

        Get.snackbar(
          "Success",
          "Proposal accepted successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ ACCEPT ERROR => $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAccepting.value = false;
      debugPrint("🛑 ACCEPT END");
    }
  }

  Future<void> _handleReject() async {
    if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
      debugPrint("⚠️ REJECT BLOCKED => another action already running");
      return;
    }

    try {
      isRejecting.value = true;

      debugPrint("==================================================");
      debugPrint("🔴 REJECT CLICKED");
      debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
      debugPrint("➡️ BEFORE STATUS => ${currentProposalStatus.value}");
      debugPrint("==================================================");

      final success = await controller.rejectProposal(widget.proposalId);

      debugPrint("➡️ REJECT API RESPONSE => $success");

      if (success) {
        currentProposalStatus.value = "rejected";

        debugPrint("✅ REJECT SUCCESS");
        debugPrint("➡️ AFTER STATUS => ${currentProposalStatus.value}");

        Get.snackbar(
          "Success",
          "Proposal rejected successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ REJECT ERROR => $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isRejecting.value = false;
      debugPrint("🛑 REJECT END");
    }
  }

  Future<void> _handleApprove() async {
    if (!_canApprove || isApprovingLocal.value) {
      debugPrint("⚠️ APPROVE BLOCKED");
      debugPrint("➡️ _canApprove => $_canApprove");
      debugPrint("➡️ isApprovingLocal => ${isApprovingLocal.value}");
      return;
    }

    try {
      isApprovingLocal.value = true;

      debugPrint("==================================================");
      debugPrint("🟣 APPROVE CLICKED");
      debugPrint("➡️ JOB ID => ${widget.jobId}");
      debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
      debugPrint("➡️ BEFORE PROPOSAL STATUS => ${currentProposalStatus.value}");
      debugPrint("➡️ BEFORE WORK STATUS => ${currentWorkStatus.value}");
      debugPrint("==================================================");

      final success = await controller.approveWork(widget.jobId);

      debugPrint("➡️ APPROVE API RESPONSE => $success");

      if (success) {
        currentProposalStatus.value = "completed";
        currentWorkStatus.value = "completed";
        showReviewForm.value = true;

        debugPrint("✅ APPROVE SUCCESS");
        debugPrint("➡️ AFTER PROPOSAL STATUS => ${currentProposalStatus.value}");
        debugPrint("➡️ AFTER WORK STATUS => ${currentWorkStatus.value}");
        debugPrint("➡️ showReviewForm => ${showReviewForm.value}");
        debugPrint("➡️ APPROVE BUTTON SHOULD NOW HIDE/DISABLE");

        clientSideReviewController.clearForm();
        await clientSideReviewController.loadReviews(jobId: widget.jobId);

        Get.snackbar(
          "Success",
          "Work approved & job completed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ APPROVE ERROR => $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isApprovingLocal.value = false;
      debugPrint("🛑 APPROVE END");
    }
  }

  Future<void> _submitReviewApi() async {
    try {
      debugPrint("==================================================");
      debugPrint("⭐ SUBMIT REVIEW START");
      debugPrint("➡️ JOB ID => ${widget.jobId}");
      debugPrint("➡️ currentUserId => ${currentUserId.value}");
      debugPrint(
          "➡️ selectedRating => ${clientSideReviewController.selectedRating.value}");
      debugPrint(
          "➡️ reviewText => ${clientSideReviewController.reviewCtrl.text}");
      debugPrint("==================================================");

      final success = await clientSideReviewController.submitReview(
        jobId: widget.jobId,
      );

      debugPrint("➡️ SUBMIT REVIEW RESPONSE => $success");

      if (success) {
        final submitted = clientSideReviewController.submittedReview.value;

        if (submitted != null) {
          debugPrint("✅ REVIEW SUBMITTED");
          debugPrint("➡️ submitted.rating => ${submitted.rating}");
          debugPrint("➡️ submitted.review => ${submitted.review}");

          clientSideReviewController.setSubmittedReviewUi(
            rating: submitted.rating,
            reviewText: submitted.review,
          );
        }

        await clientSideReviewController.loadReviews(jobId: widget.jobId);
        setState(() {});
      }
    } catch (e) {
      debugPrint("❌ SUBMIT REVIEW ERROR => $e");
    }
  }

  void _openChatSheet() {
    debugPrint("==================================================");
    debugPrint("💬 OPEN CHAT CLICKED");
    debugPrint("➡️ proposalId => ${widget.proposalId}");
    debugPrint("➡️ freelancerName => ${widget.freelancerName}");
    debugPrint("➡️ currentUserId => ${currentUserId.value}");
    debugPrint("➡️ proposalStatus => ${currentProposalStatus.value}");
    debugPrint("➡️ workStatus => ${currentWorkStatus.value}");
    debugPrint("➡️ _canOpenChat => $_canOpenChat");
    debugPrint("==================================================");

    if (!_canOpenChat) {
      debugPrint("⚠️ CHAT OPEN BLOCKED => _canOpenChat is false");
      return;
    }

    if (currentUserId.value.isEmpty) {
      debugPrint("❌ CHAT OPEN BLOCKED => USER ID EMPTY");
      Get.snackbar(
        "Error",
        "User ID not found. Please login again.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    debugPrint("✅ OPENING CHAT BOTTOM SHEET");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ClientChatBottomSheet(
        proposalId: widget.proposalId,
        freelancerName: widget.freelancerName,
        currentUserId: currentUserId.value,
      ),
    );
  }

  Widget _buildReviewSection() {
    return Obx(
      () => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
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
            const SizedBox(height: 12),
            if (clientSideReviewController.stats.value != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  "Total Reviews: ${clientSideReviewController.stats.value!.totalReviews}   |   Avg Rating: ${clientSideReviewController.stats.value!.avgRating}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
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
                      final hasSubmitted =
                          clientSideReviewController.hasSubmittedReview.value;
                      final submittedData =
                          clientSideReviewController.submittedReview.value;

                      final isSelected = (hasSubmitted
                                  ? (submittedData?.rating ?? 0)
                                  : clientSideReviewController
                                          .selectedRating.value) >=
                              starIndex;

                      return GestureDetector(
                        onTap: hasSubmitted
                            ? null
                            : () {
                                debugPrint("⭐ STAR CLICKED => $starIndex");
                                clientSideReviewController.setRating(starIndex);
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
                    controller: clientSideReviewController.reviewCtrl,
                    maxLines: 4,
                    readOnly:
                        clientSideReviewController.hasSubmittedReview.value,
                    decoration: InputDecoration(
                      hintText: "Write your review",
                      contentPadding: const EdgeInsets.all(14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFF6366F1)),
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
                  if (!clientSideReviewController.hasSubmittedReview.value)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            clientSideReviewController.isSubmittingReview.value
                                ? null
                                : _submitReviewApi,
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
                        child:
                            clientSideReviewController.isSubmittingReview.value
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
                    ),
                  if (clientSideReviewController.hasSubmittedReview.value) ...[
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarLetter = widget.freelancerName.isNotEmpty
        ? widget.freelancerName[0].toUpperCase()
        : "?";

    return Scaffold(
      backgroundColor: const Color(0xffF5F6F8),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Proposal Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            final proposalStatus = currentProposalStatus.value;
            final workStatus = currentWorkStatus.value;

            debugPrint("--------------------------------------------------");
            debugPrint("🔄 UI REBUILD");
            debugPrint("➡️ proposalStatus => $proposalStatus");
            debugPrint("➡️ workStatus => $workStatus");
            debugPrint("➡️ currentUserId => ${currentUserId.value}");
            debugPrint("➡️ _isPending => $_isPending");
            debugPrint("➡️ _isCompleted => $_isCompleted");
            debugPrint("➡️ _isAccepted => $_isAccepted");
            debugPrint("➡️ _isSubmittedFromStatus => $_isSubmittedFromStatus");
            debugPrint("➡️ _isWorkSubmitted => $_isWorkSubmitted");
            debugPrint("➡️ _isInProgress => $_isInProgress");
            debugPrint("➡️ _canOpenChat => $_canOpenChat");
            debugPrint("➡️ _canApprove => $_canApprove");
            debugPrint("➡️ showReviewForm => ${showReviewForm.value}");
            debugPrint("--------------------------------------------------");

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  avatarLetter,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.freelancerName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.freelancerEmail,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusBgColor(proposalStatus),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  proposalStatus.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _infoCard("PRICE", "£${widget.price}"),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _infoCard(
                                "DELIVERY",
                                "${widget.deliveryDays} days",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Cover Letter",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(widget.coverLetter),
                            ],
                          ),
                        ),
                        if (workStatus.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.work_history_outlined,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Work Status: ${workStatus.toUpperCase()}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (showReviewForm.value) _buildReviewSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                if (!_isCompleted)
                  if (_isPending)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: (isAccepting.value ||
                                    isRejecting.value ||
                                    isApprovingLocal.value)
                                ? null
                                : _handleAccept,
                            child: isAccepting.value
                                ? const Text("Please wait...")
                                : const Text("Accept"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: (isAccepting.value ||
                                    isRejecting.value ||
                                    isApprovingLocal.value)
                                ? null
                                : _handleReject,
                            child: isRejecting.value
                                ? const Text("Please wait...")
                                : const Text("Reject"),
                          ),
                        ),
                      ],
                    )
                  else if ((_isAccepted ||
                          _isSubmittedFromStatus ||
                          _isInProgress) &&
                      !showReviewForm.value)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _canApprove ? Colors.blue : Colors.grey,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: (!_canApprove || isApprovingLocal.value)
                                ? null
                                : _handleApprove,
                            child: isApprovingLocal.value
                                ? const Text("Please wait approving...")
                                : _canApprove
                                    ? const Text("Approve Work")
                                    : const Text("Waiting for Submit"),
                          ),
                        ),
                        if (_canOpenChat) ...[
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _openChatSheet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ],
                    ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusBgColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange.shade100;
      case "accepted":
        return Colors.green.shade100;
      case "rejected":
        return Colors.red.shade100;
      case "completed":
        return Colors.blueGrey.shade100;
      case "submitted":
        return Colors.blue.shade100;
      case "inprogress":
        return Colors.purple.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  void dispose() {
    debugPrint("==================================================");
    debugPrint("🧹 CLIENT PROPOSAL DETAILS PAGE DISPOSE");
    debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
    debugPrint("➡️ JOB ID => ${widget.jobId}");
    debugPrint("==================================================");

    if (Get.isRegistered<ClientViewDetailsProposalController>(
      tag: widget.proposalId,
    )) {
      Get.delete<ClientViewDetailsProposalController>(
        tag: widget.proposalId,
      );
    }

    if (Get.isRegistered<ClientSideReviewController>(tag: widget.jobId)) {
      Get.delete<ClientSideReviewController>(tag: widget.jobId);
    }

    super.dispose();
  }
}