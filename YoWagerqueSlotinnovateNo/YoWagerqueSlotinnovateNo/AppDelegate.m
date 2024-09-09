//
//  AppDelegate.m
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
            [[IQKeyboardManager sharedManager] setEnable:YES];
     

    return YES;
}





@end
