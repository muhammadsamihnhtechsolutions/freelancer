class MessageModel {
  final String id;
  final String proposalId;
  final String senderId;
  final String message;
  final int isRead;
  final DateTime? createdAt;

  MessageModel({
    required this.id,
    required this.proposalId,
    required this.senderId,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: (json["id"] ?? "").toString(),
      proposalId: (json["proposal_id"] ?? "").toString(),
      senderId: (json["sender_id"] ?? "").toString(),
      message: (json["message"] ?? "").toString(),
      isRead: _toInt(json["is_read"]),
      createdAt: _parseDate(json["created_at"]),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "proposal_id": proposalId,
      "sender_id": senderId,
      "message": message,
      "is_read": isRead,
      "created_at": createdAt?.toIso8601String(),
    };
  }

  MessageModel copyWith({
    String? id,
    String? proposalId,
    String? senderId,
    String? message,
    int? isRead,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      proposalId: proposalId ?? this.proposalId,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}