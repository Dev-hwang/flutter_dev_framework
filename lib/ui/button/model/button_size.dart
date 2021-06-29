import 'package:flutter/material.dart';

/// 버튼 사이즈
enum ButtonSize {
  APPLE_SMALL,      // 30px
  APPLE_MEDIUM,     // 44px
  APPLE_LARGE,      // 50px
  APPLE_XLARGE,     // 57px

  MATERIAL_SMALL,   // 28px
  MATERIAL_MEDIUM,  // 36px
  MATERIAL_LARGE,   // 48px
  MATERIAL_XLARGE,  // 56px

  FACEBOOK_SMALL,   // 32px
  FACEBOOK_MEDIUM,  // 40px
  FACEBOOK_LARGE,   // 48px

  POLARIS_SMALL,    // 30px
  POLARIS_MEDIUM,   // 36px
  POLARIS_LARGE     // 44px
}

extension ButtonSizeExtension on ButtonSize {
  double get minWidth {
    switch (this) {
      case ButtonSize.APPLE_SMALL: return 0.0;
      case ButtonSize.APPLE_MEDIUM: return 0.0;
      case ButtonSize.APPLE_LARGE: return 0.0;
      case ButtonSize.APPLE_XLARGE: return 0.0;

      case ButtonSize.MATERIAL_SMALL: return 0.0;
      case ButtonSize.MATERIAL_MEDIUM: return 0.0;
      case ButtonSize.MATERIAL_LARGE: return 0.0;
      case ButtonSize.MATERIAL_XLARGE: return 0.0;

      case ButtonSize.FACEBOOK_SMALL: return 0.0;
      case ButtonSize.FACEBOOK_MEDIUM: return 0.0;
      case ButtonSize.FACEBOOK_LARGE: return 0.0;

      case ButtonSize.POLARIS_SMALL: return 0.0;
      case ButtonSize.POLARIS_MEDIUM: return 0.0;
      case ButtonSize.POLARIS_LARGE: return 0.0;
    }
  }

  double get minHeight {
    switch (this) {
      case ButtonSize.APPLE_SMALL: return 30.0;
      case ButtonSize.APPLE_MEDIUM: return 44.0;
      case ButtonSize.APPLE_LARGE: return 50.0;
      case ButtonSize.APPLE_XLARGE: return 57.0;
      case ButtonSize.MATERIAL_SMALL: return 28.0;
      case ButtonSize.MATERIAL_MEDIUM: return 36.0;
      case ButtonSize.MATERIAL_LARGE: return 48.0;
      case ButtonSize.MATERIAL_XLARGE: return 56.0;
      case ButtonSize.FACEBOOK_SMALL: return 32.0;
      case ButtonSize.FACEBOOK_MEDIUM: return 40.0;
      case ButtonSize.FACEBOOK_LARGE: return 48.0;
      case ButtonSize.POLARIS_SMALL: return 30.0;
      case ButtonSize.POLARIS_MEDIUM: return 36.0;
      case ButtonSize.POLARIS_LARGE: return 44.0;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case ButtonSize.APPLE_SMALL:
      case ButtonSize.MATERIAL_SMALL:
      case ButtonSize.FACEBOOK_SMALL:
      case ButtonSize.POLARIS_SMALL:
        return EdgeInsets.symmetric(horizontal: 14.0);
      case ButtonSize.MATERIAL_MEDIUM:
      case ButtonSize.FACEBOOK_MEDIUM:
      case ButtonSize.POLARIS_MEDIUM:
        return EdgeInsets.symmetric(horizontal: 18.0);
      case ButtonSize.APPLE_MEDIUM:
      case ButtonSize.APPLE_LARGE:
      case ButtonSize.MATERIAL_LARGE:
      case ButtonSize.FACEBOOK_LARGE:
      case ButtonSize.POLARIS_LARGE:
        return EdgeInsets.symmetric(horizontal: 24.0);
      case ButtonSize.APPLE_XLARGE:
      case ButtonSize.MATERIAL_XLARGE:
        return EdgeInsets.symmetric(horizontal: 32.0);
    }
  }
}
