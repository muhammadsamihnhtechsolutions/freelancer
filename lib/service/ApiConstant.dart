class ApiConstants {
  ApiConstants._(); // Prevent instantiation

  /// ==============================
  /// 🌍 BASE URL
  /// ==============================
static const String baseUrl = "https://freelancesupermarket.hnhsofttechsolutions.com/api";

  /// ==============================
  /// 🔐 AUTH / USER
  /// ==============================
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String getMe = '$baseUrl/users/me';

  static String clientGetReviews(String userId) =>
      "$baseUrl/reviews/user/$userId";


    /// 🔹 Freelancer Profile
  static const String freelancerProfile =
      "$baseUrl/profiles/freelancer";

  static const String publicFreelancers =
      "$baseUrl/public/freelancers";
  static const String clientProfile =
      "$baseUrl/profiles/client";

  /// GET CLIENT PROFILE
  static const String getClientProfile =
      "$baseUrl/profiles/client";
  static const uploadLogo =
    "https://freelancesupermarket.hnhsofttechsolutions.com/api/upload/logo";
  /// ==============================
  /// 🧑‍💼 CLIENT PROFILE
  /// ==============================
  static const String clientProfileCreate = '$baseUrl/profiles/client';
  static const String clientProfileUpdate = '$baseUrl/profiles/client';
  static const String clientProfileGet = '$baseUrl/profiles/client';
  static const String createJob = "$baseUrl/jobs";
static const String getCategories = "$baseUrl/jobs/categories";
  /// PROPOSALS BY JOB
  static String jobProposals(String jobId) =>
      "$baseUrl/proposals/job/$jobId";

  static const String notifications =
      "$baseUrl/notifications";

static String userReviews(String userId) =>
    "$baseUrl/reviews/user/$userId";


static String proposalStatus(String proposalId) =>
    "$baseUrl/proposals/$proposalId/status";

static String approveJobWork(String jobId) =>
    "$baseUrl/jobs/$jobId/approve";

      static const String clientJobs =
      "$baseUrl/jobs/client";

  /// PROPOSALS
  static const String proposalsByJob =
      "$baseUrl/proposals/job";

       /// Proposals
  static const String proposals = "$baseUrl/proposals";

  /// Approve Work
  static String approveProposal(String proposalId) =>
      "$proposals/$proposalId/approve";

        static const String submitProposal =
      "$baseUrl/proposals";

  // freelancerside notificatio-all";
  static const String Freelancernotifications = "$baseUrl/notifications";
static const String markRead = "$baseUrl/notifications/read";
static const String markAllRead = "$baseUrl/notifications/read-all";

// freelancerside

 static const String freelancerSubmitReview = "$baseUrl/reviews";

}

  /// ==============================
  /// 📝 JOBS
  /// ==============================
  // static const String postJob = '$baseUrl/jobs';
  // static const String jobsList = '$baseUrl/jobs';
  // static const String jobDetails = '$baseUrl/jobs/'; // + ID
  // static const String applyJob = '$baseUrl/jobs/'; // + {id}/apply


