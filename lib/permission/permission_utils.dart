import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_framework/permission/model/permission_data.dart';
import 'package:flutter_dev_framework/permission/model/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';
export 'package:permission_handler/permission_handler.dart';

/// 앱 권한 유틸리티
class PermissionUtils {
  PermissionUtils._internal();
  static final instance = PermissionUtils._internal();
  static const _channel = MethodChannel('flutter_dev_framework');

  /// [permissionType]에 해당하는 앱 권한 아이콘을 반환한다.
  Icon getPermissionIcon(PermissionType permissionType, Color? color) {
    switch (permissionType) {
      case PermissionType.CALENDAR:
        return Icon(Icons.calendar_today, color: color);
      case PermissionType.CAMERA:
        return Icon(Icons.camera_alt, color: color);
      case PermissionType.CONTACTS:
        return Icon(Icons.contacts, color: color);
      case PermissionType.LOCATION:
        return Icon(Icons.location_pin, color: color);
      case PermissionType.MEDIA_LIBRARY:
        return Icon(Icons.music_note, color: color);
      case PermissionType.MICROPHONE:
        return Icon(Icons.mic, color: color);
      case PermissionType.PHONE:
        return Icon(Icons.call, color: color);
      case PermissionType.PHOTOS:
        return Icon(Icons.photo, color: color);
      case PermissionType.REMINDERS:
        return Icon(Icons.notifications, color: color);
      case PermissionType.BODY_SENSORS:
        return Icon(Icons.accessibility, color: color);
      case PermissionType.SMS:
        return Icon(Icons.message, color: color);
      case PermissionType.SPEECH:
        return Icon(Icons.mic, color: color);
      case PermissionType.STORAGE:
        return Icon(Icons.sd_storage, color: color);
      case PermissionType.NOTIFICATION:
        return Icon(Icons.notifications, color: color);
      case PermissionType.ACCESS_MEDIA_LOCATION:
        return Icon(Icons.sd_storage, color: color);
      case PermissionType.ACTIVITY_RECOGNITION:
        return Icon(Icons.accessibility, color: color);
      case PermissionType.BLUETOOTH:
        return Icon(Icons.bluetooth, color: color);
      case PermissionType.SYSTEM_ALERT_WINDOW:
        return Icon(Icons.palette, color: color);
      case PermissionType.UNKNOWN:
        return Icon(Icons.contact_support, color: color);
    }
  }

  /// [permissionType]에 해당하는 앱 권한 이름을 반환한다.
  String getPermissionName(PermissionType permissionType, bool necessary) {
    final flagText = necessary ? '(필수)' : '(선택)';

    switch (permissionType) {
      case PermissionType.CALENDAR:
        return '캘린더$flagText';
      case PermissionType.CAMERA:
        return '카메라$flagText';
      case PermissionType.CONTACTS:
        return '연락처$flagText';
      case PermissionType.LOCATION:
        return '위치$flagText';
      case PermissionType.MEDIA_LIBRARY:
        return '미디어$flagText';
      case PermissionType.MICROPHONE:
        return '마이크$flagText';
      case PermissionType.PHONE:
        return '전화$flagText';
      case PermissionType.PHOTOS:
        return '갤러리$flagText';
      case PermissionType.REMINDERS:
        return '리마인더$flagText';
      case PermissionType.BODY_SENSORS:
        return '신체 센서$flagText';
      case PermissionType.SMS:
        return '메시지$flagText';
      case PermissionType.SPEECH:
        return '음성 인식$flagText';
      case PermissionType.STORAGE:
        return '저장소$flagText';
      case PermissionType.NOTIFICATION:
        return '알림$flagText';
      case PermissionType.ACCESS_MEDIA_LOCATION:
        return '외부 저장소$flagText';
      case PermissionType.ACTIVITY_RECOGNITION:
        return '활동 인식$flagText';
      case PermissionType.BLUETOOTH:
        return '블루투스$flagText';
      case PermissionType.SYSTEM_ALERT_WINDOW:
        return '다른 앱 위에 표시$flagText';
      case PermissionType.UNKNOWN:
        return 'unknown';
    }
  }

