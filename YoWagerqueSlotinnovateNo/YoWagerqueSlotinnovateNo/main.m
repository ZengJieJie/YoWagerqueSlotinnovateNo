//
//  main.m
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//

#import <UIKit/UIKit.h>
#import "YoAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([YoAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
