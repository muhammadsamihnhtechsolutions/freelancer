// // import 'package:freelancer_app/service/Repo.dart';
// // import 'package:freelancer_app/view/Clientdashboard/JobPost/JobCatogeryModel.dart';
// // import 'package:freelancer_app/view/Clientdashboard/JobPost/JobPostModel.dart';
// // import 'package:get/get.dart';


// // class JobController extends GetxController {
// //   // ==================================================
// //   // FORM FIELDS
// //   // ==================================================
// //   var title = "".obs;
// //   var description = "".obs;
// //   var minBudget = "".obs;
// //   var maxBudget = "".obs;
// //   var jobType = "remote".obs;
// //   var categoryId = "".obs;

// //   // ==================================================
// //   // CATEGORY LIST
// //   // ==================================================
// //   var categories = <CategoryModel>[].obs;
// //   var loadingCategories = false.obs;

// //   // ==================================================
// //   // CREATE JOB LOADING
// //   // ==================================================
// //   var creatingJob = false.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchCategories();
// //   }

// //   // ==================================================
// //   // GET CATEGORIES FROM API
// //   // ==================================================
// //   Future<void> fetchCategories() async {
// //     try {
// //       loadingCategories.value = true;

// //       categories.value = await JobPostRepo.fetchCategories();

// //       print("📥 Categories Loaded → ${categories.length}");
// //     } catch (e) {
// //       print("❌ Category Error: $e");
// //     } finally {
// //       loadingCategories.value = false;
// //     }
// //   }

// //   // ==================================================
// //   // CREATE JOB API
// //   // ==================================================
// //   Future<void> createJob() async {
// //     try {
// //       creatingJob.value = true;

// //       JobPostModel job = JobPostModel(
// //         title: title.value,
// //         description: description.value,
// //         budgetMin: double.tryParse(minBudget.value) ?? 0,
// //         budgetMax: double.tryParse(maxBudget.value) ?? 0,
// //         jobType: jobType.value,
// //         categoryId: categoryId.value,
// //       );

// //       final res = await JobPostRepo.createJob(job);

// //       print("✅ JOB POSTED SUCCESSFULLY");
// //       print(res);

// //       Get.snackbar("Success", "Job posted successfully!");
// //     } catch (e) {
// //       print("❌ Job Post Error: $e");
// //       Get.snackbar("Error", e.toString());
// //     } finally {
// //       creatingJob.value = false;
// //     }
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:freelancer_app/view/Clientdashboard/JobPost/JobCatogeryModel.dart';
// import 'package:freelancer_app/view/Clientdashboard/JobPost/JobPostModel.dart';
// import 'package:get/get.dart';

// class JobController extends GetxController {

//   // ==================================================
//   // TEXT CONTROLLERS (FOR UI)
//   // ==================================================

//   final titleCtrl = TextEditingController();
//   final descCtrl = TextEditingController();
//   final minBudgetCtrl = TextEditingController();
//   final maxBudgetCtrl = TextEditingController();

//   // ==================================================
//   // DROPDOWNS
//   // ==================================================

//   var jobType = "remote".obs;
//   var selectedCategoryId = "".obs;

//   // ==================================================
//   // CATEGORY LIST
//   // ==================================================

//   var categories = <CategoryModel>[].obs;
//   var loadingCategories = false.obs;

//   // ==================================================
//   // CREATE JOB LOADING
//   // ==================================================

//   var creatingJob = false.obs;

//   // ==================================================
//   // INIT
//   // ==================================================

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }

//   // ==================================================
//   // GET CATEGORIES FROM API
//   // ==================================================

//   Future<void> fetchCategories() async {
//     try {

//       loadingCategories.value = true;

//       categories.value = await JobPostRepo.fetchCategories();

//       print("📥 Categories Loaded → ${categories.length}");

//     } catch (e) {

//       print("❌ Category Error: $e");

//     } finally {

//       loadingCategories.value = false;

//     }
//   }

//   // ==================================================
//   // CREATE JOB API
//   // ==================================================

//   Future<void> createJob() async {
//     try {

//       creatingJob.value = true;

//       JobPostModel job = JobPostModel(
//         title: titleCtrl.text,
//         description: descCtrl.text,
//         budgetMin: double.tryParse(minBudgetCtrl.text) ?? 0,
//         budgetMax: double.tryParse(maxBudgetCtrl.text) ?? 0,
//         jobType: jobType.value,
//         categoryId: selectedCategoryId.value,
//       );

//       final res = await JobPostRepo.createJob(job);

//       print("✅ JOB POSTED SUCCESSFULLY");
//       print(res);

//       Get.snackbar("Success", "Job posted successfully!");

