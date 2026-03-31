import 'package:flutter/material.dart';
import 'package:freelancer_app/chatboot/ChatSocketService.dart';
import 'package:freelancer_app/chatboot/MessageModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class FreelancerMessagesController extends GetxController {
  final String currentUserId;

  FreelancerMessagesController({required this.currentUserId});

  final RxMap<String, List<MessageModel>> chats =
      <String, List<MessageModel>>{}.obs;

  final RxMap<String, int> unreadByProposal = <String, int>{}.obs;
  final RxMap<String, int> unreadByJob = <String, int>{}.obs;

  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;

  final TextEditingController messageCtrl = TextEditingController();

  final Set<String> _seenIds = {};
  final Set<String> _joinedRooms = {};

  @override
  void onInit() {
    super.onInit();
    debugPrint("==================================================");
    debugPrint("💬 FREELANCER MESSAGES CONTROLLER INIT");
    debugPrint("➡️ CURRENT USER ID => $currentUserId");
    debugPrint("==================================================");
  }

  @override
  void onClose() {
    debugPrint("==================================================");
    debugPrint("🧹 FREELANCER MESSAGES CONTROLLER CLOSE");
    debugPrint("➡️ CURRENT USER ID => $currentUserId");
    debugPrint("==================================================");
    messageCtrl.dispose();
    super.onClose();
  }

  Future<void> connectSocket() async {
    try {
      debugPrint("==================================================");
      debugPrint("🔌 FREELANCER CONNECT SOCKET CALLED");
      debugPrint("➡️ ROLE => freelancer");
      debugPrint("➡️ USER ID => $currentUserId");
      debugPrint("==================================================");

      await ChatSocketService.connect(
        userId: currentUserId,
        role: "freelancer",
      );

      debugPrint("✅ FREELANCER SOCKET CONNECT REQUEST DONE");
    } catch (e) {
      debugPrint("❌ FREELANCER SOCKET CONNECT ERROR => $e");
    }
  }

  void attachGlobalListeners() {
    final socket = ChatSocketService.socket;

    debugPrint("==================================================");
    debugPrint("🎧 ATTACH FREELANCER GLOBAL SOCKET LISTENERS");
    debugPrint("➡️ SOCKET NULL? => ${socket == null}");
    debugPrint("==================================================");

    if (socket == null) {
      debugPrint("❌ SOCKET IS NULL, LISTENERS NOT ATTACHED");
      return;
    }

    socket.off("message:new");
    socket.off("message:seen");
    socket.off("message:delete");

    debugPrint("🧹 OLD SOCKET LISTENERS REMOVED");

    socket.on("message:new", (data) {
      try {
        debugPrint("==================================================");
        debugPrint("📩 SOCKET EVENT => message:new");
        debugPrint("➡️ RAW DATA => $data");
        debugPrint("==================================================");

        final msg = MessageModel.fromJson(Map<String, dynamic>.from(data));

        debugPrint("✅ PARSED NEW MESSAGE");
        debugPrint("➡️ MESSAGE ID => ${msg.id}");
        debugPrint("➡️ PROPOSAL ID => ${msg.proposalId}");
        debugPrint("➡️ SENDER ID => ${msg.senderId}");
        debugPrint("➡️ TEXT => ${msg.message}");

        addMessageSocket(msg.proposalId, msg);
      } catch (e) {
        debugPrint("❌ SOCKET message:new PARSE ERROR => $e");
      }
    });

    socket.on("message:seen", (data) {
      try {
        debugPrint("==================================================");
        debugPrint("👁 SOCKET EVENT => message:seen");
        debugPrint("➡️ RAW DATA => $data");
        debugPrint("==================================================");

        final map = Map<String, dynamic>.from(data);
        final proposalId =
            (map["proposalId"] ?? map["proposal_id"] ?? "").toString();
        final messageId =
            (map["messageId"] ?? map["message_id"] ?? "").toString();

        debugPrint("➡️ PROPOSAL ID => $proposalId");
        debugPrint("➡️ MESSAGE ID => $messageId");

        if (proposalId.isEmpty || messageId.isEmpty) {
          debugPrint("⚠️ message:seen ignored due to empty ids");
          return;
        }

        markSeenSocket(proposalId, messageId);
      } catch (e) {
        debugPrint("❌ SOCKET message:seen PARSE ERROR => $e");
      }
    });

    socket.on("message:delete", (data) {
      try {
        debugPrint("==================================================");
        debugPrint("🗑 SOCKET EVENT => message:delete");
        debugPrint("➡️ RAW DATA => $data");
        debugPrint("==================================================");

        final map = Map<String, dynamic>.from(data);
        final proposalId =
            (map["proposalId"] ?? map["proposal_id"] ?? "").toString();
        final messageId =
            (map["messageId"] ?? map["message_id"] ?? "").toString();

        debugPrint("➡️ PROPOSAL ID => $proposalId");
        debugPrint("➡️ MESSAGE ID => $messageId");

        if (proposalId.isEmpty || messageId.isEmpty) {
          debugPrint("⚠️ message:delete ignored due to empty ids");
          return;
        }

        deleteMessageSocket(proposalId, messageId);
      } catch (e) {
        debugPrint("❌ SOCKET message:delete PARSE ERROR => $e");
      }
    });

    debugPrint("✅ FREELANCER GLOBAL SOCKET LISTENERS ATTACHED");
  }

  Future<void> initForProposal(String proposalId) async {
    debugPrint("==================================================");
    debugPrint("🚀 FREELANCER INIT FOR PROPOSAL");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("==================================================");

    await connectSocket();
    attachGlobalListeners();
    joinProposalRoom(proposalId);
    await loadMessages(proposalId);

    debugPrint("✅ FREELANCER INIT FOR PROPOSAL COMPLETE => $proposalId");
  }

  void joinProposalRoom(String proposalId) {
    debugPrint("==================================================");
    debugPrint("🏠 FREELANCER JOIN PROPOSAL ROOM");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("==================================================");

    if (_joinedRooms.contains(proposalId)) {
      debugPrint("⚠️ ROOM ALREADY JOINED => proposal_$proposalId");
      return;
    }

    _joinedRooms.add(proposalId);
    ChatSocketService.joinProposalRoom(proposalId);

    debugPrint("✅ ROOM JOIN EMIT SENT => proposal_$proposalId");
  }

  Future<void> loadMessages(String proposalId) async {
    try {
      debugPrint("==================================================");
      debugPrint("📥 FREELANCER LOAD MESSAGES CALLED");
      debugPrint("➡️ PROPOSAL ID => $proposalId");
      debugPrint("==================================================");

      isLoading.value = true;

      final list = await FreelancerMessagesRepo.fetchMessages(proposalId);

      debugPrint("✅ FETCH MESSAGES RESPONSE");
      debugPrint("➡️ TOTAL FETCHED => ${list.length}");

      if (!chats.containsKey(proposalId)) {
        chats[proposalId] = [];
      }

      final existing = chats[proposalId] ?? [];
      final ids = existing.map((e) => e.id).toSet();

      debugPrint("➡️ EXISTING LOCAL COUNT => ${existing.length}");

      for (final msg in list) {
        if (!ids.contains(msg.id)) {
          existing.add(msg);
          debugPrint("➕ MESSAGE ADDED FROM API => ${msg.id}");
        } else {
          debugPrint("⚠️ DUPLICATE MESSAGE SKIPPED => ${msg.id}");
        }
      }

      existing.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aDate.compareTo(bDate);
      });

      chats[proposalId] = List<MessageModel>.from(existing);
      _refreshUnreadForProposal(proposalId);
    } catch (e) {
      debugPrint("❌ FREELANCER LOAD MESSAGES ERROR => $e");
    } finally {
      isLoading.value = false;
      debugPrint("🛑 FREELANCER LOAD MESSAGES END");
      debugPrint("➡️ isLoading => ${isLoading.value}");
    }
  }

  Future<void> sendMessage(String proposalId) async {
    final text = messageCtrl.text.trim();

    debugPrint("==================================================");
    debugPrint("📤 FREELANCER SEND MESSAGE CALLED");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ TEXT => $text");
    debugPrint("==================================================");

    if (text.isEmpty) {
      debugPrint("⚠️ SEND BLOCKED => EMPTY TEXT");
      return;
    }

    if (isSending.value) {
      debugPrint("⚠️ SEND BLOCKED => ALREADY SENDING");
      return;
    }

    try {
      isSending.value = true;

      final msg = await FreelancerMessagesRepo.sendMessage(
        proposalId: proposalId,
        message: text,
      );

      if (msg != null) {
        debugPrint("✅ SEND MESSAGE SUCCESS");
        debugPrint("➡️ MESSAGE ID => ${msg.id}");
        debugPrint("➡️ MESSAGE TEXT => ${msg.message}");
        addMessageSocket(proposalId, msg);
      } else {
        debugPrint("⚠️ SEND MESSAGE RESPONSE NULL");
      }

      messageCtrl.clear();
      debugPrint("🧹 MESSAGE INPUT CLEARED");
    } catch (e) {
      debugPrint("❌ SEND MESSAGE ERROR => $e");
    } finally {
      isSending.value = false;
      debugPrint("🛑 FREELANCER SEND MESSAGE END");
      debugPrint("➡️ isSending => ${isSending.value}");
    }
  }

  Future<void> markAllIncomingSeen(String proposalId) async {
    debugPrint("==================================================");
    debugPrint("👁 FREELANCER MARK ALL INCOMING SEEN");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("==================================================");

    final list = chats[proposalId] ?? [];

    for (final msg in list) {
      final isIncoming = msg.senderId != currentUserId;
      final isUnread = msg.isRead == 0;

      debugPrint(
        "➡️ CHECK MESSAGE => id:${msg.id}, sender:${msg.senderId}, isIncoming:$isIncoming, isUnread:$isUnread",
      );

      if (isIncoming && isUnread) {
        await markSeen(proposalId, msg.id);
      }
    }

    debugPrint("✅ FREELANCER MARK ALL INCOMING SEEN COMPLETE");
  }

  Future<void> markSeen(String proposalId, String messageId) async {
    debugPrint("==================================================");
    debugPrint("👁 FREELANCER MARK SEEN CALLED");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ MESSAGE ID => $messageId");
    debugPrint("==================================================");

    if (_seenIds.contains(messageId)) {
      debugPrint("⚠️ MARK SEEN SKIPPED => ALREADY MARKED");
      return;
    }

    _seenIds.add(messageId);

    try {
      final ok = await FreelancerMessagesRepo.markSeen(messageId);

      debugPrint("➡️ MARK SEEN API RESPONSE => $ok");

      if (ok) {
        markSeenSocket(proposalId, messageId);
        debugPrint("✅ MARK SEEN LOCAL UPDATE DONE");
      } else {
        debugPrint("⚠️ MARK SEEN API RETURNED FALSE");
      }
    } catch (e) {
      debugPrint("❌ MARK SEEN ERROR => $e");
    }
  }

  Future<void> deleteMessage(String proposalId, String messageId) async {
    debugPrint("==================================================");
    debugPrint("🗑 FREELANCER DELETE MESSAGE CALLED");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ MESSAGE ID => $messageId");
    debugPrint("==================================================");

    try {
      final ok = await FreelancerMessagesRepo.deleteMessage(messageId);

      debugPrint("➡️ DELETE MESSAGE API RESPONSE => $ok");

      if (ok) {
        deleteMessageSocket(proposalId, messageId);
        ChatSocketService.emitDelete(
          proposalId: proposalId,
          messageId: messageId,
        );
        debugPrint("✅ DELETE MESSAGE LOCAL + SOCKET DONE");
      } else {
        debugPrint("⚠️ DELETE MESSAGE API RETURNED FALSE");
      }
    } catch (e) {
      debugPrint("❌ DELETE MESSAGE ERROR => $e");
    }
  }

  void addMessageSocket(String proposalId, MessageModel msg) {
    debugPrint("==================================================");
    debugPrint("➕ FREELANCER ADD MESSAGE SOCKET");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ MESSAGE ID => ${msg.id}");
    debugPrint("➡️ SENDER ID => ${msg.senderId}");
    debugPrint("➡️ IS READ => ${msg.isRead}");
    debugPrint("==================================================");

    final list = chats[proposalId] ?? [];
    final exists = list.any((e) => e.id == msg.id);

    if (!exists) {
      list.add(msg);
      debugPrint("✅ MESSAGE INSERTED");
    } else {
      debugPrint("⚠️ MESSAGE DUPLICATE SKIPPED");
    }

    list.sort((a, b) {
      final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return aDate.compareTo(bDate);
    });

    chats[proposalId] = List<MessageModel>.from(list);

    debugPrint(
        "➡️ TOTAL MESSAGES AFTER INSERT => ${chats[proposalId]?.length ?? 0}");

    _refreshUnreadForProposal(proposalId);
  }

  void markSeenSocket(String proposalId, String messageId) {
    debugPrint("==================================================");
    debugPrint("✅ FREELANCER MARK SEEN SOCKET UPDATE");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ MESSAGE ID => $messageId");
    debugPrint("==================================================");

    final list = chats[proposalId] ?? [];
    final updated = list
        .map((m) => m.id == messageId ? m.copyWith(isRead: 1) : m)
        .toList();

    chats[proposalId] = updated;
    _refreshUnreadForProposal(proposalId);
  }

  void deleteMessageSocket(String proposalId, String messageId) {
    debugPrint("==================================================");
    debugPrint("🗑 FREELANCER DELETE MESSAGE SOCKET UPDATE");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ MESSAGE ID => $messageId");
    debugPrint("==================================================");

    final list = chats[proposalId] ?? [];
    final before = list.length;

    chats[proposalId] = list.where((m) => m.id != messageId).toList();

    final after = chats[proposalId]?.length ?? 0;

    debugPrint("➡️ BEFORE COUNT => $before");
    debugPrint("➡️ AFTER COUNT => $after");

    _refreshUnreadForProposal(proposalId);
  }

  void _refreshUnreadForProposal(String proposalId) {
    final list = chats[proposalId] ?? [];

    final unread = list
        .where((m) => m.isRead == 0 && m.senderId != currentUserId)
        .length;

    unreadByProposal[proposalId] = unread;

    debugPrint("==================================================");
    debugPrint("🔄 FREELANCER REFRESH UNREAD COUNT");
    debugPrint("➡️ PROPOSAL ID => $proposalId");
    debugPrint("➡️ CURRENT USER ID => $currentUserId");
    debugPrint("➡️ UNREAD COUNT => $unread");
    debugPrint("==================================================");
  }

  int unreadCountForProposal(String proposalId) {
    final count = unreadByProposal[proposalId] ?? 0;
    debugPrint("📌 FREELANCER UNREAD COUNT => $proposalId : $count");
    return count;
  }

  List<MessageModel> messagesOf(String proposalId) {
    final list = chats[proposalId] ?? [];
    debugPrint("📌 FREELANCER MESSAGES OF PROPOSAL => $proposalId : ${list.length}");
    return list;
  }
}