import 'dart:io';

import 'package:freelancer_app/ClientProfilePage/ClientProfileModel.dart';
import 'package:freelancer_app/FreelancerDashboard/Freelancerprofile/FreelancerProfileModel.dart';

import 'package:freelancer_app/FreelancerReviewsubmitModel/FreelancerSubmitReviewModel.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalModel.dart';
import 'package:freelancer_app/loginsignup/SignUpModel.dart';
import 'package:freelancer_app/service/ApiConstant.dart' show ApiConstants;
import 'package:freelancer_app/service/ApiService.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobCatogeryModel.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobPostModel.dart';
import 'package:freelancer_app/view/widgets/freelancerReview/ReviewModel.dart';

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

  static Future<dynamic> startWork(String jobId) async {

    final url = "${ApiConstants.baseUrl}/proposals/$jobId/start";

    print("--------------------------------------------------");
    print("🚀 START WORK API CALL");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    final res = await ApiService.patch(
      url,
      {},                     // ✅ EMPTY BODY REQUIRED
      auth: true,             // ✅ TOKEN ENABLE
      role: "freelancer",     // ✅ ROLE
    );

    print("⬇️ START WORK RESPONSE → $res");
    print("✅ Work Started Successfully");

    return res;
  }

static Future<dynamic> submitWork(String jobId) async {

  final url = "${ApiConstants.baseUrl}/proposals/$jobId/submit";

  print("--------------------------------------------------");
  print("📤 SUBMIT WORK API CALL");
  print("➡️ URL → $url");
  print("--------------------------------------------------");

  final res = await ApiService.patch(
    url,
    {},                     // ✅ EMPTY BODY (same as web)
    auth: true,             // ✅ TOKEN ENABLE
    role: "freelancer",     // ✅ ROLE SAME
  );

  print("⬇️ SUBMIT WORK RESPONSE → $res");
  print("✅ Work Submitted Successfully");

  return res;
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
   final res = await ApiService.get(
      url,
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
   final res = await ApiService.get(
      url,
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

  /// =============================
  /// GET PROFILE
  /// =============================

  static Future<FreelancerProfileModel?> getProfile() async {

    final url = ApiConstants.freelancerProfile;

    print("--------------------------------");
    print("📡 GET FREELANCER PROFILE");
    print("URL → $url");
    print("--------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "freelancer",
    );

    print("⬇️ PROFILE RESPONSE → $res");

    if (res["data"] == null) {

      print("⚠️ PROFILE DOES NOT EXIST");

      return null;

    }

    return FreelancerProfileModel.fromJson(res["data"]);
  }

  /// =============================
  /// CREATE PROFILE
  /// =============================

  static Future<FreelancerProfileModel?> createProfile(
      FreelancerProfileModel profile) async {

    final url = ApiConstants.freelancerProfile;

    print("--------------------------------");
    print("🟢 CREATE FREELANCER PROFILE");
    print("BODY → ${profile.toJson()}");
    print("--------------------------------");

    final res = await ApiService.post(
      url,
      profile.toJson(),
      auth: true,
      role: "freelancer",
    );

    print("⬇️ CREATE RESPONSE → $res");

    return FreelancerProfileModel.fromJson(res["data"]);
  }

  /// =============================
  /// UPDATE PROFILE
  /// =============================

  static Future<FreelancerProfileModel?> updateProfile(
      FreelancerProfileModel profile) async {

    final url = ApiConstants.freelancerProfile;

    print("--------------------------------");
    print("🟡 UPDATE FREELANCER PROFILE");
    print("BODY → ${profile.toJson()}");
    print("--------------------------------");

    final res = await ApiService.put(
      url,
      profile.toJson(),
      auth: true,
      role: "freelancer",
    );

    print("⬇️ UPDATE RESPONSE → $res");

    return FreelancerProfileModel.fromJson(res["data"]);
  }

}

class ClientProposalRepo {

  static Future<List<ClientProposalModel>> getJobProposals(String jobId) async {

    final url = ApiConstants.jobProposals(jobId);

    print("--------------------------------------------------");
    print("🔵 FETCH CLIENT JOB PROPOSALS");
    print("➡️ JOB ID → $jobId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "client",
    );

    print("⬇️ RAW RESPONSE → $res");

    /// safety check
    if (res == null) {

      print("❌ API RESPONSE NULL");

      return [];
    }

    if (res['data'] == null) {

      print("⚠️ DATA FIELD NULL");

      return [];
    }

    final List list = res['data'];

    print("📦 TOTAL PROPOSALS RECEIVED → ${list.length}");

    final proposals = list
        .map((e) {
          print("➡️ PROPOSAL ITEM → $e");
          return ClientProposalModel.fromJson(e);
        })
        .toList();

    print("✅ PARSED PROPOSALS → ${proposals.length}");

    return proposals;
  }
}
class ReviewsRepo {
  static Future<List<ReviewModel>> getUserReviews(String userId) async {
    final url = ApiConstants.userReviews(userId);

    print("--------------------------------------------------");
    print("🟡 FETCH USER REVIEWS");
    print("➡️ USER ID → $userId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "client",
    );

    print("⬇️ RAW RESPONSE → $res");

    /// SAFETY CHECK
    if (res == null) {
      print("❌ API RESPONSE NULL");
      return [];
    }

    if (res['reviews'] == null) {
      print("⚠️ REVIEWS FIELD NULL");
      return [];
    }

    if (res['reviews'] is! List) {
      print("❌ REVIEWS FIELD IS NOT A LIST");
      return [];
    }

    final List list = res['reviews'];

    print("📦 TOTAL REVIEWS RECEIVED → ${list.length}");

    /// OPTIONAL STATS LOG
    if (res['stats'] != null) {
      print("⭐ STATS → ${res['stats']}");
      print("⭐ TOTAL REVIEWS (API) → ${res['stats']['totalReviews']}");
      print("⭐ AVG RATING (API) → ${res['stats']['avgRating']}");
    }

    /// PARSE REVIEWS
    final reviews = list.map((e) {
      print("➡️ REVIEW ITEM → $e");

      try {
        final review = ReviewModel.fromJson(e);

        print("✅ PARSED REVIEW → ${review.name} | Rating: ${review.rating}");

        return review;
      } catch (err) {
        print("❌ REVIEW PARSE ERROR → $err");
        return null;
      }
    }).whereType<ReviewModel>().toList();

    print("--------------------------------------------------");
    print("✅ TOTAL PARSED REVIEWS → ${reviews.length}");
    print("--------------------------------------------------");

    return reviews;
  }
}

class ClientViewDetailsProposalRepo {

  /// ==================================================
  /// ACCEPT / REJECT PROPOSAL
  /// PATCH /proposals/{proposalId}/status
  /// ==================================================

static Future<dynamic> updateProposalStatus(
  String proposalId,
  String status,
) async {

  final url = "${ApiConstants.baseUrl}/proposals/$proposalId/status";

  print("--------------------------------------------------");
  print("🟠 UPDATING PROPOSAL STATUS");
  print("➡️ PROPOSAL ID → $proposalId");
  print("➡️ STATUS → $status");
  print("➡️ URL → $url");
  print("--------------------------------------------------");

  try {

    final res = await ApiService.patch(
      url,
      {
        "status": status
      },
      auth: true,
      role: "client",
    );

    print("⬇️ RAW RESPONSE → $res");

    /// NULL CHECK
    if (res == null) {

      print("❌ ERROR → RESPONSE NULL");

      return {
        "success": false,
        "message": "Server returned null response"
      };
    }

    /// SUCCESS CHECK
    if (res["success"] == true) {

      print("✅ STATUS UPDATED SUCCESSFULLY");

      return res;
    }

    /// API ERROR MESSAGE
    print("❌ API FAILED → ${res["message"]}");

    return {
      "success": false,
      "message": res["message"] ?? "Unknown error"
    };

  } catch (e) {

    print("❌ EXCEPTION OCCURRED");
    print("➡️ ERROR → $e");

    return {
      "success": false,
      "message": e.toString()
    };
  }
}


  /// ACCEPT PROPOSAL
  static Future<dynamic> acceptProposal(String proposalId) async {

    print("--------------------------------------------------");
    print("🟢 ACCEPT PROPOSAL");
    print("➡️ PROPOSAL ID → $proposalId");
    print("--------------------------------------------------");

    return updateProposalStatus(proposalId, "accepted");
  }

  /// REJECT PROPOSAL
  static Future<dynamic> rejectProposal(String proposalId) async {

    print("--------------------------------------------------");
    print("🔴 REJECT PROPOSAL");
    print("➡️ PROPOSAL ID → $proposalId");
    print("--------------------------------------------------");

    return updateProposalStatus(proposalId, "rejected");
  }

// =========================================
  /// APPROVE WORK (LIVE PRODUCTION READY)
  /// =========================================
 static Future<dynamic> approveWork(String jobId) async {
  final url = "${ApiConstants.baseUrl}/proposals/$jobId/approve";

  print("--------------------------------------------------");
  print("🟣 APPROVE WORK (PATCH)");
  print("➡️ JOB ID → $jobId");
  print("➡️ URL → $url");
  print("--------------------------------------------------");

  try {
    final res = await ApiService.patch(
      url,
      {}, // empty body
      auth: true,
      role: "client",
    );

    print("⬇️ APPROVE RESPONSE → $res");

    return res;
  } catch (e) {
    print("❌ APPROVE REPO ERROR → $e");

    return {
      "success": false,
      "message": e.toString(),
    };
  }
}
}

class DashboardRepo {

  /// GET CLIENT JOBS
  static Future<dynamic> getClientJobs(String clientId) async {

    final url = "${ApiConstants.clientJobs}/$clientId";

    print("--------------------------------------------------");
    print("🔵 FETCH CLIENT JOBS");
    print("➡️ CLIENT ID → $clientId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    try {

      final res = await ApiService.get(
        url,
        auth: true,
        role: "client",
      );

      print("⬇️ CLIENT JOBS RESPONSE → $res");

      return res;

    } catch (e) {

      print("❌ CLIENT JOBS ERROR → $e");

      return null;
    }
  }


  /// GET PROPOSALS BY JOB
  static Future<dynamic> getProposalsByJob(String jobId) async {

    final url = "${ApiConstants.proposalsByJob}/$jobId";

    print("--------------------------------------------------");
    print("🟣 FETCH JOB PROPOSALS");
    print("➡️ JOB ID → $jobId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    try {

      final res = await ApiService.get(
        url,
        auth: true,
        role: "client",
      );

      print("⬇️ JOB PROPOSALS RESPONSE → $res");

      return res;

    } catch (e) {

      print("❌ JOB PROPOSALS ERROR → $e");

      return null;
    }
  }
}


class ClientProfileRepo {

  /// ==================================
  /// CREATE / UPDATE PROFILE
  /// ==================================
  static Future<dynamic> saveClientProfile(
    ClientProfileModel profile,
    bool isEdit,
  ) async {

    final url = ApiConstants.clientProfile;

    print("==================================================");
    print("🟠 SAVE CLIENT PROFILE");
    print("➡️ EDIT MODE → $isEdit");
    print("➡️ URL → $url");
    print("➡️ BODY → ${profile.toJson()}");
    print("==================================================");

    try {

      final res = isEdit
          ? await ApiService.put(
              url,
              profile.toJson(),
              auth: true,
              role: "client",
            )
          : await ApiService.post(
              url,
              profile.toJson(),
              auth: true,
              role: "client",
            );

      print("⬇️ SAVE PROFILE RESPONSE → $res");

      return res;

    } catch (e) {

      print("❌ SAVE PROFILE API ERROR → $e");

      return {
        "success": false,
        "message": e.toString(),
      };

    }
  }

  /// ==================================
  /// GET CLIENT PROFILE
  /// ==================================
  static Future<dynamic> getClientProfile() async {

    final url = ApiConstants.clientProfile;

    print("==================================================");
    print("🔵 GET CLIENT PROFILE");
    print("➡️ URL → $url");
    print("==================================================");

    try {

      final res = await ApiService.get(
        url,
        auth: true,
        role: "client",
      );

      print("⬇️ GET PROFILE RESPONSE → $res");

      /// PROFILE NOT FOUND CASE
      if (res["success"] == false) {

        print("⚠️ PROFILE NOT FOUND");

        return {
          "success": false,
          "data": null,
          "message": res["message"]
        };
      }

      return res;

    } catch (e) {

      print("❌ GET PROFILE API ERROR → $e");

      return {
        "success": false,
        "data": null,
        "message": e.toString()
      };

    }
  }
  /// ==================================
/// UPLOAD CLIENT LOGO
/// ==================================

static Future<dynamic> uploadLogo(File imageFile) async {

  final url = ApiConstants.uploadLogo;

  print("==================================================");
  print("🟣 UPLOAD CLIENT LOGO");
  print("➡️ URL → $url");
  print("==================================================");

  try {

    final res = await ApiService.uploadFile(
      url,
      imageFile,
      fieldName: "file",   // ✅ CHANGED
      auth: true,
      role: "client",
    );

    print("⬇️ UPLOAD LOGO RESPONSE → $res");

    return res;

  } catch (e) {

    print("❌ UPLOAD LOGO ERROR → $e");

    return {
      "success": false,
      "message": e.toString(),
    };
  }
}
}
class freelancerprofileclientsiderepo {

  /// 🔹 GET ALL FREELANCERS (search optional)
  static Future<dynamic> fetchFreelancers(String search) async {

    final url =
        "${ApiConstants.publicFreelancers}?search=$search";

    try {

      print("===================================");
      print("🔵 REPO → FETCH FREELANCERS");
      print("➡️ SEARCH → $search");
      print("➡️ URL → $url");
      print("===================================");

      final res = await ApiService.get(
        url,
        auth: false,
      );

      print("⬇️ FREELANCERS LIST RESPONSE → $res");
      print("⬇️ RESPONSE TYPE → ${res.runtimeType}");

      return res;

    } catch (e) {

      print("❌ REPO FETCH FREELANCERS ERROR → $e");
      return null;
    }
  }

  /// 🔹 GET SINGLE FREELANCER PROFILE
  static Future<dynamic> fetchFreelancerProfile(String id) async {

    final url =
        "${ApiConstants.publicFreelancers}/$id";

    try {

      print("===================================");
      print("🔵 REPO → FETCH PROFILE");
      print("➡️ ID → $id");
      print("➡️ URL → $url");
      print("===================================");

      final res = await ApiService.get(
        url,
        auth: false,
      );

      print("⬇️ SINGLE PROFILE RESPONSE → $res");
      print("⬇️ RESPONSE TYPE → ${res.runtimeType}");

      return res;

    } catch (e) {

      print("❌ REPO FETCH PROFILE ERROR → $e");
      return null;
    }
  }
}

class ClientSideNotificationRepo {

  static Future<dynamic> fetchNotifications() async {

    final url = ApiConstants.notifications;

    print("=================================");
    print("🔵 FETCHING NOTIFICATIONS");
    print("➡️ URL → $url");
    print("=================================");

    final res = await ApiService.get(
      url,
      auth: true, 
      role: "client",
    );

    print("⬇️ NOTIFICATION RESPONSE → $res");

    return res;
  }
}

class SubmitProposalRepo {
  static Future<dynamic> submitProposal({
    required Map<String, dynamic> body,
    File? cvFile,
  }) async {
    final url = ApiConstants.submitProposal;

    print("=================================");
    print("🚀 SUBMIT PROPOSAL API");
    print("➡️ URL → $url");
    print("📤 BODY → $body");
    print("📄 CV FILE NAME → ${cvFile?.path.split('/').last ?? "No CV"}");
    print("📁 CV FILE PATH → ${cvFile?.path ?? "No CV"}");
    print("=================================");

    final res = await ApiService.multipartPost(
      url,
      body,
      files: {
        if (cvFile != null) "cv": cvFile,
      },
      auth: true,
      role: "freelancer",
    );

    print("⬇️ SUBMIT PROPOSAL RESPONSE → $res");

    return res;
  }
}

// class SubmitProposalRepo {
//   static Future<dynamic> submitProposal({
//     required Map<String, dynamic> body,
//     required File cvFile,
//   }) async {
//     final url = ApiConstants.submitProposal;

//     print("=================================");
//     print("🚀 SUBMIT PROPOSAL API");
//     print("➡️ URL → $url");
//     print("📤 BODY → $body");
//     print("📄 CV FILE NAME → ${cvFile.path.split('/').last}");
//     print("📁 CV FILE PATH → ${cvFile.path}");
//     print("=================================");

//     final res = await ApiService.multipartPost(
//       url,
//       body,
//       files: {
//         "cv": cvFile,
//       },
//       auth: true,
//       role: "freelancer",
//     );

//     print("⬇️ SUBMIT PROPOSAL RESPONSE → $res");

//     return res;
//   }
// }

// class SubmitProposalRepo {

//   static Future<dynamic> submitProposal(
//     Map<String, dynamic> body,
//   ) async {

//     final url = ApiConstants.submitProposal;

//     print("=================================");
//     print("🚀 SUBMIT PROPOSAL API");
//     print("➡️ URL → $url");
//     print("📤 BODY → $body");
//     print("=================================");

//     final res = await ApiService.post(
//       url,
//       body,
//       auth: true,
//       role: "freelancer",
//     );

//     print("⬇️ SUBMIT PROPOSAL RESPONSE → $res");

//     return res;
//   }
// }
class FreelancerSideNotificationRepo {

  // ---------------- FETCH ALL ----------------
  static Future<dynamic> fetchNotifications() async {

    final url = ApiConstants.Freelancernotifications;

    print("=================================");
    print("🔵 FETCHING FREELANCER NOTIFICATIONS");
    print("➡️ URL → $url");
    print("=================================");

    final res = await ApiService.get(
      url,
      auth: true,
      role: "freelancer",
    );

    print("⬇️ NOTIFICATION RESPONSE → $res");

    return res;
  }

  // ---------------- MARK SINGLE READ ----------------
  static Future<dynamic> markNotificationRead(int id) async {

    final url = ApiConstants.markRead;

    print("=================================");
    print("🟢 MARK NOTIFICATION AS READ");
    print("➡️ URL → $url");
    print("📤 BODY → {id: $id}");
    print("=================================");

    final res = await ApiService.post(
      url,
      {
        "id": id,
      },
      auth: true,
      role: "freelancer",
    );

    print("⬇️ MARK READ RESPONSE → $res");

    return res;
  }

  // ---------------- MARK ALL READ ----------------
  static Future<dynamic> markAllNotificationsRead() async {

    final url = ApiConstants.markAllRead;

    print("=================================");
    print("🟣 MARK ALL NOTIFICATIONS AS READ");
    print("➡️ URL → $url");
    print("=================================");

    final res = await ApiService.post(
      url,
      {},
      auth: true,
      role: "freelancer",
    );

    print("⬇️ MARK ALL READ RESPONSE → $res");

    return res;
  }
}

// class FreelancerSubmitReviewRepo {
//   /// ==================================================
//   /// FREELANCER: SUBMIT REVIEW
//   /// POST /reviews
//   /// ==================================================
//   static Future<Map<String, dynamic>> submitReview({
//     required String jobId,
//     required int rating,
//     required String review,
//   }) async {
//     final url = ApiConstants.freelancerSubmitReview;

//     final payload = {
//       "jobId": jobId,
//       "rating": rating,
//       "review": review,
//     };

//     print("--------------------------------------------------");
//     print("🟣 SUBMITTING REVIEW (FREELANCER)");
//     print("➡️ URL → $url");
//     print("📤 Payload → $payload");
//     print("--------------------------------------------------");

//     final res = await ApiService.post(
//       url,
//       payload,
//       auth: true,
//       role: "freelancer",
//     );

//     print("✅ REVIEW RESPONSE → $res");

//     return {
//       "message": res["message"] ?? "Review submitted successfully",
//       "review": res["review"] != null
//           ? FreelancerSubmitReviewModel.fromJson(res["review"])
//           : null,
//     };
//   }
// }

class FreelancerSubmitReviewRepo {
  static Future<dynamic> submitReview({
    required String jobId,
    required int rating,
    required String review,
  }) async {
    final body = {
      "jobId": jobId,
      "rating": rating,
      "review": review,
    };

    print("--------------------------------------------------");
    print("🟣 SUBMIT REVIEW (POST)");
    print("➡️ JOB ID => $jobId");
    print("➡️ RATING => $rating");
    print("➡️ REVIEW => $review");
    print("➡️ BODY => $body");
    print("--------------------------------------------------");

    final res = await ApiService.post(
      "${ApiConstants.baseUrl}/reviews",
      body,
      auth: true,
      role: "freelancer",
    );

    return res;
  }

  static Future<dynamic> getReviews({
    required String jobId,
  }) async {
    final url = "${ApiConstants.baseUrl}/reviews?jobId=$jobId";

    print("--------------------------------------------------");
    print("🟦 GET REVIEWS");
    print("➡️ JOB ID => $jobId");
    print("➡️ URL => $url");
    print("--------------------------------------------------");

    final res = await ApiService.get(
      url,
      auth: true,
    );

    return res;
  }
}

class ClientSideReviewRepo {
  static Future<dynamic> getReviews(String jobId) async {
    final url = "${ApiConstants.baseUrl}/reviews?jobId=$jobId";

    print("--------------------------------------------------");
    print("🟦 GET REVIEWS");
    print("➡️ JOB ID → $jobId");
    print("➡️ URL → $url");
    print("--------------------------------------------------");

    try {
      final res = await ApiService.get(
        url,
        auth: true,
        role: "client",
      );

      print("⬇️ GET REVIEWS RESPONSE → $res");
      return res;
    } catch (e) {
      print("❌ GET REVIEWS REPO ERROR → $e");
      return {
        "success": false,
        "message": e.toString(),
        "reviews": [],
        "stats": {"totalReviews": 0, "avgRating": 0},
      };
    }
  }

  static Future<dynamic> submitReview({
    required String jobId,
    required int rating,
    required String review,
  }) async {
    final url = "${ApiConstants.baseUrl}/reviews";

    final body = {
      "jobId": jobId,
      "rating": rating,
      "review": review,
    };

    print("--------------------------------------------------");
    print("🟣 SUBMIT REVIEW (POST)");
    print("➡️ JOB ID → $jobId");
    print("➡️ RATING → $rating");
    print("➡️ REVIEW → $review");
    print("➡️ URL → $url");
    print("➡️ BODY → $body");
    print("--------------------------------------------------");

    try {
      final res = await ApiService.post(
        url,
        body,
        auth: true,
        role: "client",
      );

      print("⬇️ SUBMIT REVIEW RESPONSE → $res");
      return res;
    } catch (e) {
      print("❌ SUBMIT REVIEW REPO ERROR → $e");
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}