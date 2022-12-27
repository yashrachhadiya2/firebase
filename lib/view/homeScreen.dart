import 'package:firebase/controller/firebase.dart';
import 'package:firebase/controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassward = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: txtEmail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtPassward,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  String msg = await signUp(txtEmail.text, txtPassward.text);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$msg")));
                },
                child: Text("Sign Up"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  String msg =
                      await loginEmailPassword(txtEmail.text, txtPassward.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$msg"),
                    ),
                  );
                  if (msg == "Success") {
                    Get.offNamed('/data');
                  }
                },
                child: Text("Sign In"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  bool msg = await googleLogin();
                  if (msg) {
                    Get.offNamed('/data');
                  }
                },
                child: Text("Google SignIn"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
