import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:mingle/NavController.dart';
import 'package:mingle/screens/login/login.dart';
import 'package:mingle/screens/login/login.dart';
import 'package:get/get.dart';
import 'package:mingle/styles/colors.dart';
import 'package:mingle/widgets/NavBar-restaurant.dart';
import 'package:mingle/widgets/NavBar-user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, 
  ]).then((_) {
    // Get.put(ChatService());
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(NavController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mingle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: secondary),
        scaffoldBackgroundColor: primary,
      ),
      home: Login(),
    );
    
  }
}