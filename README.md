This plugin contains components, utilities, etc. to make Flutter app development easy.

## Directory

``` bash
├── blocs
│   ├── bloc.dart               // BLoC 구현에 필요한 함수를 제공하는 추상 클래스
│   ├── progress_bloc.dart      // 프로그레스 상태 관리 기능이 구현된 BLoC
│   └── stream_bloc.dart        // 스트림 처리 기능이 구현된 BLoC
├── logger
│   ├── model
│   │   ├── log_event.dart      // 로그 이벤트
│   │   └── log_level.dart      // 로그 레벨
│   ├── logger.dart             // Sentry 플러그인 모듈이 포함된 Logger
│   └── printer.dart            // 예쁘게 정리된 로그를 생성해 주는 Printer
├── network
│   ├── exception
│   │   └── api_exception.dart          // API 예외
│   ├── model
│   │   ├── charset.dart                // 문자 인코딩 방식
│   │   ├── http_media_type.dart        // HTTP 미디어 타입
│   │   ├── http_request_method.dart    // HTTP 요청 메소드
│   │   └── network_protocol.dart       // 네트워크 프로토콜
│   └── rest_api.dart                   // REST API 구현에 필요한 기능을 제공하는 추상 클래스
├── permission
│   ├── model
│   │   ├── permission_data.dart        // 앱 권한 데이터
│   │   └── permission_type.dart        // 앱 권한 종류
│   ├── permission_check_page.dart      // 앱 권한 체크 기능이 구현된 페이지
│   └── permission_utils.dart           // 앱 권한 유틸리티
├── ui
│   ├── button
│   │   ├── model
│   │   │   └── button_size.dart        // 버튼 사이즈
│   │   ├── date_picker_button.dart     // 날짜 선택 버튼
│   │   ├── drop_down_button.dart       // 메뉴 선택 버튼
│   │   ├── gradient_button.dart        // 그라데이션 버튼
│   │   ├── oval_ghost_button.dart      // 타원형 고스트 버튼
│   │   └── simple_button.dart          // ElevatedButton 기반 심플 버튼
│   ├── component
│   │   ├── android_toast.dart          // 안드로이드 토스트
│   │   ├── dots_page_indicator.dart    // 도트형 페이지 인디케이터
│   │   ├── fade_page_route.dart        // FadeTransition PageRoute
│   │   ├── gradient_app_bar.dart       // Gradient AppBar
│   │   ├── speech_bubble.dart          // 말풍선 위젯
│   │   └── widget_divider.dart         // 위젯 구분선
│   ├── dialog
│   │   ├── custom_dialog.dart          // 커스터마이징 가능한 다이얼로그
│   │   └── system_dialog.dart          // 플랫폼에서 제공하는 기본 다이얼로그
│   └── pages
│       ├── with_drag_detector.dart     // 드래그 탐지 기능이 구현된 페이지
│       ├── with_progress_screen.dart   // 프로그레스 화면 구현 페이지
│       ├── with_scroll_up_button.dart  // 스크롤업 버튼 구현 페이지
│       ├── with_theme_manager.dart     // 앱 테마 관리 기능이 구현된 페이지
│       └── with_will_pop_scope.dart    // 앱 종료 확인 기능이 구현된 페이지
├── utils
│   ├── date_time_utils.dart        // 날짜 시간 유틸리티
│   ├── encryption_utils.dart       // 암호화 유틸리티
│   ├── exception_utils.dart        // 예외 처리 유틸리티
│   ├── file_manage_utils.dart      // 파일 관리 유틸리티
│   ├── notification_utils.dart     // 푸시 알림 유틸리티
│   ├── system_utils.dart           // 시스템 유틸리티
│   ├── text_format_utils.dart      // 텍스트 포맷 유틸리티
│   └── web_image_utils.dart        // 웹 이미지 유틸리티
└── flutter_dev_framework.dart
```

## Getting started

To use this plugin, add `flutter_dev_framework` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  flutter_dev_framework:
    git:
      url: https://github.com/Dev-hwang/flutter_dev_framework.git
      ref: master
