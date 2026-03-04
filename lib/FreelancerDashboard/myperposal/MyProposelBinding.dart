import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelController.dart' show ProposalController;
import 'package:get/get.dart';

class ProposalBinding extends Bindings {
  @override
  void dependencies() {
    print("📌 ProposalBinding Loaded → Controller Registered");
    Get.put(ProposalController());
  }
}