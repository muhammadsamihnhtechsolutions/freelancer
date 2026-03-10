import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class GraphActivityController extends GetxController {

  /// RECENT ACTIVITIES
  RxList<Map<String, dynamic>> activities = <Map<String, dynamic>>[].obs;

  /// WEEKLY GRAPH DATA (Sun-Sat)
  RxList<int> weeklyGraph = List.generate(7, (index) => 0).obs;

  /// LOADER
  RxBool isLoading = false.obs;

  Future<void> loadGraphActivity(String clientId) async {

    print("--------------------------------------------------");
    print("📊 LOAD GRAPH ACTIVITY START");
    print("👤 CLIENT ID → $clientId");
    print("--------------------------------------------------");

    try {

      isLoading.value = true;

      /// GET CLIENT JOBS
      final jobsRes = await DashboardRepo.getClientJobs(clientId);

      print("📥 JOBS RESPONSE → $jobsRes");

      final List jobs = jobsRes["data"] ?? [];

      print("📌 TOTAL JOBS FOUND → ${jobs.length}");

      List<Map<String, dynamic>> allActivities = [];

      List<int> proposalsByDay = List.generate(7, (index) => 0);

      for (var job in jobs) {

        final jobId = job["id"];
        final jobTitle = job["title"];

        print("--------------------------------------------------");
        print("📌 FETCHING PROPOSALS FOR JOB");
        print("➡️ JOB ID → $jobId");
        print("➡️ JOB TITLE → $jobTitle");
        print("--------------------------------------------------");

        final proposalsRes =
            await DashboardRepo.getProposalsByJob(jobId);

        print("📥 PROPOSALS RESPONSE → $proposalsRes");

        final List proposals = proposalsRes["data"] ?? [];

        print("📌 TOTAL PROPOSALS → ${proposals.length}");

        for (var p in proposals) {

          final created = DateTime.parse(p["created_at"]);

          print("🕒 PROPOSAL CREATED → $created");

          /// WEEKLY GRAPH LOGIC
          final day = created.weekday % 7;

          proposalsByDay[day]++;

          print("📈 DAY INDEX → $day");
          print("📊 DAY COUNT → ${proposalsByDay[day]}");

          /// RECENT ACTIVITY
          allActivities.add({
            "action": p["status"],
            "job": jobTitle,
            "date": created,
            "status": p["status"]
          });
        }
      }

      print("--------------------------------------------------");
      print("📌 TOTAL ACTIVITIES BEFORE SORT → ${allActivities.length}");
      print("--------------------------------------------------");

      /// SORT LATEST FIRST
      allActivities.sort(
        (a, b) =>
            (b["date"] as DateTime).compareTo(a["date"] as DateTime),
      );

      print("✅ ACTIVITIES SORTED SUCCESSFULLY");

      activities.value = allActivities;

      weeklyGraph.value = proposalsByDay;

      print("📊 WEEKLY GRAPH DATA → $proposalsByDay");
      print("📌 FINAL ACTIVITIES COUNT → ${activities.length}");

      print("--------------------------------------------------");
      print("✅ GRAPH ACTIVITY LOADED SUCCESSFULLY");
      print("--------------------------------------------------");

    } catch (e) {

      print("❌ GRAPH ACTIVITY ERROR → $e");

    } finally {

      isLoading.value = false;

      print("🔚 LOADING FINISHED");
    }
  }
}