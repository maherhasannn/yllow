import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:new_yellow/auth/login/controller/login_controller.dart';
import 'package:new_yellow/auth/login/view/login_screen.dart';
import 'package:new_yellow/auth/sign_up/controller/signup_controller.dart';
import 'package:new_yellow/screens/profile/controler/profile_controler.dart';
import 'package:new_yellow/stripe_payment_screen/controller.dart';
import 'package:new_yellow/stripe_payment_screen/payment_controller_forevent_join.dart';
import 'auth/splash_screen/splash_screen.dart';
import 'controller/get_storage_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initServices();
  Stripe.publishableKey ="pk_test_51M3k0XCWJrqhLfnNre9UiH5g4tU7rWzPLIjq0mrQU5bZOztZ65IiGxTqysNRtbjZv8bQdw4bCGcanbBPXtHKWkBC00eEra5N3s";
  // Stripe.publishableKey ="pk_test_51LSQiULnTGqzZlXrcTsqDUnpMm7fiez1OCACdvhsPBekeL4ti7zAo99M8cdHv8fxcaXpE5INjVmXOAm0PKChCkYJ00tc6nxg3Z";
  runApp( MyApp());
}
Future<void> initServices() async {
  await Get.put(GetStorageController()).initstorage();
  await Get.put(LoginController());
  await Get.put(SignUpController());
  await Get.put(PaymentController());
  await Get.put(JoinEventPaymentController());
  await Get.put(ProfileController());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}
