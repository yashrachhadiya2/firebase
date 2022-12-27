import 'package:firebase/controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notificationScreen.dart';


class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  Notify notify = Get.put(Notify());

  @override
  void initState() {
    super.initState();
    notify.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  var image = ByteArrayAndroidBitmap(await notify.getImage(
                      "https://cars.tatamotors.com/images/performance-mobile-new.jpg"));
                  BigPictureStyleInformation big =
                  BigPictureStyleInformation(image);

                  AndroidNotificationDetails and = AndroidNotificationDetails(
                      "1", "anroid",
                      priority: Priority.high, importance: Importance.max,styleInformation: big);
                  NotificationDetails nd = NotificationDetails(android: and);

                  await notify.flnp!.show(1, "Hello", "Yash", nd);
                },
                child: Text("Local Notification"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var image = ByteArrayAndroidBitmap(await notify.getImage("https://cars.tatamotors.com/images/performance-mobile-new.jpg"));
                  BigPictureStyleInformation big = BigPictureStyleInformation(image);

                  AndroidNotificationDetails and = AndroidNotificationDetails(
                      "1", "anroid",styleInformation: big, priority: Priority.high, importance: Importance.max);
                  NotificationDetails nd = NotificationDetails(android: and);

                  await notify.flnp!.zonedSchedule(
                      0 ,
                      "Hello",
                      "Yash123456",
                      tz.TZDateTime.now(tz.local).add(
                        Duration(seconds: 3),
                      ),
                      nd,
                      uiLocalNotificationDateInterpretation:
                      UILocalNotificationDateInterpretation.absoluteTime,
                      androidAllowWhileIdle: true);
                },
                child: Text("timer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}