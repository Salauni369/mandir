import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zamboree_devotion/screens/splashscreen.dart';
import 'package:zamboree_devotion/widgets/appbinding.dart';
import 'controllers/darshan_controller.dart';
import 'controllers/dashboard_cotroller.dart';
import 'controllers/notification_controller.dart';
import 'myRoutes/mypagesname.dart';
import 'myRoutes/routename.dart';


void main() async{
  //Get.put(DarshanController());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

        //statusBarColor:AppColor.dashbord,

        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,

      title: "SING IN",
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      // initialRoute: MyPagesName.splash,
      // getPages: MyRoute.list,
      home: SplashScreen(),
    );
  }
}
