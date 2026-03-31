// import 'package:flutter/material.dart';
// import 'package:freelancer_app/chatboot/ClientMessagesController.dart';
// import 'package:freelancer_app/chatboot/MessageModel.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';


// class ClientChatBottomSheet extends StatefulWidget {
//   final String proposalId;
//   final String freelancerName;
//   final String currentUserId;

//   const ClientChatBottomSheet({
//     super.key,
//     required this.proposalId,
//     required this.freelancerName,
//     required this.currentUserId,
//   });

//   @override
//   State<ClientChatBottomSheet> createState() => _ClientChatBottomSheetState();
// }

// class _ClientChatBottomSheetState extends State<ClientChatBottomSheet> {
//   late final ClientMessagesController controller;
//   final ScrollController scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     final tag = "client-chat-${widget.proposalId}";

//     controller = Get.isRegistered<ClientMessagesController>(tag: tag)
//         ? Get.find<ClientMessagesController>(tag: tag)
//         : Get.put(
//             ClientMessagesController(currentUserId: widget.currentUserId),
//             tag: tag,
//           );

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await controller.initForProposal(widget.proposalId);
//       await controller.markAllIncomingSeen(widget.proposalId);
//       _scrollToBottom();
//     });
//   }

//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (!scrollController.hasClients) return;
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   String _formatDateLabel(DateTime? date) {
//     if (date == null) return "";
//     final now = DateTime.now();
//     final d = DateTime(date.year, date.month, date.day);
//     final t = DateTime(now.year, now.month, now.day);

//     if (d == t) return "Today";
//     if (d == t.subtract(const Duration(days: 1))) return "Yesterday";
//     return DateFormat("dd MMM yyyy").format(date);
//   }

//   bool _isSameDay(DateTime? a, DateTime? b) {
//     if (a == null || b == null) return false;
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         height: MediaQuery.of(context).size.height * .82,
//         padding: const EdgeInsets.only(top: 8),
//         decoration: const BoxDecoration(
//           color: Color(0xffF8FAFC),
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 44,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             const SizedBox(height: 14),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.blue,
//                     child: Text(
//                       widget.freelancerName.isEmpty
//                           ? "?"
//                           : widget.freelancerName[0].toUpperCase(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.freelancerName,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           "Live conversation",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.close_rounded),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Divider(height: 1),

//             Expanded(
//               child: Obx(() {
//                 final list = controller.messagesOf(widget.proposalId);

//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   _scrollToBottom();
//                 });

//                 if (controller.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (list.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       "No messages yet",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   controller: scrollController,
//                   padding: const EdgeInsets.all(16),
//                   itemCount: list.length,
//                   itemBuilder: (_, index) {
//                     final m = list[index];
//                     final prev = index > 0 ? list[index - 1] : null;
//                     final isSender = m.senderId == widget.currentUserId;

//                     return Column(
//                       children: [
//                         if (index == 0 || !_isSameDay(m.createdAt, prev?.createdAt))
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 10, top: 4),
//                             child: Center(
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade200,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   _formatDateLabel(m.createdAt),
//                                   style: const TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         _messageBubble(m, isSender),
//                       ],
//                     );
//                   },
//                 );
//               }),
//             ),

//             Container(
//               padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 border: Border(top: BorderSide(color: Color(0xffE5E7EB))),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.messageCtrl,
//                       minLines: 1,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         hintText: "Write a message...",
//                         filled: true,
//                         fillColor: const Color(0xffF3F4F6),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 12,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Obx(
//                     () => InkWell(
//                       onTap: controller.isSending.value
//                           ? null
//                           : () async {
//                               await controller.sendMessage(widget.proposalId);
//                               _scrollToBottom();
//                             },
//                       borderRadius: BorderRadius.circular(14),
//                       child: Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: controller.isSending.value
//                             ? const Padding(
//                                 padding: EdgeInsets.all(14),
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.send_rounded,
//                                 color: Colors.white,
//                               ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _messageBubble(MessageModel m, bool isSender) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * .72,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSender ? Colors.blue : Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//             bottomLeft: Radius.circular(isSender ? 16 : 4),
//             bottomRight: Radius.circular(isSender ? 4 : 16),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.04),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             )
//           ],
//           border: isSender ? null : Border.all(color: const Color(0xffE5E7EB)),
//         ),
//         child: Column(
//           crossAxisAlignment:
//               isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               m.message,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: isSender ? Colors.white : Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               m.createdAt == null ? "" : DateFormat("hh:mm a").format(m.createdAt!),
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isSender ? Colors.white70 : Colors.black45,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }
// }
// ONLY LOGS ADDED — NO LOGIC CHANGED

