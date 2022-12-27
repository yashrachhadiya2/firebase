

import 'package:firebase/view/dataScreen.dart';
import 'package:firebase/view/homeScreen.dart';
import 'package:firebase/view/notificationView.dart';
import 'package:firebase/view/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();


  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>SplashScreen(),
        '/n':(context)=>NotifyScreen(),

        '/splash':(context)=>HomeScreen(),
        '/data':(context)=>DataScreen(),
      },
    ),
  );
}