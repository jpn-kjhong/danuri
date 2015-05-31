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
    [tracker set:kGAIScreenName value:@"다문화 지원센터"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
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

    float padding = 0;
    if(IS_IPHONE5){
//        padding = 80;
    }else{
//        padding = 55;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        [familyButton setFrame:CGRectMake(familyButton.frame.origin.x, familyButton.frame.origin.y + padding, familyButton.frame.size.width, familyButton.frame.size.height)];
        
        [familyImage setFrame:CGRectMake(familyImage.frame.origin.x, familyImage.frame.origin.y  + padding, familyImage.frame.size.width, familyImage.frame.size.height)];

        [titleLabel setFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + padding, titleLabel.frame.size.width, titleLabel.frame.size.height)];

        [homeButton setFrame:CGRectMake(homeButton.frame.origin.x, homeButton.frame.origin.y + padding, homeButton.frame.size.width, homeButton.frame.size.height)];

        [homeImage setFrame:CGRectMake(homeImage.frame.origin.x, homeImage.frame.origin.y  + padding, homeImage.frame.size.width, homeImage.frame.size.height)];
        
        [homeLabel setFrame:CGRectMake(homeLabel.frame.origin.x, homeLabel.frame.origin.y +  padding, homeLabel.frame.size.width, homeLabel.frame.size.height)];
        
    }
    else{

    }
    
    NSLog(@"%f %f  %f %f",familyButton.frame.origin.y, familyButton.frame.size.height, homeButton.frame.origin.y,homeButton.frame.size.height);
    
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
    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"text1"];
    
    [titleLabel setText:title];
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
    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"text1"];
    
    [titleLabel setText:title];
    
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
    if([sender tag]== 0){
        SupportViewController *sup = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
        [self.navigationController pushViewController:sup animated:YES];
    }else if([sender tag] == 1)
    {
        NSURL *url = [NSURL URLWithString:@"http://liveinkorea.kr/"];
        [[UIApplication sharedApplication] openURL:url];
    }

    
}

- (IBAction)consultClick:(id)sender {
    ConsultViewController *consult = [[ConsultViewController alloc] initWithNibName:@"ConsultViewController" bundle:nil];
    [self.navigationController pushViewController:consult animated:YES];
}

@end
