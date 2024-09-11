//
//  AppDelegate.m
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//
#import <IQKeyboardManager/IQKeyboardManager.h>

#import "YoAppDelegate.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "SDKWrapper.h"
#import "platform/ios/CCEAGLView-ios.h"
#import "Adjust.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

using namespace cocos2d;

@implementation YoAppDelegate

Application* app = nullptr;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[SDKWrapper getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    NSString *Yoadidtpken = @"7jsxv49edqww";
    NSString *yoadidment = ADJEnvironmentProduction;
    ADJConfig* Yoadid = [ADJConfig configWithAppToken:Yoadidtpken
                                   environment:yoadidment];
    [Yoadid setLogLevel:ADJLogLevelVerbose];
    
    float mainscale = [[UIScreen mainScreen] scale];
    CGRect mainbounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: mainbounds];
    app = new AppDelegate(mainbounds.size.width * mainscale, mainbounds.size.height * mainscale);
    app->setMultitouch(true);
    _YoWagerqueController = [[RootViewController alloc]init];
    [self.window setRootViewController:_YoWagerqueController];
    [self.window makeKeyAndVisible];
    app->start();
    [Adjust appDidLaunch:Yoadid];
    return YES;
}


- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
  }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    app->onPause();
    [[SDKWrapper getInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
    app->onResume();
    [[SDKWrapper getInstance] applicationDidBecomeActive:application];
    [Adjust requestTrackingAuthorizationWithCompletionHandler:^(NSUInteger status) {

    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[SDKWrapper getInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
    [[SDKWrapper getInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SDKWrapper getInstance] applicationWillTerminate:application];
    delete app;
    app = nil;
}

@end







