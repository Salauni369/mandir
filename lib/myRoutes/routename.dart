import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:untitled/onboarding2.dart';
import 'package:untitled/screens/authentication/login.dart';
import 'package:untitled/screens/dashboard/dashboard_page.dart';
import 'package:untitled/screens/dashboard/notification.dart';
import 'package:untitled/screens/splashscreen.dart';
import '../screens/dashboard/donation/donation_list_page.dart';

import '../screens/dashboard/location.dart';
import '../screens/dashboard/manage.dart';
import '../screens/dashboard/overview.dart';
import '../widgets/custom_bottom_nav.dart';
import 'mypagesname.dart';

class MyRoute {
  static List<GetPage> get list => [
    GetPage(name: MyPagesName.splash, page: () => SplashScreen(),),
    GetPage(name: MyPagesName.onboardingscreen, page: () => OnboardingScreen(),),
    GetPage(name: MyPagesName.SignIn, page: () => LoginPage(),),
   GetPage(name: MyPagesName.dashboard, page: () => MyHomePage()),
   GetPage(name: MyPagesName.manage, page:() => MyHomePage()),
    GetPage(name: MyPagesName.overview, page:() => OverviewTab()),
    GetPage(name: MyPagesName.location, page:() => LocationTab()),
    // GetPage(name: MyPagesName. notification, page:()=> NotificationPage()),





  ];
}


