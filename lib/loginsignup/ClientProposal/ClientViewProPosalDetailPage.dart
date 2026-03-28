
// import 'package:flutter/material.dart';
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

//   late final RxString currentProposalStatus;
//   late final RxString currentWorkStatus;

//   final RxBool isAccepting = false.obs;
//   final RxBool isRejecting = false.obs;
//   final RxBool isApprovingLocal = false.obs;
//   final RxBool isSubmittingReview = false.obs;
//   final RxBool isReviewSubmitted = false.obs;
//   final RxBool showReviewForm = false.obs;

//   final TextEditingController reviewController = TextEditingController();
//   final RxInt selectedRating = 0.obs;

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

//     currentProposalStatus = _normalizeProposalStatus(widget.status).obs;
//     currentWorkStatus = _normalizeWorkStatus(widget.workStatus).obs;

//     /// agar page completed status ke sath khule to review form bhi show ho sakta hai
//     showReviewForm.value = currentProposalStatus.value == "completed" ||
//         currentWorkStatus.value == "completed";

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
//         isReviewSubmitted.value = false;
//         reviewController.clear();
//         selectedRating.value = 0;

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

//   void _submitReviewLocally() {
//     final rating = selectedRating.value;
//     final review = reviewController.text.trim();

//     if (rating <= 0) {
//       Get.snackbar(
//         "Error",
//         "Please select rating",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (review.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please write review",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     isSubmittingReview.value = true;

//     debugPrint("⭐ REVIEW RATING → $rating");
//     debugPrint("📝 REVIEW TEXT → $review");
//     debugPrint("➡️ REVIEW JOB ID → ${widget.jobId}");
//     debugPrint("➡️ REVIEW PROPOSAL ID → ${widget.proposalId}");

//     Future.delayed(const Duration(milliseconds: 400), () {
//       isSubmittingReview.value = false;
//       isReviewSubmitted.value = true;
//       showReviewForm.value = true;

//       Get.snackbar(
//         "Success",
//         "Review form ready. API integration baad me kar dena.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     });
//   }

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
//                       final isSelected = selectedRating.value >= starIndex;

//                       return GestureDetector(
//                         onTap: isReviewSubmitted.value
//                             ? null
//                             : () {
//                                 selectedRating.value = starIndex;
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
//                     controller: reviewController,
//                     maxLines: 4,
//                     readOnly: isReviewSubmitted.value,
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

//                   if (!isReviewSubmitted.value)
//                     ElevatedButton(
//                       onPressed: isSubmittingReview.value
//                           ? null
//                           : _submitReviewLocally,
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
//                       child: isSubmittingReview.value
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

//                   if (isReviewSubmitted.value) ...[
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

//             if (!isReviewSubmitted.value)
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
//             debugPrint("➡️ isReviewSubmitted → ${isReviewSubmitted.value}");

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
//     reviewController.dispose();

//     if (Get.isRegistered<ClientViewDetailsProposalController>(
//       tag: widget.proposalId,
//     )) {
//       Get.delete<ClientViewDetailsProposalController>(
//         tag: widget.proposalId,
//       );
//     }

