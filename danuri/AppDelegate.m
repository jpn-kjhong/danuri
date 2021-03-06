//
//  AppDelegate.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectLangaugeViewController.h"
#import "CustomTabbarItem.h"
static NSString *const kTrackingId = @"UA-45495109-1";
static NSString *const kAllowTracking = @"allowTracking";
@interface AppDelegate ()

// Used for sending Google Analytics traffic in the background.
@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);

@end

#pragma mark - UINavigationBarCategory(UINavigationBarCategory)
@implementation UINavigationBar (UINavigationBarCategory)
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient;
    CGColorSpaceRef colorSpace;
    
    CGPoint startPoint;
    CGPoint endPoint;
    
    size_t num_locations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {62/255, 62/255, 63/255, 1.0, // start color
        45/255, 45/255, 45/255, 1.0}; //end color
    colorSpace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
    
    startPoint = CGPointMake(self.frame.size.width/2, 0.0);
    endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    CGFloat components2[8] = {45/255, 45/255, 45/255, 1.0, // start color
        26/255, 26/255, 26/255, 1.0}; //end color
    gradient = CGGradientCreateWithColorComponents(colorSpace, components2, locations, num_locations);
    
    startPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    //    UIColor *color = [UIColor colorWithRed:59/255.0 green:59/255.0 blue:59/255.0 alpha:1];
    //    //UIColor *color = [UIColor yellowColor];
    //    self.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient"]];;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0"))
    {
        if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
            [self setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
        }
        
    }
    else {
        @try {
            //          NSLog(@"appdelegate uinavigationbar category : %@ %@",self.subviews,[(UINavigationController *)[self nextResponder].nextResponder viewControllers]);
            UIImage *bgImage = [UIImage imageNamed:@"top"];
            [bgImage drawInRect:rect];
            
            id nextResponder = [self nextResponder];
            if (nextResponder == nil)
                return;
            else {
                id next2Responder = [nextResponder nextResponder];
                if (next2Responder == nil)
                    return;
                else {
                    if ([next2Responder respondsToSelector:@selector(viewControllers)]) {
                        NSArray *viewArray = [next2Responder viewControllers];
                        if ([viewArray count] == 1) {
                            UIImage *bgImage = [UIImage imageNamed:@"top"];
                            [bgImage drawInRect:rect];
                        }else{
                            UIImage *bgImage = [UIImage imageNamed:@"top"];
                            [bgImage drawInRect:rect];
                        }
                    }
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"error %@",exception);
        }
    }
    
}

@end

@implementation AppDelegate
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *pathURL= [NSURL fileURLWithPath:documentPath];
    
    NSLog(@"%@",documentPath);
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 5.0f){
        [self addSkipBackupAttributeToItemAtUrl:pathURL];
    }else{
        NSLog(@"CANNOT - CUZ VERSION IS UNDER 5.0.1");
    }
    
    // Override point for customization after application launch.
