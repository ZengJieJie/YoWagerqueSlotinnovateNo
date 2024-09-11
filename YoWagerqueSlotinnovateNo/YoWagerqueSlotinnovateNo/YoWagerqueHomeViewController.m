//
//  ViewController.m
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//

#import "YoWagerqueHomeViewController.h"
#import "YoWagerqueSlotinnovateNo-Swift.h"
#import "RootViewController.h"
#import "YoAppDelegate.h"

@interface YoWagerqueHomeViewController ()

@end

@implementation YoWagerqueHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)YoWagerqueinitiate
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *gameHomeVC = [storyboard instantiateInitialViewController];
    RootViewController *rootVC = [(YoAppDelegate *)UIApplication.sharedApplication.delegate YoWagerqueController];
    gameHomeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootVC presentViewController:gameHomeVC animated:NO completion:nil];
    
    NSLog(@"11");
}

@end
