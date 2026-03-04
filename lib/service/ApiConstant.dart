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



  /// ==============================
  /// 👤 FREELANCER PROFILE
  /// ==============================
  // static const String freelancerProfileCreate = '$baseUrl/profiles/freelancer';
  // static const String freelancerProfileUpdate = '$baseUrl/profiles/freelancer';
  // static const String freelancerProfileGet = '$baseUrl/profiles/freelancer';

    /// 🔹 Freelancer Profile
  static const String freelancerProfile =
      "$baseUrl/profiles/freelancer";



  /// ==============================
  /// 🧑‍💼 CLIENT PROFILE
  /// ==============================
  static const String clientProfileCreate = '$baseUrl/profiles/client';
  static const String clientProfileUpdate = '$baseUrl/profiles/client';
  static const String clientProfileGet = '$baseUrl/profiles/client';
  static const String createJob = "$baseUrl/jobs";
static const String getCategories = "$baseUrl/jobs/categories";




  /// ==============================
  /// 📝 JOBS
  /// ==============================
  // static const String postJob = '$baseUrl/jobs';
  // static const String jobsList = '$baseUrl/jobs';
  // static const String jobDetails = '$baseUrl/jobs/'; // + ID
  // static const String applyJob = '$baseUrl/jobs/'; // + {id}/apply



  /// ==============================
  /// ⭐ REVIEWS
  /// ==============================
  static const String freelancerReviews = '$baseUrl/reviews/freelancer';
  static const String clientReviews = '$baseUrl/reviews/client';



  /// ==============================
  /// 💼 DASHBOARD / HOME
  /// ==============================
  static const String dashboardStats = '$baseUrl/dashboard/stats';
  static const String recommendedJobs = '$baseUrl/jobs/recommended';
  static const String recentActivity = '$baseUrl/activity/recent';



  /// ==============================
  /// 🏦 PAYMENTS / WALLET
  /// ==============================
  static const String walletBalance = '$baseUrl/wallet/balance';
  static const String walletTransactions = '$baseUrl/wallet/transactions';
  static const String walletWithdraw = '$baseUrl/wallet/withdraw';



  /// ==============================
  /// 🔔 NOTIFICATIONS
  /// ==============================
  static const String notifications = '$baseUrl/notifications';



  /// ==============================
  /// 📁 UPLOADS
  /// ==============================
  static const String uploadImage = '$baseUrl/upload/image';
  static const String uploadDocument = '$baseUrl/upload/document';



  /// ==============================
  /// 🌐 STATIC PAGES
  /// ==============================
  static const String termsConditions = '$baseUrl/terms';
  static const String privacyPolicy = '$baseUrl/privacy';
  static const String aboutUs = '$baseUrl/about';
}