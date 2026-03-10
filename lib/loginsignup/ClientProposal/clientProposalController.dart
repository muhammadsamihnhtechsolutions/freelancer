import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';

class ClientProposalController extends GetxController {

  RxBool loading = false.obs;

  RxList<ClientProposalModel> proposals = <ClientProposalModel>[].obs;
  Future<void> fetchProposals(String jobId) async {

  try {

    print("🔵 fetchProposals CALLED → $jobId");

    loading.value = true;

    final data =
        await ClientProposalRepo.getJobProposals(jobId);

    print("📦 PROPOSALS RECEIVED → ${data.length}");

    proposals.assignAll(data);

  } catch (e) {

    print("❌ PROPOSAL ERROR → $e");

  } finally {

    loading.value = false;

  }
}

  // Future<void> fetchProposals(String jobId) async {
    

  //   try {

  //     loading.value = true;

  //     final data =
  //         await ClientProposalRepo.getJobProposals(jobId);

  //     proposals.assignAll(data);

  //   } catch (e) {

  //     print("❌ PROPOSAL ERROR → $e");

  //   } finally {

  //     loading.value = false;

  //   }
  // }
}