```

## Usage

특정 패키지나 컴포넌트를 사용하려면 플랫폼별 초기 설정이 필요하다.

### :baby_chick: logger package

1. [sentry.io](https://sentry.io/welcome/) 회원가입을 진행한다.

2. 프로젝트를 생성하고 DSN 값을 얻는다.

3. 프로젝트의 `main` 함수에 아래와 같이 `Sentry` 플러그인을 초기화한다.

``` dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/flutter_dev_framework.dart';

void main() {
  const sentryDsn = 'https://80ab98a9a0b448e0b591d2d5db20c47b@o332735.ingest.sentry.io/5490503';

  runZonedGuarded(() async {
    // Error Tracking && Logging Aggregation
    await Sentry.init((options) {
      options.dsn = sentryDsn;
    });

    runApp(MobileApp());
  }, (error, stackTrace) async {
    await Logger.f('FATAL EXCEPTION', error: error, stackTrace: stackTrace);
  });
}
```

### :baby_chick: network package

network 패키지 사용 시 아래 권한 추가 필요

#### Android

/android/app/src/main/AndroidManifest.xml

``` xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

#### iOS

/ios/Runner/info.plist

``` xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
  <key>NSAllowsArbitraryLoadsInWebContent</key>
  <true/>
</dict>
```

### :baby_chick: permission package

permission 패키지 사용 시 필요 권한 추가 필요

#### Android

/android/app/src/main/AndroidManifest.xml

``` xml
<!-- Permissions options for the `CALENDAR` group -->
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />

<!-- Permissions options for the `CAMERA` group -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Permissions options for the `CONTACTS` group -->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.GET_ACCOUNTS" />

<!-- Permissions options for the `STORAGE` group -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- Permissions options for the `SMS` group -->
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
<uses-permission android:name="android.permission.RECEIVE_MMS" />

<!-- Permissions options for the `PHONE` group -->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ADD_VOICEMAIL" />
<uses-permission android:name="android.permission.USE_SIP" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<uses-permission android:name="android.permission.WRITE_CALL_LOG" />
<uses-permission android:name="android.permission.BIND_CALL_REDIRECTION_SERVICE" />

<!-- Permissions options for the `LOCATION` group -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<!-- Permissions options for the `MICROPHONE` or `SPEECH` group -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />

<!-- Permissions options for the `BODY_SENSORS` group -->
<uses-permission android:name="android.permission.BODY_SENSORS" />

<!-- Permissions options for the `ACCESS_MEDIA_LOCATION` group -->
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

<!-- Permissions options for the `ACTIVITY_RECOGNITION` group -->
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />

<!-- Permissions options for the `BLUETOOTH` group -->
<uses-permission android:name="android.permission.BLUETOOTH" />

<!-- Permissions options for the `SYSTEM_ALERT_WINDOW` group -->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
```

#### iOS

/ios/Runner/info.plist

``` xml
<!-- Permission options for the `CALENDAR` group -->
<key>NSCalendarsUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `CAMERA` group -->
<key>NSCameraUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `CONTACTS` group -->
<key>NSContactsUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `LOCATION` group -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>
<key>NSLocationUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `MICROPHONE` group -->
<key>NSMicrophoneUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `PHOTOS` group -->
<key>NSPhotoLibraryUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `MEDIA_LIBRARY` group -->
<key>NSAppleMusicUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>
<key>kTCCServiceMediaLibrary</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `BODY_SENSORS` group -->
<key>NSMotionUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `SPEECH` group -->
<key>NSSpeechRecognitionUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>

<!-- Permission options for the `REMINDERS` group -->
<key>NSRemindersUsageDescription</key>
<string>권한 요청 시 사용자에게 보여줄 메시지</string>
```

/ios/Podfile

``` xml
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## 아래 표를 참고하여 사용할 권한에 대한 매크로를 추가한다.
        'PERMISSION_LOCATION=1',
        'PERMISSION_NOTIFICATIONS=1'
      ]
    end

    flutter_additional_ios_build_settings(target)
  end
end
```

