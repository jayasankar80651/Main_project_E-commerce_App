import 'package:e_commerce_app/Home_Screen.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false, 
      home: SplashPage(), ));
  
}

