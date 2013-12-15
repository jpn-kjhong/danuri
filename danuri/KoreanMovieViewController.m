//
//  KoreanMovieViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
///Users/hongkijoo/danuri_github/danuri.xcodeproj

#import "KoreanMovieViewController.h"
#import "ConsultViewController.h"
#import "SelectLangaugeViewController.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "SupportViewController.h"
#import "JSON.h"
#import "AppDelegate.h"

@interface KoreanMovieViewController ()

@end

@implementation KoreanMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:2];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"다문화 지원센터"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(backToIntro) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view from its nib.
//    
//    NSString *myJsonPath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:@"/kr_mn.json"];
//    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:myJsonPath encoding:NSUTF8StringEncoding error:NULL];
//    if (!myJSON) {
//        NSLog(@"File couldn't be read!");
//        return;
//    }
//    NSDictionary *jsonData = [myJSON JSONValue];
//    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"text1"];

}

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path;
    if([appDelegate.type isEqualToString:@"kr"]){
        path = @"/kr_mn.json";
    }else if([appDelegate.type isEqualToString:@"en"]){
        path = @"/en_mn.json";
    }else if([appDelegate.type isEqualToString:@"cn"]){
        path = @"/cn_mn.json";
    }else if([appDelegate.type isEqualToString:@"vn"]){
        path = @"/vn_mn.json";
    }else if([appDelegate.type isEqualToString:@"ph"]){
        path = @"/ph_mn.json";
    }else if([appDelegate.type isEqualToString:@"kh"]){
        path = @"/kh_mn.json";
    }else if([appDelegate.type isEqualToString:@"mn"]){
        path = @"/mn_mn.json";
    }else if([appDelegate.type isEqualToString:@"ru"]){
        path = @"/ru_mn.json";
    }else if([appDelegate.type isEqualToString:@"jp"]){
        path = @"/jp_mn.json";
    }else if([appDelegate.type isEqualToString:@"th"]){
        path = @"/th_mn.json";
    }else {
        path = @"/kr_mn.json";
    }
    
    NSString *myJsonPath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:path];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:myJsonPath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return;
    }
    NSDictionary *jsonData = [myJSON JSONValue];
    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"text1"];
    
    [titleLabel setText:title];
    [familyImage setFrame:CGRectMake(familyImage.frame.origin.x, familyButton.frame.origin.y  + 25, familyImage.frame.size.width, familyImage.frame.size.height)];
    
    [titleLabel setFrame:CGRectMake(titleLabel.frame.origin.x, familyImage.frame.origin.y + familyImage.frame.size.height + 5, titleLabel.frame.size.width, titleLabel.frame.size.height)];
    
}
- (void) backToIntro{
    SelectLangaugeViewController *sel = [[SelectLangaugeViewController alloc] initWithNibName:@"SelectLangaugeViewController" bundle:nil];
    [self.navigationController presentViewController:sel animated:NO completion:^{
        
        
    }
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callClick:(id)sender {
    SupportViewController *sup = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
    [self.navigationController pushViewController:sup animated:YES];

    
}

- (IBAction)consultClick:(id)sender {
    ConsultViewController *consult = [[ConsultViewController alloc] initWithNibName:@"ConsultViewController" bundle:nil];
    [self.navigationController pushViewController:consult animated:YES];
}

@end