//    SelectLangaugeViewController *selectLangaugeViewController = [[SelectLangaugeViewController alloc] initWithNibName:@"SelectLangaugeViewController" bundle:nil];
//    self.window.rootViewController = selectLangaugeViewController;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    NSString *documents = [[NSFileManager defaultManager] directoryContentsAtPath:basePath];
//    NSURL *URL;
//    NSString *completeFilePath;
//    for (NSString *file in documents) {
//        completeFilePath = [NSString stringWithFormat:@"%@/%@", basePath, file];
//        URL = [NSURL fileURLWithPath:completeFilePath];
//        NSLog(@"File %@  is excluded from backup %@", file, [URL resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsExcludedFromBackupKey] error:nil]);
//    }
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
    
    // If your app runs for long periods of time in the foreground, you might consider turning
    // on periodic dispatching.  This app doesn't, so it'll dispatch all traffic when it goes
    // into the background instead.  If you wish to dispatch periodically, we recommend a 120
    // second dispatch interval.
    // [GAI sharedInstance].dispatchInterval = 120;
    [GAI sharedInstance].dispatchInterval = -1;
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    self.tracker = [[GAI sharedInstance] trackerWithName:@"Danuri_iOS"
                                              trackingId:kTrackingId];
    
    [self appInit];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)addSkipBackupAttributeToItemAtUrl:(NSURL *) URL
{
    //    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

// This method sends hits in the background until either we're told to stop background processing,
// we run into an error, or we run out of hits.  We use this to send any pending Google Analytics
// data since the app won't get a chance once it's in the background.
- (void)sendHitsInBackground {
    self.okToWait = YES;
    __weak AppDelegate *weakSelf = self;
    __block UIBackgroundTaskIdentifier backgroundTaskId =
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        weakSelf.okToWait = NO;
    }];
    
    if (backgroundTaskId == UIBackgroundTaskInvalid) {
        return;
    }
    
    self.dispatchHandler = ^(GAIDispatchResult result) {
        // If the last dispatch succeeded, and we're still OK to stay in the background then kick off
        // again.
        if (result == kGAIDispatchGood && weakSelf.okToWait ) {
            [[GAI sharedInstance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
        }
    };
    [[GAI sharedInstance] dispatchWithCompletionHandler:self.dispatchHandler];
}

- (void ) appInit
{
    tabbarController = [[UITabBarController alloc] init];

    rainbowViewController = [[RainbowViewController alloc] initWithNibName:@"RainbowViewController" bundle:nil];
    koreanMovieViewController = [[KoreanMovieViewController alloc] initWithNibName:@"KoreanMovieViewController" bundle:nil];
    koreaGuideViewController = [[KoreaGuideViewController alloc] initWithNibName:@"KoreaGuideViewController" bundle:nil];
    helpCenterViewController = [[HelpCenterViewController alloc] initWithNibName:@"HelpCenterViewController" bundle:nil];
    koreaStoryViewcontroller = [[KoreaStoryViewController alloc] initWithNibName:@"KoreaStoryViewController" bundle:nil];
    
#define fTabBarHeight 54
//    CGRect rectWindow = [[UIScreen mainScreen] bounds];
    
//    UITabBar *tabBar = [tabbarController tabBar];
//    [tabBar setFrame:CGRectMake(0, rectWindow.size.height - fTabBarHeight, 320, fTabBarHeight)];
//    if ([tabBar respondsToSelector:@selector(setBackgroundImage:)]) { // ios 5 code here
//        [tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bar_bg_320x54"]];
//    } else { // ios 4 code here
//        CGRect frame = CGRectMake(0, 0, 320, 54);
//        UIView *tabbg_view = [[UIView alloc] initWithFrame:frame] ;
//        UIImage *tabbag_image = [UIImage imageNamed:@"tab_bar_bg_320x54"];
//        UIColor *tabbg_color = [[UIColor alloc] initWithPatternImage:tabbag_image];
//        tabbg_view.backgroundColor = tabbg_color;
//        [tabBar insertSubview:tabbg_view atIndex:0];
//    }
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:rainbowViewController];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:koreaGuideViewController];
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:koreanMovieViewController];
    UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:helpCenterViewController];
    UINavigationController *navi5 = [[UINavigationController alloc] initWithRootViewController:koreaStoryViewcontroller];
    navi1.delegate = self;
    navi2.delegate = self;
    navi3.delegate = self;
    navi4.delegate = self;
    navi5.delegate = self;

    CustomTabBarItem *tabBarItem1 = [[CustomTabBarItem alloc] init];
    CustomTabBarItem *tabBarItem2 = [[CustomTabBarItem alloc] init] ;
    CustomTabBarItem *tabBarItem3 = [[CustomTabBarItem alloc] init] ;
    CustomTabBarItem *tabBarItem4 = [[CustomTabBarItem alloc] init] ;
    CustomTabBarItem *tabBarItem5 = [[CustomTabBarItem alloc] init] ;

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        tabBarItem1.customStdImage = [[UIImage imageNamed:@"bot_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem1.customHighlightedImage = [[UIImage imageNamed:@"bot_01_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem2.customStdImage = [[UIImage imageNamed:@"bot_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem2.customHighlightedImage = [[UIImage imageNamed:@"bot_02_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem3.customStdImage = [[UIImage imageNamed:@"bot_03"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem3.customHighlightedImage = [[UIImage imageNamed:@"bot_03_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem4.customStdImage = [[UIImage imageNamed:@"bot_04"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem4.customHighlightedImage = [[UIImage imageNamed:@"bot_04_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarItem5.customStdImage = [[UIImage imageNamed:@"bot_05"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem5.customHighlightedImage = [[UIImage imageNamed:@"bot_05_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }else{
        tabBarItem1.customStdImage = [UIImage imageNamed:@"bot_01"];
        tabBarItem1.customHighlightedImage = [UIImage imageNamed:@"bot_01_on"];
        
        tabBarItem2.customStdImage = [UIImage imageNamed:@"bot_02"];
        tabBarItem2.customHighlightedImage = [UIImage imageNamed:@"bot_02_on"];
        
        tabBarItem3.customStdImage = [UIImage imageNamed:@"bot_03"];
        tabBarItem3.customHighlightedImage = [UIImage imageNamed:@"bot_03_on"];
        
        tabBarItem4.customStdImage = [UIImage imageNamed:@"bot_04"];
        tabBarItem4.customHighlightedImage = [UIImage imageNamed:@"bot_04_on"];
        
        tabBarItem5.customStdImage = [UIImage imageNamed:@"bot_05"];
        tabBarItem5.customHighlightedImage = [UIImage imageNamed:@"bot_05_on"];
    }
    

    
    [navi1 setTabBarItem:tabBarItem1];
    [navi2 setTabBarItem:tabBarItem2];
    [navi3 setTabBarItem:tabBarItem3];
    [navi4 setTabBarItem:tabBarItem4];
    [navi5 setTabBarItem:tabBarItem5];
    
    tabbarController.viewControllers = [NSArray arrayWithObjects:navi1, navi2, navi3, navi4, navi5, nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.window setRootViewController:tabbarController];
    tabbarController.delegate = self;
    [tabbarController.view setBackgroundColor:[UIColor whiteColor]];
    
    _arrState=[[NSArray alloc]initWithObjects:@"한국어",@"English",@"中国语",@"tiếng Việt",@"Tagalog",@"Khmer",@"Mongolian",@"русский",@"日本語",@"ภาษาไทย",@"ລາວ",@"नेपाली",@"O‘zbekiston", nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self sendHitsInBackground];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - navigationController delegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        UIColor *color = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
        
        [[navigationController navigationBar] setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
        
        viewController.navigationItem.leftBarButtonItem.tintColor = color;
    }
    
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"back_p"] forState:UIControlStateHighlighted];
    [tempBtn addTarget:viewController.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    
    NSArray *viewControllers = [navigationController viewControllers];
    
    if ([viewControllers count] > 1 && ![viewController.navigationItem hidesBackButton]) {
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:tempBtn];
        viewController.navigationItem.leftBarButtonItem = leftButton;
    }
    
    viewController.navigationItem.backBarButtonItem = backButtonItem;
    [viewController.navigationItem setHidesBackButton:YES];


}



@end
