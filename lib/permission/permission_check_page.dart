import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dev_framework/permission/model/permission_data.dart';
import 'package:flutter_dev_framework/permission/permission_utils.dart';
import 'package:flutter_dev_framework/ui/button/model/button_size.dart';
import 'package:flutter_dev_framework/ui/button/simple_button.dart';
import 'package:flutter_dev_framework/ui/component/fade_page_route.dart';
import 'package:flutter_dev_framework/ui/component/widget_divider.dart';
import 'package:flutter_dev_framework/ui/dialog/system_dialog.dart';
import 'package:flutter_dev_framework/utils/exception_utils.dart';
import 'package:flutter_dev_framework/utils/system_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 초기화 함수
typedef InitFunction = Future<InitResult> Function();

/// SplashView 빌더
typedef SplashViewBuilder = Widget Function();

/// PermissionViewHeader 빌더
typedef PermissionViewHeaderBuilder = Widget Function();

/// PermissionListAdapter 빌더
typedef PermissionListAdapterBuilder = Widget Function(PermissionData permission);

/// 초기화 결과
class InitResult {
  /// 초기화 성공 여부
  final bool complete;

  /// 오류 메시지 출력 여부
  final bool showingError;

  /// 오류
  final dynamic error;

  /// 스택 트레이스
  final dynamic stackTrace;

  const InitResult({
    required this.complete,
    this.showingError = true,
    this.error,
    this.stackTrace,
  });
}

/// 앱 권한 체크 기능이 구현된 페이지
class PermissionCheckPage extends StatefulWidget {
  /// 체크할 앱 권한 데이터 목록
  final List<PermissionData> permissions;

  /// SplashView 빌더
  final SplashViewBuilder? splashViewBuilder;

  /// PermissionViewHeader 빌더
  final PermissionViewHeaderBuilder? permissionViewHeaderBuilder;

  /// PermissionListAdapter 빌더
  final PermissionListAdapterBuilder? permissionListAdapterBuilder;

  /// 헤더에 표시할 앱 아이콘 파일 경로
  final String appIconAssetsPath;

  /// 헤더에 포함된 요청 메시지 색상
  /// 기본값 `Colors.black`
  final Color? requestMessageColor;

  /// 앱 권한 아이콘 색상
  /// 기본값 `Colors.black`
  final Color? permissionIconColor;

  /// 앱 이름 텍스트 색상
  /// 기본값 `Colors.black`
  final Color? permissionNameColor;

  /// 앱 설명 텍스트 색상
  /// 기본값 `const Color(0xFF999999)`
  final Color? permissionDescColor;

  /// 스플래시 화면을 유지할 시간
  /// 기본값 `const Duration(seconds: 1)`
  final Duration splashDuration;

  /// 앱 권한 체크 후 실행할 초기화 함수
  final InitFunction initFunction;

  /// 초기화 함수 실행 후 이동할 다음 페이지
  final Widget nextPage;

  const PermissionCheckPage({
    Key? key,
    required this.permissions,
    this.splashViewBuilder,
    this.permissionViewHeaderBuilder,
    this.permissionListAdapterBuilder,
    required this.appIconAssetsPath,
    this.requestMessageColor = Colors.black,
    this.permissionIconColor = Colors.black,
    this.permissionNameColor = Colors.black,
    this.permissionDescColor = const Color(0xFF999999),
    this.splashDuration = const Duration(seconds: 1),
    required this.initFunction,
    required this.nextPage,
  })  : super(key: key);

  @override
  _PermissionCheckPageState createState() => _PermissionCheckPageState();
}

class _PermissionCheckPageState extends State<PermissionCheckPage> with TickerProviderStateMixin {
  final _splashViewVisibleStateController = StreamController<bool>();
  final _filteredPermissions = <PermissionData>[];

  late AnimationController _animationController;
  late Animation<double>   _animation;

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  void _checkPermissions(List<PermissionData> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    final firstCheck = prefs.getBool('firstCheck') ?? true;

    PermissionUtils.instance.isGrantedPermissions(permissions).then((isGranted) {
      (isGranted && !firstCheck)
          ? _registerSplashTimer()
          : _splashViewVisibleStateController.sink.add(false);
    });
  }

