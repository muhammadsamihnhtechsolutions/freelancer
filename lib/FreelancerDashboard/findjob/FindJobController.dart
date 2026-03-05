// import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart' show JobModel;
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';


// class JobsController extends GetxController {
//   var jobs = <JobModel>[].obs;
//   var loading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchJobs();
//   }

//   Future<void> fetchJobs() async {
//     try {
//       loading.value = true;
//       print("🔵 Controller → Calling JobsRepo.getOpenJobs()");

//       jobs.value = await JobsRepo.getOpenJobs();

//       print("✅ Jobs Loaded → ${jobs.length}");
//     } catch (e) {
//       print("❌ ERROR Fetching Jobs → $e");
//     } finally {
//       loading.value = false;
//     }
//   }
// }
import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart'
    show JobModel;
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {

  /// ===============================
  /// STATE
  /// ===============================

  RxList<JobModel> jobs = <JobModel>[].obs;
  RxBool loading = false.obs;

  /// ===============================
  /// INIT
  /// ===============================

  @override
  void onInit() {
    super.onInit();

    print("--------------------------------------------------");
    print("🟣 JOBS CONTROLLER INIT");
    print("--------------------------------------------------");

    fetchJobs();
  }

  /// ===============================
  /// FETCH OPEN JOBS
  /// ===============================

  Future<void> fetchJobs() async {
    try {

      print("🔵 FETCHING OPEN JOBS STARTED");

      loading.value = true;

      final data = await JobsRepo.getOpenJobs();

      jobs.assignAll(data);

      print("✅ JOBS FETCHED SUCCESSFULLY");
      print("📦 TOTAL JOBS → ${jobs.length}");

    } catch (e) {

      print("❌ ERROR Fetching Jobs → $e");

      Get.snackbar(
        "Error",
        "Failed to load jobs",
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      loading.value = false;

      print("--------------------------------------------------");
    }
  }

  /// ===============================
  /// REFRESH JOBS
  /// ===============================

  Future<void> refreshJobs() async {

    print("🔄 REFRESHING JOB LIST");

    await fetchJobs();
  }

}