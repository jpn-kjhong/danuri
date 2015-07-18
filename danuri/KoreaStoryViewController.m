//
//  KoreaStoryViewController.m
//  danuri
//
//  Created by dmlab on 2014. 8. 12..
//  Copyright (c) 2014년 Kjhong. All rights reserved.
//

#import "KoreaStoryViewController.h"
#import "SelectLangaugeViewController.h"
#import "JSON.h"
#import "AppDelegate.h"

@interface KoreaStoryViewController ()

@end

@implementation KoreaStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageChanged)
                                                     name:LanguageChanged object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(javascriptCall:)
                                                     name:JavascriptCall object:nil];
        
    }
    return self;
}

- (void)javascriptCall:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    NSString *movie = [notification.userInfo objectForKey:@"video"];
    NSURL *movieURL = [NSURL URLWithString:movie];
    MPMoviePlayerViewController *playerView = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    MPMoviePlayerController* moviePlayer = [playerView moviePlayer];
    [moviePlayer setControlStyle:MPMovieControlStyleDefault];

    playerView.view.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinish:)                         name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    
    [self presentMoviePlayerViewControllerAnimated:playerView];
    
}

-(void) playbackDidFinish:(NSNotification*)aNotification
{
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [player stop];
    [self dismissMoviePlayerViewControllerAnimated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"한국스토리"];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
        path = @"http://liveinkorea.kr/player/mobile/mobile_kr.asp";
    }else if([appDelegate.type isEqualToString:@"en"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_en.asp";
    }else if([appDelegate.type isEqualToString:@"cn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_cn.asp";
    }else if([appDelegate.type isEqualToString:@"vn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_vn.asp";
    }else if([appDelegate.type isEqualToString:@"ph"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ph.asp";
    }else if([appDelegate.type isEqualToString:@"kh"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_kh.asp";
    }else if([appDelegate.type isEqualToString:@"mn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_mn.asp";
    }else if([appDelegate.type isEqualToString:@"ru"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ru.asp";
    }else if([appDelegate.type isEqualToString:@"jp"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_jp.asp";
    }else if([appDelegate.type isEqualToString:@"th"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_th.asp";
    }else if([appDelegate.type isEqualToString:@"la"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_la.asp";
    }else if([appDelegate.type isEqualToString:@"ne"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ne.asp";
    }else if([appDelegate.type isEqualToString:@"uz"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_uz.asp";
    }else{
        path = @"http://liveinkorea.kr/player/mobile/mobile_kr.asp";
    }
    
    NSURL *myURL = [NSURL URLWithString:path];
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
	[webview loadRequest:myURLReq];
}

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path;
    if([appDelegate.type isEqualToString:@"kr"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_kr.asp";
    }else if([appDelegate.type isEqualToString:@"en"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_en.asp";
    }else if([appDelegate.type isEqualToString:@"cn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_cn.asp";
    }else if([appDelegate.type isEqualToString:@"vn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_vn.asp";
    }else if([appDelegate.type isEqualToString:@"ph"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ph.asp";
    }else if([appDelegate.type isEqualToString:@"kh"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_kh.asp";
    }else if([appDelegate.type isEqualToString:@"mn"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_mn.asp";
    }else if([appDelegate.type isEqualToString:@"ru"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ru.asp";
    }else if([appDelegate.type isEqualToString:@"jp"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_jp.asp";
    }else if([appDelegate.type isEqualToString:@"th"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_th.asp";
    }else if([appDelegate.type isEqualToString:@"la"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_la.asp";
    }else if([appDelegate.type isEqualToString:@"ne"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_ne.asp";
    }else if([appDelegate.type isEqualToString:@"uz"]){
        path = @"http://liveinkorea.kr/player/mobile/mobile_uz.asp";
    }else{
        path = @"http://liveinkorea.kr/player/mobile/mobile_kr.asp";
    }
    
    NSURL *myURL = [NSURL URLWithString:path];
	NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
	[webview loadRequest:myURLReq];
    /*
     http://liveinkorea.kr/player/mobile/mobile_ph.asp -> 필리핀
     http://liveinkorea.kr/player/mobile/mobile_jp.asp -> 일본
     http://liveinkorea.kr/player/mobile/mobile_th.asp -> 대만
     http://liveinkorea.kr/player/mobile/mobile_vn.asp - 베트남
     http://liveinkorea.kr/player/mobile/mobile_mn.asp -> 몽골
     http://liveinkorea.kr/player/mobile/mobile_ru.asp -> 러시아
     http://liveinkorea.kr/player/mobile/mobile_kr.asp -> 국문
     http://liveinkorea.kr/player/mobile/mobile_en.asp - 영문
     http://liveinkorea.kr/player/mobile/mobile_cn.asp -> 중문
     http://liveinkorea.kr/player/mobile/mobile_kh.asp -> 캄보디아
     */
    
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

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [ai startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [ai stopAnimating];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [ai stopAnimating];

}

@end
