import 'package:flutter/material.dart';
import 'package:freelancer_app/service/InitailBindings.dart' show InitialBinding;
import 'package:get/get.dart';
import 'package:freelancer_app/Routes/AppPages.dart';
import 'package:freelancer_app/Routes/AppRoutes.dart';
import 'package:freelancer_app/theme/AppTheme.dart';
import 'dart:developer' as developer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  developer.log('🚀 App starting...', name: 'FreelancerApp');



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freelancer App',
      theme: AppTheme.lightTheme,
        initialBinding: InitialBinding(), 
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}