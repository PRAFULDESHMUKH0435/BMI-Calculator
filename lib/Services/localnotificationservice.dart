import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class Localnotificationservice {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initnotifications() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});
  }

  /// AddLastLogin
  static Future<void> AddLastLoginDate() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("LastLoginDate", DateTime.now().toIso8601String());
    print("Last Login Date Is ${sp.get("LastLoginDate")}");
  }

  static Future ScheduleNotification(String bmicategory) async {
    try {
      final scheduledTime =
          tz.TZDateTime.now(tz.local).add(const Duration(minutes: 15));

      await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        "BMI Calculator",
        "Your BMI Category Is $bmicategory.\nWe Have Some Diet Plan For You\n Enter into App And Check Diet Plans Also",
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'scheduled_notifications',
            'Scheduled Notifications',
            channelDescription: 'Notifications scheduled for a later time',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'mipmap/ic_launcher', // Correctly reference the mipmap icon
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "Payload of Scheduled Notification",
      );

      print("Notification successfully scheduled");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

/// Show Simple Notification
  static Future showSimpleNotifications() async {
    AddLastLoginDate();

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('0', 'simplenotifications',
            channelDescription: 'simple notification description',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'mipmap/ic_launcher', // Correctly reference the mipmap icon
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, 'BMI Calculator',
        'Its Been While You have Not Visited App', notificationDetails,
        payload: 'item x');
  }

  /// Show Periodic Notification
  // static Future showPeriodicNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           importance: Importance.high,
  //           color: Colors.blue,
  //           colorized: true,
  //           priority: Priority.high,
  //           icon: 'mipmap/ic_launcher', // Correctly reference the mipmap icon
  //           'repeating channel id',
  //           'repeating channel name',
  //           channelDescription: 'repeating description');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(1, 'repeating title',
  //       'repeating body', RepeatInterval.everyMinute, notificationDetails,
  //       androidScheduleMode: AndroidScheduleMode.exact);
  // }

  // static cancelperiodic() async {
  //   await flutterLocalNotificationsPlugin.cancel(2);
  // }

  /// Show Scheduled Notification
  // static Future<void> showScheduleNotification() async {
  //   print("Scheduled notification function called");
  //   try {
  //     // Schedule time 5 seconds from now
  //     final scheduledTime =
  //         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
  //     print("Current Time: ${DateTime.now()}");
  //     print("Scheduled Time: $scheduledTime");

  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       2,
  //       "Scheduled Notification",
  //       "Body of the scheduled notification",
  //       scheduledTime,
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'scheduled_notifications',
  //           'Scheduled Notifications',
  //           channelDescription: 'Notifications scheduled for a later time',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           icon: 'mipmap/ic_launcher', // Correctly reference the mipmap icon
  //         ),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       payload: "Payload of Scheduled Notification",
  //     );

  //     print("Notification successfully scheduled");
  //   } catch (e) {
  //     print("Error scheduling notification: $e");
  //   }
  // }
}