  void _requestPermissions(List<PermissionData> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstCheck', false);
    
    PermissionUtils.instance.requestPermissions(permissions).then((isGranted) {
      (isGranted)
          ? _registerSplashTimer()
          : _showDialogWhenDenyingRequiredPermissions();
    });
  }

  void _registerSplashTimer() async {
    _splashViewVisibleStateController.sink.add(true);

    final initResult = await widget.initFunction();
    if (initResult.complete) {
      Timer(widget.splashDuration, () async {
        await _animationController.reverse();
        final route = FadePageRoute(builder: (_) => widget.nextPage);
        Navigator.pushReplacement(context, route);
      });
    } else if (!initResult.complete && initResult.showingError) {
      final errorReason = ExceptionUtils.instance.getReasonByException(
          initResult.error,
          unknownIssueMsg: '앱 초기화에 실패하여 앱을 시작할 수 없습니다. 다시 시도하시겠습니까?');
      _showDialogWhenShowingError(errorReason);
    }
  }

  void _showDialogWhenDenyingRequiredPermissions() {
    SystemDialog(content: '어플리케이션을 사용하려면 필수 권한을 허용해야 합니다.').show(context);
  }

  void _showDialogWhenShowingError(String errorReason) {
    SystemDialog(
      content: errorReason,
      positiveButtonText: '재시도',
      negativeButtonText: '종료',
      onPositiveButtonPressed: () => _registerSplashTimer(),
      onNegativeButtonPressed: () => SystemUtils.instance.forcePop(),
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    final permissions = PermissionUtils.instance.filterByPlatform(widget.permissions);
    _filteredPermissions.addAll(permissions);
    _checkPermissions(permissions);
  }

  @override
  void dispose() {
    _splashViewVisibleStateController.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<bool>(
        stream: _splashViewVisibleStateController.stream,
        initialData: true,
        builder: (context, snapshot) {
          return (snapshot.data ?? true)
              ? _buildSplashView()
              : _buildPermissionView();
        },
      ),
    );
  }

  Widget _buildSplashView() {
    Widget splashView;
    if (widget.splashViewBuilder != null)
      splashView = widget.splashViewBuilder!();
    else
      splashView = Center(child: Image.asset(widget.appIconAssetsPath, height: 80.0));

    return FadeTransition(opacity: _animation, child: splashView);
  }

  Widget _buildPermissionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildPermissionViewHeader(),
        Expanded(child: _buildPermissionListView()),
        _buildPermissionRequestButton(),
      ],
    );
  }

  Widget _buildPermissionViewHeader() {
    if (widget.permissionViewHeaderBuilder != null)
      return widget.permissionViewHeaderBuilder!();

    final textStyle = Theme.of(context).textTheme.headline6
        ?.copyWith(color: widget.requestMessageColor);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 10.0),
          child: Image.asset(widget.appIconAssetsPath, height: 50.0),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
          child: Text('어플리케이션 사용을 위해\n다음 접근 권한을 허용해주세요.', style: textStyle),
        ),
        WidgetDivider(direction: Axis.horizontal),
      ],
    );
  }

  Widget _buildPermissionListView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredPermissions.length,
      itemBuilder: (context, index) =>
          _buildPermissionListAdapter(_filteredPermissions[index]),
    );
  }

  Widget _buildPermissionListAdapter(PermissionData permission) {
    if (widget.permissionListAdapterBuilder != null)
      return widget.permissionListAdapterBuilder!(permission);

    final permissionIcon = PermissionUtils.instance
        .getPermissionIcon(permission.permissionType, widget.permissionIconColor);
    final permissionName = PermissionUtils.instance
        .getPermissionName(permission.permissionType, permission.necessary);
    final permissionDesc = permission.description
        ?? PermissionUtils.instance.getPermissionDesc(permission.permissionType);

    final permissionNameStyle = Theme.of(context).textTheme.subtitle1
        ?.copyWith(color: widget.permissionNameColor, height: 1.2);
    final permissionDescStyle = Theme.of(context).textTheme.bodyText2
        ?.copyWith(color: widget.permissionDescColor);

    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          permissionIcon,
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(permissionName, style: permissionNameStyle),
                SizedBox(height: 2.0),
                Text(permissionDesc, style: permissionDescStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRequestButton() {
    return SimpleButton(
      buttonSize: ButtonSize.MATERIAL_XLARGE,
      text: '확인',
      onPressed: () => _requestPermissions(_filteredPermissions),
    );
  }
}
