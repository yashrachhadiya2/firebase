import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class Notify extends GetxController {
  FlutterLocalNotificationsPlugin? flnp;

  void initNotification()async {
    flnp = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidsetting = AndroidInitializationSettings("app");
    DarwinInitializationSettings iossetting = DarwinInitializationSettings();

    InitializationSettings fluttersetting = InitializationSettings(android: androidsetting,iOS: iossetting);

    tz.initializeTimeZones();

    await flnp!.initialize(fluttersetting);
  }


  Future<Uint8List> getImage(String uri)
  async{
    var imageString =await  http.get(Uri.parse(uri));
    return imageString.bodyBytes;
  }
}