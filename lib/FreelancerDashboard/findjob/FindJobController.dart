
// import 'package:freelancer_app/FreelancerDashboard/findjob/FreeelanceFindJobModel.dart'
//     show JobModel;
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class JobsController extends GetxController {

//   /// ===============================
//   /// STATE
//   /// ===============================

//   RxList<JobModel> jobs = <JobModel>[].obs;
//   RxBool loading = false.obs;

//   /// ===============================
//   /// INIT
//   /// ===============================

//   @override
//   void onInit() {
//     super.onInit();

//     print("--------------------------------------------------");
//     print("🟣 JOBS CONTROLLER INIT");
//     print("--------------------------------------------------");

//     fetchJobs();
//   }

//   /// ===============================
//   /// FETCH OPEN JOBS
//   /// ===============================

//   Future<void> fetchJobs() async {
//     try {

//       print("🔵 FETCHING OPEN JOBS STARTED");

//       loading.value = true;

//       final data = await JobsRepo.getOpenJobs();

//       jobs.assignAll(data);

//       print("✅ JOBS FETCHED SUCCESSFULLY");
//       print("📦 TOTAL JOBS → ${jobs.length}");

//     } catch (e) {

//       print("❌ ERROR Fetching Jobs → $e");

//       Get.snackbar(
//         "Error",
//         "Failed to load jobs",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//     } finally {

//       loading.value = false;

//       print("--------------------------------------------------");
//     }
//   }

//   /// ===============================
//   /// REFRESH JOBS
//   /// ===============================

//   Future<void> refreshJobs() async {

//     print("🔄 REFRESHING JOB LIST");

//     await fetchJobs();
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
  RxList<JobModel> filteredJobs = <JobModel>[].obs;

  RxBool loading = false.obs;

  RxString selectedCategory = "All".obs;
  RxString selectedBudget = "All".obs;
  RxString selectedSort = "Newest".obs;

  String searchQuery = "";

  /// CATEGORY LIST
  List<String> categories = [
    "All",
    "Programming",
    "Design",
    "Finance",
  ];

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
      filteredJobs.assignAll(data);

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
  /// SEARCH
  /// ===============================

  void search(String query) {

    print("🔍 SEARCH QUERY → $query");

    searchQuery = query.toLowerCase();

    applyFilters();
  }

  /// ===============================
  /// CATEGORY FILTER
  /// ===============================

  void setCategory(String category) {

    print("📂 CATEGORY SELECTED → $category");

    selectedCategory.value = category;

    applyFilters();
  }

  /// ===============================
  /// BUDGET FILTER
  /// ===============================

  void setBudget(String budget) {

    print("💰 BUDGET FILTER → $budget");

    selectedBudget.value = budget;

    applyFilters();
  }

  /// ===============================
  /// SORT FILTER
  /// ===============================

  void setSort(String sort) {

    print("📊 SORT → $sort");

    selectedSort.value = sort;

    applyFilters();
  }

  /// ===============================
  /// APPLY ALL FILTERS
  /// ===============================

  void applyFilters() {

    print("⚙ APPLYING FILTERS");

    List<JobModel> temp = List.from(jobs);

    /// SEARCH FILTER
    if (searchQuery.isNotEmpty) {

      temp = temp.where((job) {

        return job.title.toLowerCase().contains(searchQuery) ||
            job.description.toLowerCase().contains(searchQuery);

      }).toList();
    }

    /// CATEGORY FILTER
    if (selectedCategory.value != "All") {

      temp = temp.where((job) {

        return job.category == selectedCategory.value;

      }).toList();
    }

  /// BUDGET FILTER
if (selectedBudget.value != "All") {

  if (selectedBudget.value == "0-50") {

    temp = temp.where((job) {
      return job.minBudget <= 50;
    }).toList();

  }

  else if (selectedBudget.value == "50-200") {

    temp = temp.where((job) {
      return job.maxBudget >= 50 && job.minBudget <= 200;
    }).toList();

  }

  else if (selectedBudget.value == "200+") {

    temp = temp.where((job) {
      return job.maxBudget >= 200;
    }).toList();

  }
}

    /// SORT
    if (selectedSort.value == "Newest") {

      temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    } else {

      temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    filteredJobs.assignAll(temp);

    print("✅ FILTERED JOBS → ${filteredJobs.length}");
  }

  /// ===============================
  /// REFRESH JOBS
  /// ===============================

  Future<void> refreshJobs() async {

    print("🔄 REFRESHING JOB LIST");

    await fetchJobs();
  }

}