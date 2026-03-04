import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart' show JobModel;
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';


class JobsController extends GetxController {
  var jobs = <JobModel>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      loading.value = true;
      print("🔵 Controller → Calling JobsRepo.getOpenJobs()");

      jobs.value = await JobsRepo.getOpenJobs();

      print("✅ Jobs Loaded → ${jobs.length}");
    } catch (e) {
      print("❌ ERROR Fetching Jobs → $e");
    } finally {
      loading.value = false;
    }
  }
}