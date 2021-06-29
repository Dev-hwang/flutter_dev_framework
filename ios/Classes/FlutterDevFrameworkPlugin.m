#import "FlutterDevFrameworkPlugin.h"
#if __has_include(<flutter_dev_framework/flutter_dev_framework-Swift.h>)
#import <flutter_dev_framework/flutter_dev_framework-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_dev_framework-Swift.h"
#endif

@implementation FlutterDevFrameworkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDevFrameworkPlugin registerWithRegistrar:registrar];
}
@end
