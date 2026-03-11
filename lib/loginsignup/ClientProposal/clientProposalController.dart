import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalModel.dart';
import 'package:freelancer_app/service/Repo.dart';
import 'package:get/get.dart';


class ClientProposalController extends GetxController {

  RxBool loading = false.obs;

  RxList<ClientProposalModel> proposals = <ClientProposalModel>[].obs;

  Future<void> fetchProposals(String jobId) async {

    try {

      print("=================================");
      print("🔵 fetchProposals CALLED → $jobId");
      print("=================================");

      loading.value = true;

      final data =
          await ClientProposalRepo.getJobProposals(jobId);

      if (data == null) {

        print("⚠️ PROPOSALS DATA IS NULL");
        proposals.clear();
        return;
      }

      if (data is List<ClientProposalModel>) {

        print("📦 PROPOSALS RECEIVED → ${data.length}");

        proposals.assignAll(data);

      } else {

        print("❌ UNEXPECTED DATA TYPE → ${data.runtimeType}");
        proposals.clear();
      }

    } catch (e, stack) {

      print("❌ PROPOSAL ERROR → $e");
      print("📍 STACK TRACE → $stack");

    } finally {

      loading.value = false;

      print("🟢 LOADING FALSE");
      print("=================================");
    }
  }
}