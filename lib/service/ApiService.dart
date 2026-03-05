


// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const Duration timeout = Duration(seconds: 20);

//   /// ----------------------------------------------------
//   /// READ TOKEN BASED ON ROLE
//   /// ----------------------------------------------------
//   static Future<String?> _getToken(String? role) async {
//     final prefs = await SharedPreferences.getInstance();

//     if (role == "client") {
//       return prefs.getString("client_token");
//     } else if (role == "freelancer") {
//       return prefs.getString("freelancer_token");
//     }

//     return null;
//   }

//   /// ----------------------------------------------------
//   /// COMMON HEADERS
//   /// ----------------------------------------------------
//   static Future<Map<String, String>> _headers({
//     required bool auth,
//     String? role,
//   }) async {
//     String? token = auth ? await _getToken(role) : null;

//     return {
//       "Content-Type": "application/json",
//       if (auth && token != null && token.isNotEmpty) ...{
//         "Authorization": "Bearer $token",
//       },
//     };
//   }

//   /// ----------------------------------------------------
//   /// POST REQUEST
//   /// ----------------------------------------------------
//   static Future<dynamic> post(
//     String url,
//     Map body, {
//     bool auth = false,
//     String? role,
//   }) async {
//     final headers = await _headers(auth: auth, role: role);

//     debugPrint("⬆️ POST: $url");
//     debugPrint("📤 Body: ${jsonEncode(body)}");

//     final res = await http
//         .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
//         .timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ----------------------------------------------------
//   /// GET REQUEST
//   /// ----------------------------------------------------
//   static Future<dynamic> get(
//     String url, {
//     bool auth = false,
//     String? role,
//   }) async {
//     try {
//       final headers = await _headers(auth: auth, role: role);

//       print("⬆️ GET: $url");
//       print("🔐 ROLE → $role");
//       print("🔐 HEADER → $headers");

//       final response = await http.get(Uri.parse(url), headers: headers);

//       print("⬇️ Response (${response.statusCode}): ${response.body}");

//       return _handle(response);
//     } catch (e) {
//       print("❌ GET ERROR → $e");
//       rethrow;
//     }
//   }

//   /// ----------------------------------------------------
//   /// PUT REQUEST
//   /// ----------------------------------------------------
//   static Future<dynamic> put(
//     String url,
//     Map body, {
//     bool auth = false,
//     String? role,
//   }) async {
//     final headers = await _headers(auth: auth, role: role);

//     debugPrint("⬆️ PUT: $url");

//     final res = await http
//         .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
//         .timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ----------------------------------------------------
//   /// DELETE REQUEST
//   /// ----------------------------------------------------
//   static Future<dynamic> delete(
//     String url, {
//     bool auth = false,
//     String? role,
//   }) async {
//     final headers = await _headers(auth: auth, role: role);

//     debugPrint("⬆️ DELETE: $url");

//     final res = await http.delete(Uri.parse(url), headers: headers).timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ----------------------------------------------------
//   /// HANDLE SERVER RESPONSE
//   /// ----------------------------------------------------
//   static dynamic _handle(http.Response res) {
//     final code = res.statusCode;

//     try {
//       final data = jsonDecode(res.body);

//       if (code >= 200 && code < 300) return data;

//       if (code == 401) {
//         Get.snackbar("Session Expired", "Please login again");
//         return Future.error("Unauthorized");
//       }

//       final msg = data["message"] ?? "Something went wrong";
//       return Future.error(msg);
//     } catch (e) {
//       return Future.error("Invalid server response");
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration timeout = Duration(seconds: 20);

  /// ----------------------------------------------------
  /// READ TOKEN BASED ON ROLE
  /// ----------------------------------------------------
  static Future<String?> _getToken(String? role) async {
    final prefs = await SharedPreferences.getInstance();

    if (role == "client") {
      return prefs.getString("client_token");
    } else if (role == "freelancer") {
      return prefs.getString("freelancer_token");
    }

    return null;
  }

  /// ----------------------------------------------------
  /// COMMON HEADERS
  /// ----------------------------------------------------
  static Future<Map<String, String>> _headers({
    required bool auth,
    String? role,
  }) async {
    String? token = auth ? await _getToken(role) : null;

    return {
      "Content-Type": "application/json",
      if (auth && token != null && token.isNotEmpty) ...{
        "Authorization": "Bearer $token",
      },
    };
  }

  /// ----------------------------------------------------
  /// POST REQUEST
  /// ----------------------------------------------------
  static Future<dynamic> post(
    String url,
    Map body, {
    bool auth = false,
    String? role,
  }) async {
    final headers = await _headers(auth: auth, role: role);

    debugPrint("⬆️ POST: $url");
    debugPrint("📤 Body: ${jsonEncode(body)}");

    final res = await http
        .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ----------------------------------------------------
  /// GET REQUEST
  /// ----------------------------------------------------
  static Future<dynamic> get(
    String url, {
    bool auth = false,
    String? role,
  }) async {
    try {
      final headers = await _headers(auth: auth, role: role);

      print("⬆️ GET: $url");
      print("🔐 ROLE → $role");
      print("🔐 HEADER → $headers");

      final response = await http.get(Uri.parse(url), headers: headers);

      print("⬇️ Response (${response.statusCode}): ${response.body}");

      return _handle(response);
    } catch (e) {
      print("❌ GET ERROR → $e");
      rethrow;
    }
  }

  /// ----------------------------------------------------
  /// PUT REQUEST
  /// ----------------------------------------------------
  static Future<dynamic> put(
    String url,
    Map body, {
    bool auth = false,
    String? role,
  }) async {
    final headers = await _headers(auth: auth, role: role);

    debugPrint("⬆️ PUT: $url");

    final res = await http
        .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ----------------------------------------------------
  /// DELETE REQUEST
  /// ----------------------------------------------------
  static Future<dynamic> delete(
    String url, {
    bool auth = false,
    String? role,
  }) async {
    final headers = await _headers(auth: auth, role: role);

    debugPrint("⬆️ DELETE: $url");

    final res = await http.delete(Uri.parse(url), headers: headers).timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ----------------------------------------------------
  /// HANDLE SERVER RESPONSE
  /// ----------------------------------------------------
  static dynamic _handle(http.Response res) {
    final code = res.statusCode;

    try {
      final data = jsonDecode(res.body);

      if (code >= 200 && code < 300) return data;

      if (code == 401) {
        Get.snackbar("Session Expired", "Please login again");
        return Future.error("Unauthorized");
      }

      final msg = data["message"] ?? "Something went wrong";
      return Future.error(msg);
    } catch (e) {
      return Future.error("Invalid server response");
    }
  }
  static Future<dynamic> patch(
  String url,
  Map body, {
  bool auth = false,
  String? role,
}) async {
  final headers = await _headers(auth: auth, role: role);

  debugPrint("⬆️ PATCH: $url");
  debugPrint("📤 Body: ${jsonEncode(body)}");

  final res = await http
      .patch(Uri.parse(url), headers: headers, body: jsonEncode(body))
      .timeout(timeout);

  debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

  return _handle(res);
}
}