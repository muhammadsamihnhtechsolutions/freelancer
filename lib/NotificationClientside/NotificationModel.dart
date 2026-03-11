class ClientNotificationModel {

  final String id;
  final String userId;
  final String userRole;
  final String type;
  final String message;
  final String referenceId;
  final int isRead;
  final DateTime createdAt;

  ClientNotificationModel({
    required this.id,
    required this.userId,
    required this.userRole,
    required this.type,
    required this.message,
    required this.referenceId,
    required this.isRead,
    required this.createdAt,
  });

  factory ClientNotificationModel.fromJson(Map<String, dynamic> json) {

    return ClientNotificationModel(
      id: json["id"] ?? "",
      userId: json["user_id"] ?? "",
      userRole: json["user_role"] ?? "",
      type: json["type"] ?? "",
      message: json["message"] ?? "",
      referenceId: json["reference_id"] ?? "",
      isRead: json["is_read"] ?? 0,
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}