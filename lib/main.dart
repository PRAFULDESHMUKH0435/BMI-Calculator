import 'dart:async';
import 'dart:io';
import 'package:bmicalculator/Screens/splashscreen.dart';
import 'package:bmicalculator/Services/localnotificationservice.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'Hive/UserData.dart';
import 'Providers/HomeScreenProvider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

Future main() async {
  tz.initializeTimeZones();

  /// Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();
  Localnotificationservice.initnotifications();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey:
                "AIzaSyBZsvFhji4-YWUwFfnALzVBbkcMEoheS4k", // Current Key    (App Level googleservices.json)
            appId:
                "1:1577961264:android:e82ace01cb738f6f47aaf5", // mobilesdk_app_id  (App Level googleservices.json)
            messagingSenderId:
                "1577961264", // project_number	 (App Level googleservices.json)
            projectId:
                "bmi-calculator-a3ddc", // project_id     (App Level googleservices.json)
          ),
        )
      : null;

  /// Local Notifications
  /// /// WorkManager Initialization
  Workmanager().initialize(
    callbackDispatcher, // The callback function to execute tasks
    // isInDebugMode: true, // Set to false in production
  );

  if (Platform.isAndroid) {
  Workmanager().registerPeriodicTask(
    "checkUserInactivity",
    "periodicInactivityCheck",
    frequency: const Duration(hours: 15), // Minimum interval is 15 minutes
    inputData: {"targetHour": 9},
  );
} else {
  print("Workmanager periodic tasks are not supported on this platform.");
}


  /// OneSignal Initialization
  OneSignal.initialize("f03a0986-0aac-4751-b89a-3e5c6dad637a");
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Notifications.requestPermission(true);

  /// Hive Initialization
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox("BMIHistory");

  /// Ads Initialization
  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "periodicInactivityCheck") {
      // Get the current time
      DateTime now = DateTime.now();
      int targetHour =
          inputData?['targetHour'] ?? 9; // Default to 9:00 AM if not provided

      // Check if it's close to 9:00 AM
      if (now.hour == targetHour && now.minute == 0) {
        // Perform your action
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? lastLoginDateString = prefs.getString('LastLoginDate');

        // DateTime lastLoginDate = DateTime.parse(lastLoginDateString);
        // if (now.difference(lastLoginDate).inDays >= 1) {
        //   // Send message to the user
        //   Localnotificationservice.showSimpleNotifications();
        //   print("User has not logged in for 5 days. Sending message...");
        // }
      }
    }
    return Future.value(true); // Task completed
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
