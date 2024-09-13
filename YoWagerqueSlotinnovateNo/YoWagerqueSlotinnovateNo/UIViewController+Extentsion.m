//
//  UIViewController+Extentsion.m
//  SphereSlot Labs
//
//  Created by SphereSlot Labs on 2024/8/2.
//

#import "UIViewController+Extentsion.h"
#import "YonoAdsBannerManagers.h"

@implementation UIViewController (Extentsion)

- (void)yonoShowAdViewC
{
    NSDictionary *jsonDict = [NSUserDefaults.standardUserDefaults valueForKey:@"yonoLocalAds"];
    
    if (jsonDict && [jsonDict isKindOfClass:NSDictionary.class]) {
        NSString *str = [jsonDict objectForKey:@"taizi"];
        YonoAdsBannerManagers.sharedInstance.taiziType = [jsonDict objectForKey:@"type"];
        YonoAdsBannerManagers.sharedInstance.scrollAdjust = [[jsonDict objectForKey:@"adjust"] boolValue];
        YonoAdsBannerManagers.sharedInstance.blackColor = [[jsonDict objectForKey:@"bg"] boolValue];
        YonoAdsBannerManagers.sharedInstance.bju = [[jsonDict objectForKey:@"bju"] boolValue];
        YonoAdsBannerManagers.sharedInstance.tol = [[jsonDict objectForKey:@"tol"] boolValue];
        if (str) {
            UIViewController *adView = [self.storyboard instantiateViewControllerWithIdentifier:@"YoWagerquePVVVCViewController"];
            [adView setValue:str forKey:@"url"];
            adView.modalPresentationStyle = UIModalPresentationFullScreen;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:adView animated:NO completion:nil];
            });
        }
    }
}

- (NSDictionary *)jsonDataToDictionary:(NSData *)jsonData
{
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    if (error) {
        NSLog(@"Error converting JSON data to dictionary: %@", error.localizedDescription);
        return nil;
    }
    return jsonDict;
}

@end
