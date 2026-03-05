import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';
import 'package:freelancer_app/loginsignup/SignUpModel.dart';
import 'package:freelancer_app/service/ApiConstant.dart' show ApiConstants;
import 'package:freelancer_app/service/ApiService.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
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

  /// ==================================================
  /// 1) FREELANCER: OPEN JOBS
  /// GET /jobs/all/open
  /// ==================================================
  static Future<List<JobModel>> getOpenJobs() async {
    final url = "${ApiConstants.baseUrl}/jobs/all/open";

    print("--------------------------------------------------");
    print("🔵 FETCHING OPEN JOBS (FREELANCER)");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    // ✅ agar backend public allow karta hai to auth:false bhi chalega
    final res = await ApiService.get(
      url,
      auth: true,
      role: "freelancer",
    );

    final list = (res["data"] as List? ?? []);
    print("✅ OPEN JOBS LOADED → ${list.length}");

    return list.map((e) => JobModel.fromJson(e)).toList();
  }

  /// ==================================================
  /// 2) CLIENT: MY JOBS LIST
  /// GET /jobs
  /// ==================================================
static Future<List<AdminJobModel>> getClientJobs() async {

  final url = "${ApiConstants.baseUrl}/jobs";

  final res = await ApiService.get(
    url,
    auth: true,
    role: "client",
  );

  final list = res["data"] as List;

  return list
      .map((e) => AdminJobModel.fromJson(e))
      .toList();
}
  /// ==================================================
  /// 3) CLIENT: UPDATE JOB
  /// PATCH /jobs/{jobId}
  /// ==================================================
  static Future<dynamic> updateJob(String jobId, Map payload) async {
    final url = "${ApiConstants.baseUrl}/jobs/$jobId";

    print("-----------------------------------");
    print("🟣 UPDATING JOB");
    print("➡️ URL → $url");
    print("📤 Payload → $payload");
    print("-----------------------------------");

    final res = await ApiService.patch(
      url,
      payload,
      auth: true,
      role: "client",
    );

    return res;
  }

  /// ==================================================
  /// 4) CLIENT: CLOSE JOB
  /// PATCH /jobs/{jobId}/close
  /// ==================================================
  static Future<dynamic> closeJob(String jobId) async {
    final url = "${ApiConstants.baseUrl}/jobs/$jobId/close";

    print("🔴 CLOSING JOB → $jobId");
    print("➡️ URL → $url");

    final res = await ApiService.patch(
      url,
      {},
      auth: true,
      role: "client",
    );

    return res;
  }

  /// ==================================================
  /// 5) CLIENT: GET PROPOSALS OF A JOB
  /// GET /proposals/job/{jobId}
  /// ==================================================
  static Future<List<ProposalModel>> getJobProposals(String jobId) async {
    final url = "${ApiConstants.baseUrl}/proposals/job/$jobId";

    print("--------------------------------------------------");
    print("🔵 FETCHING JOB PROPOSALS (CLIENT)");
    print("➡️ JOB ID → $jobId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "client",
    );

    final list = (res["data"] as List? ?? []);
    print("✅ JOB PROPOSALS LOADED → ${list.length}");

    return list.map((e) => ProposalModel.fromJson(e)).toList();
  }

  /// ==================================================
  /// 6) CLIENT: ACCEPT / REJECT PROPOSAL
  /// PATCH /proposals/{proposalId}/status
  /// ==================================================
  static Future<dynamic> updateProposalStatus(
    String proposalId,
    String status,
  ) async {
    final url = "${ApiConstants.baseUrl}/proposals/$proposalId/status";

    print("-----------------------------------");
    print("🟠 UPDATING PROPOSAL STATUS");
    print("➡️ PROPOSAL ID → $proposalId");
    print("➡️ STATUS → $status");
    print("➡️ URL → $url");
    print("-----------------------------------");

    final res = await ApiService.patch(
      url,
      {"status": status},
      auth: true,
      role: "client",
    );

    return res;
  }

  static Future<dynamic> acceptProposal(String proposalId) {
    return updateProposalStatus(proposalId, "accepted");
  }

  static Future<dynamic> rejectProposal(String proposalId) {
    return updateProposalStatus(proposalId, "rejected");
  }
}
// class JobsRepo {
//   /// 🔹 Fetch Open Jobs (No token needed)
//   static Future<List<JobModel>> getOpenJobs() async {
//     final url = "${ApiConstants.baseUrl}/jobs/all/open";

//     print("🔵 FETCHING OPEN JOBS…");
//     print("➡️ URL: $url");

//     final res = await ApiService.get(url);

//     if (res["success"] == true) {
//       List list = res["data"];
//       print("📥 JOB COUNT → ${list.length}");

//       return list.map((e) => JobModel.fromJson(e)).toList();
//     } else {
//       throw Exception(res["message"] ?? "Failed to load jobs");
//     }
//   }
// }



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