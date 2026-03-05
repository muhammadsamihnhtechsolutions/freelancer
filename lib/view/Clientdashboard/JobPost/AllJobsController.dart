import 'package:freelancer_app/service/Repo.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/AlljobModel.dart';
import 'package:get/get.dart';


class AdminJobsController extends GetxController {
  RxBool loading = false.obs;
  RxList<AdminJobModel> jobs = <AdminJobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      loading.value = true;
      final data = await JobsRepo.getClientJobs();
      jobs.assignAll(data);
    } catch (e) {
      print("❌ ERROR FETCHING CLIENT JOBS → $e");
    } finally {
      loading.value = false;
    }
  }

 Future<void> approveJob(String jobId) async {
  try {

    await JobsRepo.updateJob(jobId, {
      "status": "open",
    });

    await fetchJobs();

  } catch (e) {
    print("❌ APPROVE ERROR → $e");
  }
}

  Future<void> rejectJob(String jobId) async {
    try {
await JobsRepo.closeJob(jobId);
      await fetchJobs();
    } catch (e) {
      print("❌ REJECT ERROR → $e");
    }
  }
}