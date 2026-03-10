import 'package:freelancer_app/ClientProfilePage/ClientProfileController.dart';
import 'package:freelancer_app/FreelancerDashboard/myperposal/ProposelController.dart' show ProposalController;
import 'package:freelancer_app/controller/DashboardController.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/PostJobController.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/loginsignup/LoginController.dart';
import 'package:freelancer_app/loginsignup/SignUpController.dart';

import '../FreelancerDashboard/findjob/FindJobController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());

    // 🔥 Add this → permanent fix for your error
    Get.lazyPut(() => ProposalController(), fenix: true);
    Get.lazyPut(()=>JobsController());
    Get.lazyPut(()=>DashboardController());
    Get.lazyPut(() => JobController());
    Get.lazyPut(()=>ClientProfileController());
  }
}