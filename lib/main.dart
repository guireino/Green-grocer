import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';

import 'src/pages/base/controller/navigation_controller.dart';

void main() {
  // Trecho de código que garante que todos os componentes necessários para a ação seguinte já estejam iniciados
  WidgetsFlutterBinding.ensureInitialized();

  // Mais abaixo teremos o método assíncrono que define as possíveis orientações suportadas pelo app.
  // Nesta lista abaixo você tem todas estas orientações disponíveis:
  /*
      * DeviceOrientation.landscapeRight,
      * DeviceOrientation.landscapeLeft,
      * DeviceOrientation.portraitUp, 
      * DeviceOrientation.portraitDown,
  */

  //o get vai intancia objeto AuthController na memoria
  Get.put(AuthController());
  Get.put(NavigationController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      //home: const SplashScreen(),
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