//       // Clear fields
//       titleCtrl.clear();
//       descCtrl.clear();
//       minBudgetCtrl.clear();
//       maxBudgetCtrl.clear();

//     } catch (e) {

//       print("❌ Job Post Error: $e");

//       Get.snackbar("Error", e.toString());

//     } finally {

//       creatingJob.value = false;

//     }
//   }

//   // ==================================================
//   // DISPOSE CONTROLLERS
//   // ==================================================

//   @override
//   void onClose() {

//     titleCtrl.dispose();
//     descCtrl.dispose();
//     minBudgetCtrl.dispose();
//     maxBudgetCtrl.dispose();

//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobCatogeryModel.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/JobPostModel.dart';
import 'package:get/get.dart';

class JobController extends GetxController {

  // ==================================================
  // TEXT CONTROLLERS
  // ==================================================

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final minBudgetCtrl = TextEditingController();
  final maxBudgetCtrl = TextEditingController();

  // ==================================================
  // DROPDOWNS
  // ==================================================

  var jobType = "remote".obs;
  RxnString selectedCategoryId = RxnString();

  // ==================================================
  // CATEGORY LIST
  // ==================================================

  var categories = <CategoryModel>[].obs;
  var loadingCategories = false.obs;

  // ==================================================
  // CREATE JOB LOADING
  // ==================================================

  var creatingJob = false.obs;

  // ==================================================
  // INIT
  // ==================================================

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // ==================================================
  // FETCH CATEGORIES
  // ==================================================

  Future<void> fetchCategories() async {

    try {

      print("🟡 Fetching categories...");

      loadingCategories.value = true;

      final data = await JobPostRepo.fetchCategories();

      categories.assignAll(data);

      /// SAFE DROPDOWN VALUE
      if (categories.isNotEmpty) {

        if (!categories.any((e) => e.id == selectedCategoryId.value)) {

          selectedCategoryId.value = null;

        }

      }

      print("✅ Categories Loaded → ${categories.length}");

      for (var c in categories) {
        print("Category → id:${c.id} name:${c.name}");
      }

    } catch (e) {

      print("❌ Category Error: $e");

    } finally {

      loadingCategories.value = false;

    }

  }

  // ==================================================
  // CREATE JOB
  // ==================================================

  Future<void> createJob() async {

    print("--------------------------------------------------");
    print("🟣 CREATE JOB BUTTON PRESSED");

    print("Title → ${titleCtrl.text}");
    print("Description → ${descCtrl.text}");
    print("Min Budget → ${minBudgetCtrl.text}");
    print("Max Budget → ${maxBudgetCtrl.text}");
    print("Job Type → ${jobType.value}");
    print("Selected Category → ${selectedCategoryId.value}");

    // ===============================
    // VALIDATION
    // ===============================

    if (selectedCategoryId.value == null) {

      print("❌ CATEGORY NOT SELECTED");

      Get.snackbar("Error", "Please select a category");

      return;

    }

    if (titleCtrl.text.isEmpty || descCtrl.text.isEmpty) {

      Get.snackbar("Error", "Title and description required");

      return;

    }

    try {

      creatingJob.value = true;

      JobPostModel job = JobPostModel(

        title: titleCtrl.text,

        description: descCtrl.text,

        budgetMin: double.tryParse(minBudgetCtrl.text) ?? 0,

        budgetMax: double.tryParse(maxBudgetCtrl.text) ?? 0,

        jobType: jobType.value,

        categoryId: selectedCategoryId.value!,

      );

      print("📤 Sending Payload →");

      print({
        "title": job.title,
        "description": job.description,
        "budget_min": job.budgetMin,
        "budget_max": job.budgetMax,
        "job_type": job.jobType,
        "category_id": job.categoryId
      });

      final res = await JobPostRepo.createJob(job);

      print("✅ JOB POSTED SUCCESSFULLY");
      print(res);

      Get.snackbar("Success", "Job posted successfully!");

      // ===============================
      // CLEAR FORM
      // ===============================

      titleCtrl.clear();
      descCtrl.clear();
      minBudgetCtrl.clear();
      maxBudgetCtrl.clear();
      selectedCategoryId.value = null;

    } catch (e) {

      print("❌ Job Post Error: $e");

      Get.snackbar("Error", e.toString());

    } finally {

      creatingJob.value = false;

    }

    print("--------------------------------------------------");

  }
  

  // ==================================================
  // DISPOSE
  // ==================================================

  @override
  void onClose() {

    titleCtrl.dispose();
    descCtrl.dispose();
    minBudgetCtrl.dispose();
    maxBudgetCtrl.dispose();

    super.onClose();

  }

}