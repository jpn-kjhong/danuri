//
//  AppDelegate.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RainbowViewController.h"
#import "KoreanMovieViewController.h"
#import "KoreaGuideViewController.h"
#import "HelpCenterViewController.h"
#import "KoreaStoryViewController.h"
#import "GAI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate, UINavigationBarDelegate, UITabBarControllerDelegate>
{
    UITabBarController *tabbarController;
    UINavigationController *navi;
    RainbowViewController *rainbowViewController;
    KoreanMovieViewController *koreanMovieViewController;
    HelpCenterViewController *helpCenterViewController;
    KoreaGuideViewController *koreaGuideViewController;
    KoreaStoryViewController *koreaStoryViewcontroller;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *type;
@property(nonatomic, strong) id<GAITracker> tracker;
@property (strong, nonatomic) NSArray *arrState;

@end
