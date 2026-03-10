
import 'package:freelancer_app/ClientProfilePage/ClientProfileCreatePage.dart';
import 'package:freelancer_app/FreelancerDashboard/freelancerbottomnav/FreelancerBottomNavView.dart' show FreelancerBottomNavView;
import 'package:freelancer_app/Routes/AppRoutes.dart';
import 'package:freelancer_app/controller/DashboardController.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientViewProPosalDetailPage.dart';
import 'package:freelancer_app/loginsignup/LoginBinding.dart';
import 'package:freelancer_app/loginsignup/LoginPage.dart';
import 'package:freelancer_app/loginsignup/SignUpBindings.dart';
import 'package:freelancer_app/loginsignup/SignUpPage.dart';
import 'package:freelancer_app/spalshscreen/SplashBinding.dart';
import 'package:freelancer_app/spalshscreen/SplashScreen.dart';
import 'package:freelancer_app/view/BottomNavView.dart';
import 'package:freelancer_app/view/Clientdashboard/ClientProfilePage.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [

    // 1️⃣ Splash FIRST
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),


  
    GetPage(
      name: "/createClientProfile",
      page: () => CreateClientProfilePage(),
    ),

    GetPage(
      name: "/profile",
      page: () => ClientProfilePage(),
    ),
    // 2️⃣ Signup
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),

    // 3️⃣ Dashboard
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => BottomNavView(),
      binding: BindingsBuilder(() {
        Get.put(DashboardController());
      }),
    ),

    GetPage(
  name: AppRoutes.LOGIN,
  page: () => const LoginPage(),
  binding: LoginBinding(),
),


    // GetPage(
    //   name: AppRoutes.clientProposalDetails,
    //   page: () => ClientViewDetailsProposalPage(proposalId: '', jobId: '', freelancerName: '', freelancerEmail: '', status: '', coverLetter: '', price: '', deliveryDays: '',
    //     // proposalId: "",
    //     // jobId: "",
    //     // freelancerName: "",
    //     // freelancerEmail: "",
    //     // status: "",
    //     // coverLetter: "",
    //     // price: "",
    //     // deliveryDays: "",
    //   ),
    // ),

  GetPage(name: AppRoutes.FREELANCER_DASHBOARD, page: () => FreelancerBottomNavView()),
  GetPage(name: AppRoutes.CLIENT_DASHBOARD, page: () => BottomNavView()),

  ];
}