#import "FlutterBiopassPlugin.h"
#import <flutter_biopass/flutter_biopass-Swift.h>

@implementation FlutterBiopassPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBiopassPlugin registerWithRegistrar:registrar];
}
@end
