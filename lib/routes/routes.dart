import 'package:get/get.dart';
import 'package:topup_accounting/screens/basescreen.dart';
import 'package:topup_accounting/screens/dashboard.dart';
import 'package:topup_accounting/screens/signin_screen.dart';

import '../bindings/splash_binding.dart';
import '../splash_screen.dart';

const String splashscreen = '/splash-screen';

const String signinscreen = '/sign-in-screen';

const String basescreen = '/basescreen';
const String dashboard = '/dashboard';

List<GetPage> myroutes = [
  GetPage(
    name: splashscreen,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),

  GetPage(
    name: signinscreen,
    page: () => SigninScreen(),
    // binding: SignInControllerBinding(),
  ),
  GetPage(
    name: basescreen,
    page: () => Basescreen(),
    // binding: SignInControllerBinding(),
  ),
  GetPage(
    name: dashboard,
    page: () => Dashboard(),
    // binding: SignInControllerBinding(),
  ),
];