//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

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

    showReviewForm.value = currentProposalStatus.value == "completed" ||
        currentWorkStatus.value == "completed";

    if (showReviewForm.value) {
      clientSideReviewController.loadReviews(jobId: widget.jobId);
    }

    debugPrint("📄 OPEN PROPOSAL DETAIL PAGE");
    debugPrint("➡️ INITIAL PROPOSAL STATUS → ${widget.status}");
    debugPrint("➡️ INITIAL WORK STATUS → ${widget.workStatus}");
    debugPrint("➡️ NORMALIZED PROPOSAL STATUS → ${currentProposalStatus.value}");
    debugPrint("➡️ NORMALIZED WORK STATUS → ${currentWorkStatus.value}");
    debugPrint("➡️ PROPOSAL ID → ${widget.proposalId}");
    debugPrint("➡️ JOB ID → ${widget.jobId}");
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

  bool get _canApprove =>
      (_isAccepted && _isWorkSubmitted) ||
      (_isSubmittedFromStatus && !_isCompleted);

  Future<void> _handleAccept() async {
    if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
      return;
    }

    try {
      isAccepting.value = true;

      debugPrint("🟢 ACCEPT BUTTON CLICKED");
      debugPrint("➡️ BEFORE ACCEPT STATUS → ${currentProposalStatus.value}");

      final success = await controller.acceptProposal(widget.proposalId);

      if (success) {
        currentProposalStatus.value = "accepted";

        debugPrint("✅ ACCEPT SUCCESS");
        debugPrint("➡️ AFTER ACCEPT STATUS → ${currentProposalStatus.value}");

        Get.snackbar(
          "Success",
          "Proposal accepted successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ ACCEPT ERROR → $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAccepting.value = false;
    }
  }

  Future<void> _handleReject() async {
    if (isAccepting.value || isRejecting.value || isApprovingLocal.value) {
      return;
    }

    try {
      isRejecting.value = true;

      debugPrint("🔴 REJECT BUTTON CLICKED");
      debugPrint("➡️ BEFORE REJECT STATUS → ${currentProposalStatus.value}");

      final success = await controller.rejectProposal(widget.proposalId);

      if (success) {
        currentProposalStatus.value = "rejected";

        debugPrint("✅ REJECT SUCCESS");
        debugPrint("➡️ AFTER REJECT STATUS → ${currentProposalStatus.value}");

        Get.snackbar(
          "Success",
          "Proposal rejected successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ REJECT ERROR → $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isRejecting.value = false;
    }
  }

  Future<void> _handleApprove() async {
    if (!_canApprove || isApprovingLocal.value) return;

    try {
      isApprovingLocal.value = true;

      debugPrint("🟣 APPROVE BUTTON PRESSED");
      debugPrint("➡️ PROPOSAL STATUS → ${currentProposalStatus.value}");
      debugPrint("➡️ WORK STATUS → ${currentWorkStatus.value}");
      debugPrint("➡️ APPROVE WITH JOB ID → ${widget.jobId}");
      debugPrint("➡️ PROPOSAL ID FOR REFERENCE → ${widget.proposalId}");

      final success = await controller.approveWork(widget.jobId);

      if (success) {
        currentProposalStatus.value = "completed";
        currentWorkStatus.value = "completed";
        showReviewForm.value = true;

        clientSideReviewController.clearForm();
        await clientSideReviewController.loadReviews(jobId: widget.jobId);

        Get.snackbar(
          "Success",
          "Work approved & job completed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ APPROVE ERROR → $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isApprovingLocal.value = false;
    }
  }

Future<void> _submitReviewApi() async {
  final success = await clientSideReviewController.submitReview(
    jobId: widget.jobId,
  );

  if (success) {
    final submitted = clientSideReviewController.submittedReview.value;

    if (submitted != null) {
      clientSideReviewController.setSubmittedReviewUi(
        rating: submitted.rating,
        reviewText: submitted.review,
      );
    }

    await clientSideReviewController.loadReviews(jobId: widget.jobId);
    setState(() {});
  }
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
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

                  if (!clientSideReviewController.hasSubmittedReview.value)
                    ElevatedButton(
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

            const SizedBox(height: 20),

            if (clientSideReviewController.isLoadingReviews.value)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (clientSideReviewController.reviews.isEmpty)
              const Center(
                child: Text(
                  "No reviews yet. Be the first one.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
              )
            else
              Column(
                children: clientSideReviewController.reviews.map((item) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.reviewerName.isEmpty
                              ? "Client Review"
                              : item.reviewerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < item.rating
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              size: 18,
                              color: index < item.rating
                                  ? const Color(0xFFFFC107)
                                  : const Color(0xFFD1D5DB),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        Text(item.review),
                      ],
                    ),
                  );
                }).toList(),
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

            debugPrint("🔄 UI REBUILD");
            debugPrint("➡️ proposalStatus → $proposalStatus");
            debugPrint("➡️ workStatus → $workStatus");
            debugPrint("➡️ isAccepted → $_isAccepted");
            debugPrint("➡️ isSubmittedFromStatus → $_isSubmittedFromStatus");
            debugPrint("➡️ isWorkSubmitted → $_isWorkSubmitted");
            debugPrint("➡️ canApprove → $_canApprove");
            debugPrint("➡️ showReviewForm → ${showReviewForm.value}");

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
                                      style: const TextStyle(color: Colors.grey),
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
                  else if ((_isAccepted || _isSubmittedFromStatus) &&
                      !showReviewForm.value)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _canApprove ? Colors.blue : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  void dispose() {
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