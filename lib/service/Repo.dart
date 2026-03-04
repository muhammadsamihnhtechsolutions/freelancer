import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';
import 'package:freelancer_app/loginsignup/SignUpModel.dart';
import 'package:freelancer_app/service/ApiConstant.dart' show ApiConstants;
import 'package:freelancer_app/service/ApiService.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobCatogeryModel.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobPostModel.dart';

import '../FreelancerDashboard/findjob/FreeelanceFindJobModel.dart';
import '../FreelancerDashboard/myperposal/ProposelModel.dart';
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
class ProposalRepo {

  static Future<List<ProposalModel>> getMyProposals() async {

    final url = "${ApiConstants.baseUrl}/proposals/my";

    print("--------------------------------------------------");
    print("🔵 FETCHING MY PROPOSALS");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,          // ⭐ TOKEN ENABLE
      role: "freelancer",  // ⭐ FREELANCER TOKEN
    );

    print("⬇️ RAW RESPONSE → $res");

    final list = (res['data'] as List)
        .map((e) => ProposalModel.fromJson(e))
        .toList();

    print("✅ Parsed ${list.length} proposals");

    return list;
  }

}
class JobsRepo {
  /// 🔹 Fetch Open Jobs (No token needed)
  static Future<List<JobModel>> getOpenJobs() async {
    final url = "${ApiConstants.baseUrl}/jobs/all/open";

    print("🔵 FETCHING OPEN JOBS…");
    print("➡️ URL: $url");

    final res = await ApiService.get(url);

    if (res["success"] == true) {
      List list = res["data"];
      print("📥 JOB COUNT → ${list.length}");

      return list.map((e) => JobModel.fromJson(e)).toList();
    } else {
      throw Exception(res["message"] ?? "Failed to load jobs");
    }
  }
}



class JobPostRepo {
  /// 🔹 Fetch job categories (Client only)
  static Future<List<CategoryModel>> fetchCategories() async {
    final url = ApiConstants.getCategories;

    print("🔵 FETCHING CATEGORIES… $url");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "client",   // ⭐ ROLE BASED TOKEN
    );

    List list = res["data"] ?? [];
    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }

  /// 🔹 Post a new job (Client only)
  static Future<dynamic> createJob(JobPostModel job) async {
    final url = ApiConstants.createJob;

    print("-----------------------------------");
    print("🟣 POSTING JOB → $url");
    print("📤 Payload → ${job.toJson()}");
    print("-----------------------------------");

    // ❗ Validation
    if (job.categoryId.isEmpty) {
      throw Exception("Category is required");
    }

    // ⭐ Token required → ROLE MUST BE CLIENT
    final res = await ApiService.post(
      url,
      job.toJson(),
      auth: true,
      role: "client",   // ⭐ MOST IMPORTANT
    );

    return res;
  }
}
class FreelancerProfileRepo {

  /// 🔹 Get freelancer profile
  static Future<FreelancerProfileModel> getFreelancerProfile() async {

    final url = ApiConstants.freelancerProfile;

    print("-----------------------------------");
    print("🔵 FETCHING FREELANCER PROFILE → $url");
    print("-----------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "freelancer",
    );

    print("⬇️ PROFILE RESPONSE → $res");

    final data = res["data"];

    return FreelancerProfileModel.fromJson(data);

  }

}