import 'package:flutter/material.dart';
import 'package:freelancer_app/chatboot/ClientMessagesController.dart';
import 'package:freelancer_app/chatboot/MessageModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientChatBottomSheet extends StatefulWidget {
  final String proposalId;
  final String freelancerName;
  final String currentUserId;

  const ClientChatBottomSheet({
    super.key,
    required this.proposalId,
    required this.freelancerName,
    required this.currentUserId,
  });

  @override
  State<ClientChatBottomSheet> createState() => _ClientChatBottomSheetState();
}

class _ClientChatBottomSheetState extends State<ClientChatBottomSheet> {
  late final ClientMessagesController controller;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    debugPrint("==================================================");
    debugPrint("💬 CHAT BOTTOM SHEET OPEN");
    debugPrint("➡️ PROPOSAL ID => ${widget.proposalId}");
    debugPrint("➡️ FREELANCER => ${widget.freelancerName}");
    debugPrint("➡️ CURRENT USER ID => ${widget.currentUserId}");
    debugPrint("==================================================");

    final tag = "client-chat-${widget.proposalId}";

    controller = Get.isRegistered<ClientMessagesController>(tag: tag)
        ? Get.find<ClientMessagesController>(tag: tag)
        : Get.put(
            ClientMessagesController(currentUserId: widget.currentUserId),
            tag: tag,
          );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("🚀 INIT CHAT FLOW START");

      await controller.initForProposal(widget.proposalId);
      debugPrint("✅ INIT FOR PROPOSAL DONE");

      await controller.markAllIncomingSeen(widget.proposalId);
      debugPrint("👁 MARK ALL SEEN DONE");

      _scrollToBottom();
      debugPrint("⬇️ SCROLL TO BOTTOM DONE");
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!scrollController.hasClients) {
        debugPrint("⚠️ SCROLL FAILED => no clients");
        return;
      }

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );

      debugPrint("⬇️ SCROLLED TO BOTTOM");
    });
  }

  String _formatDateLabel(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final d = DateTime(date.year, date.month, date.day);
    final t = DateTime(now.year, now.month, now.day);

    if (d == t) return "Today";
    if (d == t.subtract(const Duration(days: 1))) return "Yesterday";
    return DateFormat("dd MMM yyyy").format(date);
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .82,
        padding: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Color(0xffF8FAFC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 14),

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      widget.freelancerName.isEmpty
                          ? "?"
                          : widget.freelancerName[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.freelancerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Live conversation",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint("❌ CHAT CLOSED");
                      Get.back();
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),

            /// MESSAGES
            Expanded(
              child: Obx(() {
                final list = controller.messagesOf(widget.proposalId);

                debugPrint("📦 TOTAL MESSAGES => ${list.length}");

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                if (controller.isLoading.value) {
                  debugPrint("⏳ LOADING MESSAGES...");
                  return const Center(child: CircularProgressIndicator());
                }

                if (list.isEmpty) {
                  debugPrint("⚠️ NO MESSAGES FOUND");
                  return const Center(
                    child: Text(
                      "No messages yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final m = list[index];
                    final prev = index > 0 ? list[index - 1] : null;
                    final isSender = m.senderId == widget.currentUserId;

                    debugPrint(
                        "➡️ MESSAGE => ${m.id} | sender:${m.senderId} | isSender:$isSender");

                    return Column(
                      children: [
                        if (index == 0 ||
                            !_isSameDay(m.createdAt, prev?.createdAt))
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, top: 4),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _formatDateLabel(m.createdAt),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        _messageBubble(m, isSender),
                      ],
                    );
                  },
                );
              }),
            ),

            /// INPUT
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xffE5E7EB))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageCtrl,
                      decoration: InputDecoration(
                        hintText: "Write a message...",
                        filled: true,
                        fillColor: const Color(0xffF3F4F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  /// SEND BUTTON
                  Obx(
                    () => InkWell(
                      onTap: controller.isSending.value
                          ? null
                          : () async {
                              debugPrint("📤 SEND BUTTON CLICKED");
                              debugPrint(
                                  "➡️ TEXT => ${controller.messageCtrl.text}");
                              debugPrint(
                                  "➡️ PROPOSAL => ${widget.proposalId}");

                              await controller
                                  .sendMessage(widget.proposalId);

                              _scrollToBottom();
                            },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: controller.isSending.value
                            ? const Padding(
                                padding: EdgeInsets.all(14),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageBubble(MessageModel m, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              m.message,
              style: TextStyle(
                color: isSender ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              m.createdAt == null
                  ? ""
                  : DateFormat("hh:mm a").format(m.createdAt!),
              style: TextStyle(
                fontSize: 10,
                color: isSender ? Colors.white70 : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("🧹 CHAT BOTTOM SHEET DISPOSE");
    scrollController.dispose();
    super.dispose();
  }
}