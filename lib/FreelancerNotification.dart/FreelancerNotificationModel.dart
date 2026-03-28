import 'dart:convert';

class NotificationModel {
  final String id; // ✅ FIXED (int → String)
  final String title;
  final bool isRead;
  final Map<String, dynamic>? extra;

  NotificationModel({
    required this.id,
    required this.title,
    required this.isRead,
    this.extra,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(), // ✅ SAFE CONVERSION
      title: json['message'] ?? "", // ✅ backend field
      isRead: json['is_read'] == 1,
      extra: _parseExtra(json['extra']),
    );
  }

  // ✅ Safe JSON parse (no crash)
  static Map<String, dynamic>? _parseExtra(dynamic data) {
    try {
      if (data == null) return null;

      if (data is String) {
        return Map<String, dynamic>.from(jsonDecode(data));
      }

      if (data is Map<String, dynamic>) {
        return data;
      }

      return null;
    } catch (e) {
      print("❌ EXTRA PARSE ERROR → $e");
      return null;
    }
  }
}