| Permission                        | Info.plist                                                                                                    | Macro                                |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| PermissionType.CALENDAR           | NSCalendarsUsageDescription                                                                                   | PERMISSION_EVENTS                    |
| PermissionType.REMINDERS          | NSRemindersUsageDescription                                                                                   | PERMISSION_REMINDERS                 |
| PermissionType.CONTACTS           | NSContactsUsageDescription                                                                                    | PERMISSION_CONTACTS                  |
| PermissionType.CAMERA             | NSCameraUsageDescription                                                                                      | PERMISSION_CAMERA                    |
| PermissionType.MICROPHONE         | NSMicrophoneUsageDescription                                                                                  | PERMISSION_MICROPHONE                |
| PermissionType.SPEECH             | NSSpeechRecognitionUsageDescription                                                                           | PERMISSION_SPEECH_RECOGNIZER         |
| PermissionType.PHOTOS             | NSPhotoLibraryUsageDescription                                                                                | PERMISSION_PHOTOS                    |
| PermissionType.LOCATION           | NSLocationUsageDescription, NSLocationAlwaysAndWhenInUseUsageDescription, NSLocationWhenInUseUsageDescription | PERMISSION_LOCATION                  |
| PermissionType.NOTIFICATION       | PermissionGroupNotification                                                                                   | PERMISSION_NOTIFICATIONS             |
| PermissionType.MEDIA_LIBRARY      | NSAppleMusicUsageDescription, kTCCServiceMediaLibrary                                                         | PERMISSION_MEDIA_LIBRARY             |
| PermissionType.BODY_SENSORS       | NSMotionUsageDescription                                                                                      | PERMISSION_SENSORS                   |
| PermissionType.BLUETOOTH          | NSBluetoothAlwaysUsageDescription, NSBluetoothPeripheralUsageDescription                                      | PERMISSION_BLUETOOTH                 |

### :baby_chick: notification_utils

#### Android

/android/app/src/main/AndroidManifest.xml

``` xml
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

``` xml
<application
  android:name="io.flutter.app.FlutterApplication"
  ...>

  <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
  <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
    <intent-filter>
      <action android:name="android.intent.action.BOOT_COMPLETED" />
    </intent-filter>
  </receiver>

</application>
```

/android/app/proguard-rules.pro

``` xml
-keep class com.dexterous.** { *; }
```

#### iOS

/ios/Runner/AppDelegate.swift

``` xml
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### :baby_chick: date_picker_button

/project/pubspec.yaml

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
```

/project/lib/main.dart

``` dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    localizationsDelegates: [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en'),
      const Locale('ko'),
    ],
    ...
  );
}
```

## Prepare release

### :star2: keystore 생성 및 서명 구성

#### 1. 터미널에 아래 명령어를 입력하여 keystore 파일을 생성한다.

맥/리눅스에서는 아래 명령어를 사용하세요:
``` text
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

윈도우에서는 아래 명령어를 사용하세요:
``` text
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

#### 2. /android/key.properties 파일을 생성하고 아래 내용을 입력한다.

``` text
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<key store 파일 위치, 예) /Users/<user name>/key.jks>
```

#### 3. /android/app/build.gradle 파일에 아래 코드를 추가한다.

``` text
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // 기본 코드 생략..

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### :star2: 코드 난독화

#### 1. /android/app/proguard-rules.pro 파일을 생성하고 아래 내용을 입력한다.

``` text
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**
```

#### 2. /android/app/build.gradle 파일에 아래 코드를 추가한다.
``` text
android {
    // 기본 코드 생략..

    buildTypes {
        release {
            shrinkResources true
            minifyEnabled true
            signingConfig signingConfigs.release
            proguardFiles getDefaultProguardFile(
                    'proguard-android-optimize.txt'),
                    'proguard-rules.pro'
        }

        debug {
            minifyEnabled false
            proguardFiles getDefaultProguardFile(
                    'proguard-android-optimize.txt'),
                    'proguard-rules.pro'
        }
    }
}
```

자세한 내용은 [공식 홈페이지](https://flutter-ko.dev/docs/deployment/android) 참조
