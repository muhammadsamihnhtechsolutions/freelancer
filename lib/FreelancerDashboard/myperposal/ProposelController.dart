import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelModel.dart' show ProposalModel;
import 'package:freelancer_app/service/Repo.dart' show ProposalRepo;
import 'package:get/get.dart';


class ProposalController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ProposalModel> proposals = <ProposalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProposals();
  }

  Future<void> fetchMyProposals() async {
    try {
      isLoading.value = true;

      print("🔵 Controller → Calling Repo.getMyProposals()");
      final data = await ProposalRepo.getMyProposals();

      proposals.assignAll(data);

      print("📦 Controller Loaded Proposals = ${proposals.length}");
    } catch (e) {
      print("❌ ERROR Fetching Proposals → $e");
    } finally {
      isLoading.value = false;
    }
  }
}