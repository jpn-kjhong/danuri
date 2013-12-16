//
//  HelpCenterViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "SelectLangaugeViewController.h"
#import "SupportViewController.h"
#import "EmergencyViewController.h"
#import "AppDelegate.h"
#import "JSON.h"
@interface HelpCenterViewController ()

@end

@implementation HelpCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:3];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"도움받는 곳"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    // Do any additional setup after loading the view from its nib.
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(backToIntro) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;

    if(IS_IPHONE5){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y + 54, titleButton.frame.size.width, titleButton.frame.size.height)];
        }
        else{
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y , titleButton.frame.size.width, titleButton.frame.size.height)];
        }
    }else{
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y + 54, titleButton.frame.size.width, titleButton.frame.size.height)];
        }
        else{
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y , titleButton.frame.size.width, titleButton.frame.size.height)];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
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
    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"title"];
    
    [titleButton setTitle:title forState:UIControlStateNormal];

    NSString *call = [[jsonData objectForKey:@"call"] objectForKey:@"title"];
    [callTitle setText:call];
    
    NSString *des = [[jsonData objectForKey:@"call"] objectForKey:@"subtitle"];
    [callDes setText:des];
    
    NSString *phone = [[jsonData objectForKey:@"call"] objectForKey:@"phone"];
    [callNumber setText:phone];
    
    NSString *emer = [[jsonData objectForKey:@"help"] objectForKey:@"text2"];
    [emerTitleLabel setText:emer];
    
    [callButton setFrame:CGRectMake(callButton.frame.origin.x, titleButton.frame.origin.y + titleButton.frame.size.height + 5, callButton.frame.size.width, callButton.frame.size.height)];
    
    [callImage setFrame:CGRectMake(callImage.frame.origin.x, callButton.frame.origin.y + 15, callImage.frame.size.width, callImage.frame.size.height)];
    
    [callTitle setFrame:CGRectMake(callTitle.frame.origin.x, callImage.frame.origin.y + 5 + callImage.frame.size.height , callTitle.frame.size.width, callTitle.frame.size.height)];
    
    [callDes setFrame:CGRectMake(callDes.frame.origin.x, callTitle.frame.origin.y + callTitle.frame.size.height , callDes.frame.size.width, callDes.frame.size.height)];
    
    [callNumber setFrame:CGRectMake(callNumber.frame.origin.x, callDes.frame.origin.y + callDes.frame.size.height , callNumber.frame.size.width, callNumber.frame.size.height)];
    
    //
    [emerButton setFrame:CGRectMake(emerButton.frame.origin.x, callButton.frame.origin.y + callButton.frame.size.height , emerButton.frame.size.width, emerButton.frame.size.height)];
    
    [emerImage setFrame:CGRectMake(emerImage.frame.origin.x, emerButton.frame.origin.y + 15, emerImage.frame.size.width, emerImage.frame.size.height)];
    
    [emerTitleLabel setFrame:CGRectMake(emerTitleLabel.frame.origin.x, emerImage.frame.origin.y + emerImage.frame.size.height + 5, emerTitleLabel.frame.size.width, emerTitleLabel.frame.size.height)];
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
- (IBAction)buttonClicked:(UIButton *)sender {
//    SupportViewController *sup = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
    EmergencyViewController *emergency = [[EmergencyViewController alloc] initWithNibName:@"EmergencyViewController" bundle:nil];

    switch ([sender tag]) {
        case 0://콜 센터
            [self callCenter];
            break;
        case 1://긴급연락처
            [self.navigationController pushViewController:emergency animated:YES];
            break;
        default:
            break;
    }
}

- (void)callCenter
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"통화연결"                                                        message:@"통화하시겠습니까?"
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"통화", nil];
    [alertView setTag:0];
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
    NSLog(@"%d %d",alertView.tag,buttonIndex);
    
    
    switch (alertView.tag) {
        case 0:
        {
            if(buttonIndex == 1) {
                [self callWithOpenURL:@"1577-5432"];
            }else if(buttonIndex == 2){

            }
        }
            break;
    }
}

- (void) callWithOpenURL:(NSString *)phoneNumber {
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
