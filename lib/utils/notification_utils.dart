import 'package:flutter_dev_framework/utils/date_time_utils.dart';
import 'package:flutter_dev_framework/utils/system_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// 푸시 알림 유틸리티
class NotificationUtils {
  static final instance = NotificationUtils._internal();

  late FlutterLocalNotificationsPlugin _notificationsPlugin;
  late NotificationDetails _notificationDetails;
  int _notificationIdCount = 100;

  NotificationUtils._internal() {
    tz.initializeTimeZones();

    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    final androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSettings = IOSInitializationSettings();
    final macSettings = MacOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        android: androidSettings, iOS: iosSettings, macOS: macSettings);
    _notificationsPlugin.initialize(initializationSettings);

    final androidDetails = AndroidNotificationDetails(
      'flutter_notification',
      '푸시 알림',
      '앱에서 발생하는 푸시 알림을 받습니다. 중요도를 변경할 경우 알림을 받지 못할 수도 있습니다.',
      priority: Priority.high,
      importance: Importance.max
    );
    final iosDetails = IOSNotificationDetails();
    final macDetails = MacOSNotificationDetails();
    _notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosDetails, macOS: macDetails);
  }

  /// 즉시 알린다.
  Future<int> oneShot({
    int? id,
    required String title,
    String? body,
    bool sound = true,
    bool wakeLockScreen = true
  }) async {
    if (id == null)
      id = _getUniqueNotificationId();

    await _notificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails,
      payload: (sound) ? 'Default_Sound' : ''
    );

    // Wake up screen panel for Android Platform
    if (wakeLockScreen)
      SystemUtils.instance.wakeLockScreen();

    return Future.value(id);
  }

  /// [scheduledDate]에 알리도록 스케줄을 등록한다.
  Future<int> schedule({
    int? id,
    required String title,
    String? body,
    required DateTime scheduledDate,
    bool sound = true,
    bool wakeLockScreen = true
  }) async {
    if (id == null)
      id = _getUniqueNotificationId();

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: (sound) ? 'Default_Sound' : ''
    );

    // Wake up screen panel for Android Platform
    if (wakeLockScreen) {
      final difference = scheduledDate.difference(DateTime.now()).inMilliseconds;
      Future.delayed(Duration(milliseconds: difference), SystemUtils.instance.wakeLockScreen);
    }

    return Future.value(id);
  }

  /// [id]를 가진 알림을 취소한다.
  Future<void> cancel(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// 모든 알림을 취소한다.
  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
    _notificationIdCount = 100;
  }

  /// 고유 알림 ID를 생성한다.
  int _getUniqueNotificationId() {
    final dateTimeString = DateTimeUtils.instance
        .getStringByDateTime(DateTime.now(), pattern: 'ddHHmmss');

    return int.parse(dateTimeString) + _notificationIdCount++;
  }
}
