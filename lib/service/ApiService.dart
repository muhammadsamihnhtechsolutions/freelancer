


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
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

static Future<String?> getTokenByRole(String? role) async {
  return await _getToken(role);
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

    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(timeout);

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
      .patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      )
      .timeout(timeout);

  debugPrint("⬇️ Response (${res.statusCode}): ${res.body}");

  return _handle(res);
}
/// ----------------------------------------------------
/// MULTIPART FILE UPLOAD
/// ----------------------------------------------------

static Future<dynamic> uploadFile(
  String url,
  File file, {
  required String fieldName,
  bool auth = false,
  String? role,
}) async {

  try {

    final token = auth ? await _getToken(role) : null;

    print("==================================================");
    print("⬆️ MULTIPART UPLOAD: $url");
    print("📁 FILE → ${file.path}");
    print("🔐 ROLE → $role");
    print("==================================================");

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );

    /// Add Authorization header
    if (auth && token != null && token.isNotEmpty) {
      request.headers["Authorization"] = "Bearer $token";
    }

    /// 🔥 Detect image type
    final extension = file.path.split('.').last.toLowerCase();

    MediaType mediaType;

    if (extension == "png") {
      mediaType = MediaType("image", "png");
    } else if (extension == "jpg" || extension == "jpeg") {
      mediaType = MediaType("image", "jpeg");
    } else {
      print("⚠️ Unknown extension → defaulting to jpeg");
      mediaType = MediaType("image", "jpeg");
    }

    /// Add file with content type
    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: mediaType,
      ),
    );

    final streamedResponse =
        await request.send().timeout(timeout);

    final response =
        await http.Response.fromStream(streamedResponse);

    print("⬇️ Upload Response (${response.statusCode}): ${response.body}");

    return _handle(response);

  } catch (e) {

    print("❌ UPLOAD ERROR → $e");

    return Future.error("Upload failed");
  }
}

static Future<dynamic> multipartPost(
  String url,
  Map<String, dynamic> body, {
  required Map<String, File> files,
  bool auth = false,
  String? role,
}) async {
  try {
    final token = auth ? await _getToken(role) : null;

    print("==================================================");
    print("⬆️ MULTIPART POST: $url");
    print("📤 BODY → $body");
    print("📎 FILES → ${files.keys.toList()}");
    print("🔐 ROLE → $role");
    print("==================================================");

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );

    /// Authorization
    if (auth && token != null && token.isNotEmpty) {
      request.headers["Authorization"] = "Bearer $token";
    }

    /// Text fields
    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    /// Files
    for (final entry in files.entries) {
      final file = entry.value;
      final extension = file.path.split('.').last.toLowerCase();

      MediaType mediaType;

      if (extension == "png") {
        mediaType = MediaType("image", "png");
      } else if (extension == "jpg" || extension == "jpeg") {
        mediaType = MediaType("image", "jpeg");
      } else if (extension == "pdf") {
        mediaType = MediaType("application", "pdf");
      } else if (extension == "doc") {
        mediaType = MediaType("application", "msword");
      } else if (extension == "docx") {
        mediaType = MediaType(
          "application",
          "vnd.openxmlformats-officedocument.wordprocessingml.document",
        );
      } else {
        mediaType = MediaType("application", "octet-stream");
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          entry.key,
          file.path,
          contentType: mediaType,
        ),
      );
    }

    final streamedResponse = await request.send().timeout(timeout);
    final response = await http.Response.fromStream(streamedResponse);

    print("⬇️ Response (${response.statusCode}): ${response.body}");

    return _handle(response);
  } catch (e) {
    print("❌ MULTIPART POST ERROR → $e");
    return Future.error("Multipart upload failed");
  }
}

}


