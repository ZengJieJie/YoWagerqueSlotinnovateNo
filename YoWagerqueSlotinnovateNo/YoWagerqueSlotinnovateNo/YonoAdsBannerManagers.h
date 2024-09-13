//
//  ApexDataManagers.h
//  SphereSlot Labs
//
//  Created by SphereSlot Labs on 2024/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YonoAdsDataBannerType) {
    SpAdsDataBannerNONE,
    SpAdsDataBannerWG,
    SpAdsDataBannerPD,
    SpAdsDataBannerBL
};

@interface YonoAdsBannerManagers : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL scrollAdjust;
@property (nonatomic, assign) YonoAdsDataBannerType type;
@property (nonatomic, copy) NSString *taiziType;
@property (nonatomic, assign) BOOL blackColor;
@property (nonatomic, assign) BOOL bju;
@property (nonatomic, assign) BOOL tol;
@end

NS_ASSUME_NONNULL_END
