#import "FlutterTencentOcrPlugin.h"
#import <flutter_tencent_ocr/flutter_tencent_ocr-Swift.h>

@implementation FlutterTencentOcrPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterTencentOcrPlugin registerWithRegistrar:registrar];
}
@end
