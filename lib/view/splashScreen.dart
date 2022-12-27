import 'dart:async';

import 'package:firebase/controller/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool msg = false;
  @override

  void initState() {
    super.initState();
    msg = checkUser();
  }

  Widget build(BuildContext context) {


    Timer(Duration(seconds: 3),()=>msg?Get.offNamed('/data'):Get.offNamed('/splash'),);


    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FlutterLogo(
            size: 150,
          ),
        ),

      ),
    );
  }
}
