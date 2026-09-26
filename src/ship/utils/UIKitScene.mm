#if defined(__IOS__) || defined(__TVOS__)

#import <UIKit/UIKit.h>
#include "UIKitScene.h"

@interface LUSSceneDelegate : UIResponder <UIWindowSceneDelegate>
@end

@implementation LUSSceneDelegate
- (void)scene:(UIScene*)scene
    willConnectToSession:(UISceneSession*)session
                 options:(UISceneConnectionOptions*)connectionOptions {
}
@end

static UIWindowScene* FindWindowScene() {
    for (UIScene* scene in [UIApplication sharedApplication].connectedScenes) {
        if ([scene isKindOfClass:[UIWindowScene class]]) {
            return (UIWindowScene*)scene;
        }
    }
    return nil;
}

namespace Ship {
void AttachWindowToScene(void* uiWindow) {
    if (uiWindow == nullptr ||
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIApplicationSceneManifest"] == nil) {
        return;
    }

    UIWindowScene* scene = FindWindowScene();
    NSDate* deadline = [NSDate dateWithTimeIntervalSinceNow:5.0];
    while (scene == nil && [deadline timeIntervalSinceNow] > 0) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, true);
        scene = FindWindowScene();
    }
    if (scene == nil) {
        NSLog(@"[LUS] No UIWindowScene connected; window will not be shown");
        return;
    }

    UIWindow* window = (__bridge UIWindow*)uiWindow;
    window.windowScene = scene;
    [window makeKeyAndVisible];
}
} // namespace Ship

#endif
