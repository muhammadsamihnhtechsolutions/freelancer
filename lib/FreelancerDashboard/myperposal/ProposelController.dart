


// import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelModel.dart';
// import 'package:freelancer_app/service/Repo.dart';
// import 'package:get/get.dart';

// class ProposalController extends GetxController {

//   RxBool isLoading = false.obs;
//   RxList<ProposalModel> proposals = <ProposalModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();

//     print("=================================");
//     print("🟢 ProposalController INIT");
//     print("=================================");

//     fetchMyProposals();
//   }

//   Future<void> fetchMyProposals() async {

//     try {

//       print("=================================");
//       print("🔵 CONTROLLER → fetchMyProposals()");
//       print("=================================");

//       isLoading.value = true;

//       final data = await ProposalRepo.getMyProposals();

//       print("📦 RAW API RESPONSE → $data");

//       if (data == null) {
//         print("❌ API RETURNED NULL");
//         proposals.clear();
//         return;
//       }

//       print("📦 TOTAL PROPOSALS RECEIVED → ${data.length}");

//       proposals.assignAll(data);

//       print("✅ PROPOSALS ASSIGNED → ${proposals.length}");

//     } catch (e) {

//       print("❌ ERROR FETCHING PROPOSALS → $e");

//     } finally {

//       isLoading.value = false;

//       print("🔚 LOADING FINISHED");
//       print("=================================");

//     }
//   }
// }
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ProposalController extends GetxController {

  /// ===============================
  /// STATE
  /// ===============================

  RxBool isLoading = false.obs;

  RxList<ProposalModel> proposals = <ProposalModel>[].obs;

  /// FILTERED LIST (UI USES THIS)
  RxList<ProposalModel> filteredProposals = <ProposalModel>[].obs;

  /// STATUS FILTER
  RxString selectedStatus = "All".obs;

  /// SEARCH QUERY
  String searchQuery = "";

  /// ===============================
  /// INIT
  /// ===============================

  @override
  void onInit() {
    super.onInit();

    print("================================================");
    print("🟢 ProposalController INITIALIZED");
    print("================================================");

    fetchMyProposals();
  }

  /// ===============================
  /// FETCH PROPOSALS
  /// ===============================

  Future<void> fetchMyProposals() async {

    try {

      print("------------------------------------------------");
      print("📡 FETCHING MY PROPOSALS FROM API");
      print("------------------------------------------------");

      isLoading.value = true;

      final data = await ProposalRepo.getMyProposals();

      print("⬇️ RAW API RESPONSE → $data");

      if (data == null) {

        print("❌ API RETURNED NULL");

        proposals.clear();
        filteredProposals.clear();

        print("🧹 LOCAL PROPOSAL LIST CLEARED");

        return;
      }

      if (data.isEmpty) {

        print("⚠️ API RETURNED EMPTY LIST");

      }

      print("📦 TOTAL PROPOSALS RECEIVED → ${data.length}");

      /// LOG EACH PROPOSAL
      for (var p in data) {

        print("--------------------------------");
        print("📄 Proposal ID → ${p.id}");
        print("🧾 Job Title → ${p.jobTitle}");
        print("💰 Price → ${p.price}");
        print("⏳ Days → ${p.days}");
        print("📌 Status → ${p.status}");
        print("--------------------------------");
      }

      proposals.assignAll(data);

      /// APPLY FILTERS AFTER LOAD
      applyFilters();

      print("✅ PROPOSALS ASSIGNED TO STATE → ${proposals.length}");

    } catch (e) {

      print("❌ ERROR FETCHING PROPOSALS → $e");

    } finally {

      isLoading.value = false;

      print("⏹ PROPOSAL LOADING FINISHED");

      print("================================================");
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
  /// STATUS FILTER
  /// ===============================

  void filterStatus(String status) {

    print("🔽 STATUS FILTER → $status");

    selectedStatus.value = status;

    applyFilters();
  }

  /// ===============================
  /// APPLY FILTERS
  /// ===============================

  void applyFilters() {

    print("⚙ APPLYING FILTERS");

    List<ProposalModel> temp = List.from(proposals);

    /// SEARCH FILTER
    if (searchQuery.isNotEmpty) {

      temp = temp.where((p) {

        return p.jobTitle.toLowerCase().contains(searchQuery);

      }).toList();

      print("🔎 AFTER SEARCH FILTER → ${temp.length}");
    }

    /// STATUS FILTER
    if (selectedStatus.value != "All") {

      temp = temp.where((p) {

        return p.status.toLowerCase() == selectedStatus.value.toLowerCase();

      }).toList();

      print("📊 AFTER STATUS FILTER → ${temp.length}");
    }

    filteredProposals.assignAll(temp);

    print("✅ FINAL FILTERED PROPOSALS → ${filteredProposals.length}");
  }

  /// ===============================
  /// REFRESH PROPOSALS
  /// ===============================

  Future<void> refreshProposals() async {

    print("🔄 REFRESHING PROPOSALS");

    await fetchMyProposals();
  }
}