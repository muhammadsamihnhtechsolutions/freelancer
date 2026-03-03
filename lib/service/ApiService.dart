// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static const Duration timeout = Duration(seconds: 20);

//   /// ------------------------------------------
//   /// SAFE SharedPreferences initialize once
//   /// ------------------------------------------
//   static SharedPreferences? _prefs;

//   static Future<void> _initPrefs() async {
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//       debugPrint("🔧 SharedPreferences Initialized");
//     }
//   }

//   /// ------------------------------------------
//   /// TOKEN SAVE / LOAD
//   /// ------------------------------------------
//   static Future<void> saveToken(String token) async {
//     await _initPrefs();
//     await _prefs!.setString("token", token);
//     debugPrint("🔐 Token Saved: $token");
//   }

//   static Future<String?> getToken() async {
//     await _initPrefs();
//     final token = _prefs!.getString("token");
//     debugPrint("📦 Loaded Token: $token");
//     return token;
//   }

//   /// ------------------------------------------
//   /// HEADERS (Auth optional)
//   /// ------------------------------------------
//   static Future<Map<String, String>> _headers({bool includeAuth = true}) async {
//     await _initPrefs();

//     String? token;

//     if (includeAuth) {
//       token = _prefs!.getString("token"); // SAFE
//     }

//     return {
//       "Content-Type": "application/json",
//       if (includeAuth && token != null && token.isNotEmpty)
//         "Authorization": "Bearer $token",
//     };
//   }

//   /// ------------------------------------------
//   /// POST REQUEST  (auth optional)
//   /// ------------------------------------------
//   static Future<dynamic> post(
//     String url,
//     Map body, {
//     bool auth = true,
//   }) async {
//     final headers = await _headers(includeAuth: auth);

//     debugPrint("⬆️ POST: $url");
//     debugPrint("📤 Body: ${jsonEncode(body)}");
//     debugPrint("📌 Headers: $headers");

//     final res = await http
//         .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
//         .timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ------------------------------------------
//   /// GET REQUEST
//   /// ------------------------------------------
//   static Future<dynamic> get(String url) async {
//     final headers = await _headers();

//     debugPrint("⬆️ GET: $url");

//     final res =
//         await http.get(Uri.parse(url), headers: headers).timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ------------------------------------------
//   /// PUT REQUEST
//   /// ------------------------------------------
//   static Future<dynamic> put(String url, Map body) async {
//     final headers = await _headers();

//     debugPrint("⬆️ PUT: $url");

//     final res = await http
//         .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
//         .timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res);
//   }

//   /// ------------------------------------------
//   /// DELETE REQUEST
//   /// ------------------------------------------
//   static Future<dynamic> delete(String url) async {
//     final headers = await _headers();

//     debugPrint("⬆️ DELETE: $url");

//     final res =
//         await http.delete(Uri.parse(url), headers: headers).timeout(timeout);

//     debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

//     return _handle(res); // 🔥 CORRECTED HERE
//   }

//   /// ------------------------------------------
//   /// HANDLE SERVER RESPONSE
//   /// ------------------------------------------
//   static dynamic _handle(http.Response res) {
//     final code = res.statusCode;

//     try {
//       final data = jsonDecode(res.body);

//       if (code >= 200 && code < 300) return data;

//       if (code == 401) {
//         Get.snackbar("Session Expired", "Please login again");
//         debugPrint("❌ 401 Unauthorized");
//         return Future.error("Unauthorized");
//       }

//       final msg = data["message"] ?? "Something went wrong";
//       debugPrint("❌ API Error: $msg");

//       return Future.error(msg);
//     } catch (e) {
//       debugPrint("❌ JSON Parse Error: $e");
//       return Future.error("Invalid server response");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration timeout = Duration(seconds: 20);

  /// ------------------------------------------
  /// SIMPLE HEADERS (NO AUTH)
  /// ------------------------------------------
  static Map<String, String> _headers({bool includeAuth = false, String? token}) {
    return {
      "Content-Type": "application/json",
      if (includeAuth && token != null && token.isNotEmpty)
        "Authorization": "Bearer $token",
    };
  }

  /// ------------------------------------------
  /// POST REQUEST
  /// ------------------------------------------
  static Future<dynamic> post(
    String url,
    Map body, {
    bool auth = false,
    String? token,
  }) async {
    final headers = _headers(includeAuth: auth, token: token);

    debugPrint("⬆️ POST: $url");
    debugPrint("📤 Body: ${jsonEncode(body)}");

    final res = await http
        .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ------------------------------------------
  /// GET REQUEST
  /// ------------------------------------------
  static Future<dynamic> get(String url, {bool auth = false, String? token}) async {
    final headers = _headers(includeAuth: auth, token: token);

    debugPrint("⬆️ GET: $url");

    final res =
        await http.get(Uri.parse(url), headers: headers).timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ------------------------------------------
  /// PUT REQUEST
  /// ------------------------------------------
  static Future<dynamic> put(
    String url,
    Map body, {
    bool auth = false,
    String? token,
  }) async {
    final headers = _headers(includeAuth: auth, token: token);

    debugPrint("⬆️ PUT: $url");

    final res = await http
        .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
        .timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ------------------------------------------
  /// DELETE REQUEST
  /// ------------------------------------------
  static Future<dynamic> delete(String url, {bool auth = false, String? token}) async {
    final headers = _headers(includeAuth: auth, token: token);

    debugPrint("⬆️ DELETE: $url");

    final res = await http
        .delete(Uri.parse(url), headers: headers)
        .timeout(timeout);

    debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

    return _handle(res);
  }

  /// ------------------------------------------
  /// HANDLE SERVER RESPONSE
  /// ------------------------------------------
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
}