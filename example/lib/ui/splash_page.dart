import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/permission/model/permission_data.dart';
import 'package:flutter_dev_framework/permission/model/permission_type.dart';
import 'package:flutter_dev_framework/permission/permission_check_page.dart';
import 'package:flutter_dev_framework_example/ui/main_page.dart';

/// 앱에서 사용하는 권한 목록
const List<PermissionData> kAppPermissions = [
  PermissionData(permissionType: PermissionType.LOCATION, necessary: true),
  PermissionData(permissionType: PermissionType.STORAGE, necessary: true),
  PermissionData(permissionType: PermissionType.NOTIFICATION, necessary: true)
];

/// 스플레쉬 페이지
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<InitResult> _initFunction() async {
    InitResult initResult;
    try {
      // 초기화 작업 (버전 체크, 데이터 초기화 등)
      initResult = InitResult(complete: true);
    } catch (error, stackTrace) {
      // 오류 메시지 출력
      initResult = InitResult(
          complete: false, error: error, stackTrace: stackTrace);
    }

    // complete true 리턴 시 nextPage 이동
    return Future.value(initResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionCheckPage(
        permissions: kAppPermissions,
        appIconAssetsPath: 'assets/images/ic_launcher.png',
        requestMessageColor: Theme.of(context).textTheme.headline6?.color,
        permissionIconColor: Theme.of(context).textTheme.subtitle1?.color,
        permissionNameColor: Theme.of(context).textTheme.subtitle1?.color,
        permissionDescColor: Theme.of(context).textTheme.caption?.color,
        initFunction: _initFunction,
        nextPage: MainPage(),
      ),
    );
  }
}
