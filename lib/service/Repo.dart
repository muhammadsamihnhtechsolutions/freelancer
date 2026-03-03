import 'package:freelancer_app/loginsignup/SignUpModel.dart';
import 'package:freelancer_app/service/ApiConstant.dart' show ApiConstants;
import 'package:freelancer_app/service/ApiService.dart';

import '../loginsignup/LoginResponceModel.dart';


class AuthRepo {
  Future<LoginResponse> login(String email, String password) async {
    final body = {
      "email": email.trim(),
      "password": password.trim(),
    };

    final response = await ApiService.post(ApiConstants.login, body);

    // Convert JSON to model
    final parsed = LoginResponse.fromJson(response);

    // Save token
    // await ApiService.saveToken(parsed.token);

    return parsed;
  }
  
}

class SignupRepo {
  static Future<dynamic> register(SignupModel data) async {
    final url = ApiConstants.register;

    print("🔵 SIGNUP REQUEST STARTED...");
print("REGISTER URL → ${ApiConstants.register}");
    print("📤 Payload: ${data.toJson()}");

    final res = await ApiService.post(
      url,
      data.toJson(),
      auth: false, // SIGNUP mei token nahi hota
    );

    print("✅ SIGNUP RESPONSE: $res");
    return res;
  }
}