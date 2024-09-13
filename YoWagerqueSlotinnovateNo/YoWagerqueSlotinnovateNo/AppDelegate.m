//
//  AppDelegate.m
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface AppDelegate ()<AppsFlyerLibDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[IQKeyboardManager sharedManager] setEnable:YES];
    AppsFlyerLib *appsFlyer = [AppsFlyerLib shared];
    appsFlyer.appsFlyerDevKey = [NSString stringWithFormat:@"%@%@%@", @"R9CH5Zs5byt", @"FgTj6sm",@"kgG8"];
    appsFlyer.appleAppID = @"6670750174";
    [appsFlyer waitForATTUserAuthorizationWithTimeoutInterval:60];
    appsFlyer.delegate = self;

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [AppsFlyerLib.shared start];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (@available(iOS 14, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            }];
        }
    });
}

- (void)onConversionDataSuccess:(NSDictionary *)conversionInfo
{
    NSLog(@"successfull af");
}

- (void)onConversionDataFail:(NSError *)error
{
    NSLog(@"onConversionDataFail");
}

@end
