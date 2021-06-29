import 'package:flutter_dev_framework/permission/model/permission_type.dart';

/// 앱 권한 데이터
class PermissionData {
  final PermissionType permissionType;
  final String? description;
  final bool necessary;

  const PermissionData({
    required this.permissionType,
    this.description,
    this.necessary = false
  });
}
