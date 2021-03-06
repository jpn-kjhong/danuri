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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageChanged)
                                                     name:LanguageChanged object:nil];
        
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
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    // Do any additional setup after loading the view from its nib.
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;

    float padding = 0;
    if(IS_IPHONE5){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y  + padding, titleButton.frame.size.width, titleButton.frame.size.height)];
        }
        else{
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y  , titleButton.frame.size.width, titleButton.frame.size.height)];
        }
    }else{
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y - 16 + padding, titleButton.frame.size.width, titleButton.frame.size.height)];
        }
        else{
            [titleButton setFrame:CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y - 16 , titleButton.frame.size.width, titleButton.frame.size.height)];
        }
    }
    
    
    pktStatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 43 , 320, 480)];
    pktStatePicker.delegate = self;
    pktStatePicker.dataSource = self;
    [pktStatePicker  setShowsSelectionIndicator:YES];
    
    // Create done button in UIPickerView
    mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    [mypickerToolbar setItems:barItems animated:YES];
    
}

-(int) getLaguageIndex
{
    int value = 0;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDelegate.type isEqualToString:@"kr"]){
        value = 0;
    }else if([appDelegate.type isEqualToString:@"en"]){
        value = 1;
    }else if([appDelegate.type isEqualToString:@"cn"]){
        value = 2;
    }else if([appDelegate.type isEqualToString:@"vn"]){
        value = 3;
    }else if([appDelegate.type isEqualToString:@"ph"]){
        value = 4;
    }else if([appDelegate.type isEqualToString:@"kh"]){
        value = 5;
    }else if([appDelegate.type isEqualToString:@"mn"]){
        value = 6;
    }else if([appDelegate.type isEqualToString:@"ru"]){
        value = 7;
    }else if([appDelegate.type isEqualToString:@"jp"]){
        value = 8;
    }else if([appDelegate.type isEqualToString:@"th"]){
        value = 9;
    }else if([appDelegate.type isEqualToString:@"la"]){
        value = 10;
    }else if([appDelegate.type isEqualToString:@"ne"]){
        value = 11;
    }else if([appDelegate.type isEqualToString:@"uz"]){
        value = 12;
    }else {
        value = 0;
    }
    return value;
}

-(void) setPickInitValue
{
    //    [pktStatePicker selectRow:[self getLaguageIndex] inComponent:0 animated:YES];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int i = 0 ;
    for(i = 0; i < [appDelegate.arrState count];i++){
        [sheet addButtonWithTitle:[appDelegate.arrState objectAtIndex:i]];
    }
    
}
-(void)addPickerView
{
    sheet = [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"Done"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil];
    [self setPickInitValue];
    //    [sheet addSubview:pktStatePicker];
    //    [sheet showInView:self.view.superview];
    //    [sheet addSubview:mypickerToolbar];
    //    [sheet showInView:self.view.superview];
    //    [sheet setBounds:CGRectMake(0, 20, 320, 430)];
    [sheet showInView:self.view];
    //    [self setPickInitValue];
    
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"You selected this: %d", buttonIndex);
    switch (buttonIndex-1) {
        case 0:
            appDelegate.type = @"kr";
            break;
        case 1:
            appDelegate.type = @"en";
            break;
        case 2:
            appDelegate.type = @"cn";
            break;
        case 3:
            appDelegate.type = @"vn";
            break;
        case 4:
            appDelegate.type = @"ph";
            break;
        case 5:
            appDelegate.type = @"kh";
            break;
        case 6:
            appDelegate.type = @"mn";
            break;
        case 7:
            appDelegate.type = @"ru";
            break;
        case 8:
            appDelegate.type = @"jp";
            break;
        case 9:
            appDelegate.type = @"th";
            break;
        case 10:
            appDelegate.type = @"la";
            break;
        case 11:
            appDelegate.type = @"ne";
            break;
        case 12:
            appDelegate.type = @"uz";
            break;
        default:
            appDelegate.type = @"kr";
            break;
    }
    [self selectLanguage];
}


- (void) selectLanguage{
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChanged object:nil];

}

- (void) languageChanged
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
    }else if([appDelegate.type isEqualToString:@"la"]){
        path = @"/la_mn.json";
    }else if([appDelegate.type isEqualToString:@"ne"]){
        path = @"/ne_mn.json";
    }else if([appDelegate.type isEqualToString:@"uz"]){
        path = @"/uz_mn.json";
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
    }else if([appDelegate.type isEqualToString:@"la"]){
        path = @"/la_mn.json";
    }else if([appDelegate.type isEqualToString:@"ne"]){
        path = @"/ne_mn.json";
    }else if([appDelegate.type isEqualToString:@"uz"]){
        path = @"/uz_mn.json";
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
                [self callWithOpenURL:@"1577-1366"];
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