  /// [permissionType]에 해당하는 앱 권한 설명을 반환한다.
  String getPermissionDesc(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.CALENDAR:
        return '캘린더 데이터에 접근하기 위해 필요';
      case PermissionType.CAMERA:
        return '카메라 모듈에 접근하기 위해 필요';
      case PermissionType.CONTACTS:
        return '연락처 데이터에 접근하기 위해 필요';
      case PermissionType.LOCATION:
        return '위치 서비스를 제공하기 위해 필요';
      case PermissionType.MEDIA_LIBRARY:
        return '미디어 라이브러리를 제공하기 위해 필요';
      case PermissionType.MICROPHONE:
        return '마이크 모듈에 접근하기 위해 필요';
      case PermissionType.PHONE:
        return '디바이스 상태를 읽거나 통화 기능을 제공하기 위해 필요';
      case PermissionType.PHOTOS:
        return '갤러리 데이터에 접근하기 위해 필요';
      case PermissionType.REMINDERS:
        return '리마인더 데이터에 접근하기 위해 필요';
      case PermissionType.BODY_SENSORS:
        return '신체 센서에 접근하기 위해 필요';
      case PermissionType.SMS:
        return '메시지 데이터에 접근하기 위해 필요';
      case PermissionType.SPEECH:
        return '음성 인식 서비스를 제공하기 위해 필요';
      case PermissionType.STORAGE:
        return '내부 저장소에 접근하기 위해 필요';
      case PermissionType.NOTIFICATION:
        return '푸시 알림 서비스를 제공하기 위해 필요';
      case PermissionType.ACCESS_MEDIA_LOCATION:
        return '외부 저장소에 접근하기 위해 필요';
      case PermissionType.ACTIVITY_RECOGNITION:
        return '활동 인식 서비스를 제공하기 위해 필요';
      case PermissionType.BLUETOOTH:
        return '블루투스 연결 상태를 관리하기 위해 필요';
      case PermissionType.SYSTEM_ALERT_WINDOW:
        return '다른 앱 위에 컨텐츠를 표시하기 위해 필요';
      case PermissionType.UNKNOWN:
        return 'unknown';
    }
  }

  /// [permissionType]에 해당하는 [Permission] 객체를 반환한다.
  Permission getPermissionObject(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.CALENDAR:
        return Permission.calendar;
      case PermissionType.CAMERA:
        return Permission.camera;
      case PermissionType.CONTACTS:
        return Permission.contacts;
      case PermissionType.LOCATION:
        return Permission.location;
      case PermissionType.MEDIA_LIBRARY:
        return Permission.mediaLibrary;
      case PermissionType.MICROPHONE:
        return Permission.microphone;
      case PermissionType.PHONE:
        return Permission.phone;
      case PermissionType.PHOTOS:
        return Permission.photos;
      case PermissionType.REMINDERS:
        return Permission.reminders;
      case PermissionType.BODY_SENSORS:
        return Permission.sensors;
      case PermissionType.SMS:
        return Permission.sms;
      case PermissionType.SPEECH:
        return Permission.speech;
      case PermissionType.STORAGE:
        return Permission.storage;
      case PermissionType.NOTIFICATION:
        return Permission.notification;
      case PermissionType.ACCESS_MEDIA_LOCATION:
        return Permission.accessMediaLocation;
      case PermissionType.ACTIVITY_RECOGNITION:
        return Permission.activityRecognition;
      case PermissionType.BLUETOOTH:
        return Permission.bluetooth;
      case PermissionType.SYSTEM_ALERT_WINDOW:
        return Permission.unknown;
      case PermissionType.UNKNOWN:
        return Permission.unknown;
    }
  }

  /// 앱 권한[permissions] 허용 여부를 확인한다.
  Future<bool> isGrantedPermissions(List<PermissionData> permissions) async {
    final filteredPermissions = await filterByVersion(filterByPlatform(permissions));
    PermissionData permissionData;
    PermissionType permissionType;
    Permission permission;

    for (var i=0; i<filteredPermissions.length; i++) {
      permissionData = filteredPermissions[i];
      permissionType = permissionData.permissionType;
      permission = getPermissionObject(permissionType);

      if (permissionType == PermissionType.SYSTEM_ALERT_WINDOW) {
        if (!await canDrawOverlays() && permissionData.necessary)
          return false;
      } else {
        if (await permission.isDenied && permissionData.necessary)
          return false;
      }
    }

    return true;
  }

  /// 앱 권한[Permissions] 요청한다.
  Future<bool> requestPermissions(List<PermissionData> permissions) async {
    final filteredPermissions = await filterByVersion(filterByPlatform(permissions));
    PermissionType permissionType;
    final permissionToRequest = <Permission>[];
    bool willRequestOverlayPermission = false;

    for (var i=0; i<filteredPermissions.length; i++) {
      permissionType = filteredPermissions[i].permissionType;
      permissionToRequest.add(getPermissionObject(permissionType));

      if (permissionType == PermissionType.SYSTEM_ALERT_WINDOW)
        if (!await canDrawOverlays() && permissions[i].necessary)
          willRequestOverlayPermission = true;
    }

    if (willRequestOverlayPermission)
      await requestOverlayPermission();
    await permissionToRequest.request();

    return await isGrantedPermissions(permissions);
  }

  /// 플랫폼에서 사용되지 않는 앱 권한[permissions]을 필터링한다.
  List<PermissionData> filterByPlatform(List<PermissionData> permissions) {
    PermissionType permissionType;

    final filteredPermissions = <PermissionData>[];
    for (var i=0; i<permissions.length; i++) {
      permissionType = permissions[i].permissionType;

      if (Platform.isAndroid) {
        if (permissionType == PermissionType.MEDIA_LIBRARY
            || permissionType == PermissionType.PHOTOS
            || permissionType == PermissionType.REMINDERS)
          continue;
      } else {
        if (permissionType == PermissionType.PHONE
            || permissionType == PermissionType.SMS
            || permissionType == PermissionType.ACTIVITY_RECOGNITION
            || permissionType == PermissionType.SYSTEM_ALERT_WINDOW)
          continue;
      }

      filteredPermissions.add(permissions[i]);
    }

    return filteredPermissions;
  }

  /// 특정 버전에서 사용되지 않는 앱 권한[permissions]을 필터링한다.
  Future<List<PermissionData>> filterByVersion(List<PermissionData> permissions) async {
    PermissionType permissionType;

    AndroidDeviceInfo? aInfo;
    if (Platform.isAndroid)
      aInfo = await DeviceInfoPlugin().androidInfo;

    // IosDeviceInfo? iInfo;
    // if (Platform.isIOS)
    //   iInfo = await DeviceInfoPlugin().iosInfo;

    final filteredPermissions = <PermissionData>[];
    for (var i=0; i<permissions.length; i++) {
      permissionType = permissions[i].permissionType;

      if (Platform.isAndroid
          && aInfo!.version.sdkInt < 29
          && permissionType == PermissionType.ACTIVITY_RECOGNITION)
        continue;

      filteredPermissions.add(permissions[i]);
    }

    return filteredPermissions;
  }

  /// 윈도우(Overlay) 권한 허용 여부를 확인한다.
  Future<bool> canDrawOverlays() async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('canDrawOverlays');
    else
      return Future.value(false);
  }

  /// 윈도우(Overlay) 권한을 요청한다.
  Future<bool> requestOverlayPermission() async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('requestOverlayPermission');
    else
      return Future.value(false);
  }

  /// 윈도우(Overlay) 권한을 요청할 것인지 질문 후 권한을 요청한다.
  Future<bool> requestOverlayPermissionWithDialog(String serviceName) async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('requestOverlayPermissionWithDialog',
          {'serviceName': serviceName});
    else
      return Future.value(false);
  }

  /// 위치 서비스 활성화 여부를 확인한다.
  Future<bool> isLocationServiceEnabled() async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('isLocationServiceEnabled');
    else
      return Future.value(true);
  }

  /// 위치 서비스 활성화 요청한다.
  Future<bool> requestLocationService() async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('requestLocationService');
    else
      return Future.value(true);
  }

  /// 위치 서비스를 활성화할 것인지 질문 후 활성화 요청한다.
  Future<bool> requestLocationServiceWithDialog(String serviceName) async {
    if (Platform.isAndroid)
      return await _channel.invokeMethod('requestLocationServiceWithDialog',
          {'serviceName': serviceName});
    else
      return Future.value(true);
  }
}
