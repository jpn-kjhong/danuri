//
//  RainbowViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "RainbowViewController.h"
#import "SelectLangaugeViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "ModalWebViewController.h"
#import "Toast+UIView.h"
#import "CityTableViewController.h"
#import "FPPopoverController.h"
#import "JSON.h"
#import "UIKit+AFNetworking.h"
#import "UIViewController+MJPopupViewController.h"
#import "NoticeViewController.h"

#define Height_UITabBar                         54
#define Height_UINavigationBar                  44
#define Height_StatusBar                        20
#define fHeight_ScrollViewBottomGap     12.0

#define ImgAddr_Entertain_pagecontrol_on                                    @"pagecontrol_on_6x6"
#define ImgAddr_Entertain_pagecontrol_off                                   @"pagecontrol_off_6x6"

#define fViewWidth              238.0
#define fViewHeight             335.0

@interface RainbowViewController ()
{
    NSOperationQueue *operationQueue;
}
@end

@implementation RainbowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(successCertification)
                                                     name:SuccessCertification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(languageChanged)
                                                     name:LanguageChanged object:nil];
        requestList = [[NSMutableArray alloc] init];
        TaskList = [[NSMutableArray alloc] init];

        operationQueue = [[NSOperationQueue alloc] init];
        NSLog(@"Version %i", __IPHONE_OS_VERSION_MIN_REQUIRED);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"레인보우 +"];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    
    firstConnect = YES;
    SelectLangaugeViewController *sel = [[SelectLangaugeViewController alloc] initWithNibName:@"SelectLangaugeViewController" bundle:nil];
    [self.navigationController presentViewController:sel animated:NO completion:^{
    }
     ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:@"http://www.liveinkorea.kr/include/json/appimage_json.asp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *temp = responseObject;
        for(int i = 0;i < [temp count];i++){
            NSDictionary *dictEntData = [temp objectAtIndex:i];
            if([[dictEntData objectForKey:@"img_type"] isEqualToString:@"web"])
            {
                NSString *path = [dictEntData objectForKey:@"weburl"];
                NoticeViewController *detailViewController = [[NoticeViewController alloc] initWithNibName:@"NoticeViewController" bundle:nil path:path];
                [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationSlideTopTop];
//                [self.navigationController presentViewController:detailViewController animated:YES completion:^{
//                }
//                 ];
            }
            break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    
    }];
    
//    http://www.liveinkorea.kr/include/json/appimage_json.asp
    
    
    // Do any additional setup after loading the view from its nib.
    
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //    pktStatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 43 , 320, 480)];
    //    pktStatePicker.delegate = self;
    //    pktStatePicker.dataSource = self;
    //    [pktStatePicker  setShowsSelectionIndicator:YES];
    
    // Create done button in UIPickerView
    mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    //    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    //    [barItems addObject:doneBtn];
    //    [mypickerToolbar setItems:barItems animated:YES];
    
    if(IS_IPHONE5){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [yearButton setFrame:CGRectMake(yearButton.frame.origin.x, yearButton.frame.origin.y, yearButton.frame.size.width, yearButton.frame.size.height)];
        }else{
            [yearButton setFrame:CGRectMake(yearButton.frame.origin.x, yearButton.frame.origin.y, yearButton.frame.size.width, yearButton.frame.size.height)];
        }
    }else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            [yearButton setFrame:CGRectMake(yearButton.frame.origin.x, yearButton.frame.origin.y - 16, yearButton.frame.size.width, yearButton.frame.size.height)];
        }else{
            [yearButton setFrame:CGRectMake(yearButton.frame.origin.x, yearButton.frame.origin.y - 16, yearButton.frame.size.width, yearButton.frame.size.height)];
        }
    }
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
    
    NSLog(@"You selected this: %", buttonIndex);
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


//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    return [appDelegate.arrState count];
//}
//
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    return [appDelegate.arrState objectAtIndex:row];
//}
//
//
//- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"You selected this: %@", [appDelegate.arrState objectAtIndex: row]);
//    switch (row) {
//        case 0:
//            appDelegate.type = @"kr";
//            break;
//        case 1:
//            appDelegate.type = @"en";
//            break;
//        case 2:
//            appDelegate.type = @"cn";
//            break;
//        case 3:
//            appDelegate.type = @"vn";
//            break;
//        case 4:
//            appDelegate.type = @"ph";
//            break;
//        case 5:
//            appDelegate.type = @"kh";
//            break;
//        case 6:
//            appDelegate.type = @"mn";
//            break;
//        case 7:
//            appDelegate.type = @"ru";
//            break;
//        case 8:
//            appDelegate.type = @"jp";
//            break;
//        case 9:
//            appDelegate.type = @"th";
//            break;
//        default:
//            appDelegate.type = @"kr";
//            break;
//    }
//    [self selectLanguage];
//
//
//}
//
//
//- (void)pickerDoneClicked
//{
//    NSLog(@"Done Clicked");
//    [sheet dismissWithClickedButtonIndex:0 animated:YES];
//    [self selectLanguage];
//}


- (void) selectLanguage{
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChanged object:nil];
}

- (void) backToIntro{
    SelectLangaugeViewController *sel = [[SelectLangaugeViewController alloc] initWithNibName:@"SelectLangaugeViewController" bundle:nil];
    [self.navigationController presentViewController:sel animated:NO completion:^{
        
        
    }
     ];
}

//- (void)imageFetchComplete:(ASIHTTPRequest *)request
//{
//    NSLog(@"imageFetchComplete : %@", request);
//    for(EntertainView *temp in requestList)
//    {
//        if([[[request url] absoluteString] isEqualToString:[temp getTargetURL]]){
//            [temp.progress setHidden:YES];
//            [temp.close setHidden:YES];
//            [requestList removeObject:temp];
//            break;
//        }
//    }
//
//    NSArray *comp = [[NSArray alloc] initWithArray:[request.url pathComponents]];
//    NSString *file = [comp objectAtIndex:[comp count]-1];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *uniquePath = [documentsDirectory stringByAppendingPathComponent: file];
//    NSURL *fileURL = [NSURL fileURLWithPath:uniquePath];
//    [self addSkipBackupAttributeToItemAtURL:fileURL];
//    UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
//    controller.delegate = self;
//    controller.UTI = @"com.adobe.pdf";
//    //CGRect rect = CGRectMake(0, 0, 300, 300);
//    [controller presentPreviewAnimated:YES];
//
//    [self selectLanguage];
//}
//
//- (void)imageFetchFailed:(ASIHTTPRequest *)request
//{
//    for(EntertainView *temp in requestList)
//    {
//        if([[[request url] absoluteString] isEqualToString:[temp getTargetURL]]){
//            [temp.progress setHidden:YES];
//            [temp.close setHidden:YES];
//            [requestList removeObject:temp];
//            break;
//        }
//    }
//
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download pdf" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller willBeginSendingToApplication: (NSString *) application {
}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller didEndSendingToApplication: (NSString *) application {
    
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
}

-(UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return self;
}




- (void) viewWillAppear:(BOOL)animated
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        
        [[self.navigationController navigationBar] setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
}

- (void) languageChanged
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _posts = [NSMutableArray array];
    
    NSDictionary *param  = @{@"language": appDelegate.type};
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //    [Post globalTimelinePostsWithParameter:param withPath:@"include/json/rainbow_json.asp" Block:^(NSArray *posts, NSError *error) {
    //        if (error) {
    //            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
    //        } else {
    //            NSLog(@"%@",posts);
    //
    //            _posts = posts;
    //            [self setThumbnail];
    //        }
    //        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    //
    //
    //    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [manager GET:@"http://www.liveinkorea.kr/include/json/rainbow_json.asp" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"%@",responseObject);
        
        _posts = responseObject;
        [self setThumbnail];
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}

- (void) successCertification
{
    NSLog(@"in");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _posts = [NSMutableArray array];
    NSDictionary *param  = @{@"language": appDelegate.type};
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    [Post globalTimelinePostsWithParameter:param withPath:@"include/json/rainbow_json.asp" Block:^(NSArray *posts, NSError *error) {
//        if (error) {
//            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
//        } else {
//            NSLog(@"%@",posts);
//            
//            _posts = posts;
//            [self setThumbnail];
//        }
//        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//    }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [manager GET:@"http://www.liveinkorea.kr/include/json/rainbow_json.asp" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        _posts = responseObject;
        [self setThumbnail];
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}

-(void) setThumbnail{
    arrayEntertainment = [[NSMutableArray alloc] initWithCapacity:0];
    dictMessageList = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    CGSize sizeWindow = [[UIScreen mainScreen] bounds].size;
    
    CGRect rectSVEntertainments = scrollView.frame;
    CGFloat fHeightSVEntertainments = sizeWindow.height - (Height_StatusBar + Height_UINavigationBar + Height_UITabBar + fHeight_ScrollViewBottomGap);
    
    [scrollView setFrame:CGRectMake(rectSVEntertainments.origin.x, rectSVEntertainments.origin.y, rectSVEntertainments.size.width, fHeightSVEntertainments)];
    
    [pageControl setImageActive:ImgAddr_Entertain_pagecontrol_on InActive:ImgAddr_Entertain_pagecontrol_off];
    
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    
    [pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    for(int i = 0;i < [_posts count];i++){
        NSDictionary *dictEntData = [_posts objectAtIndex:i];
        EntertainView *viewEntertainment = [[EntertainView alloc] initWithFrame:CGRectZero] ;
        viewEntertainment.imageType =@"rb_app_image";
        viewEntertainment.linkType =@"rb_pdf_link";
        
        [viewEntertainment setDelegate:self];
        [viewEntertainment setEntertainViewType:EntertainViewType_Normal];
        [viewEntertainment setDataFromDictionary:dictEntData];
        
        NSURL *url = [NSURL URLWithString:[viewEntertainment getTargetURL]];
        if([self validateUrl:[url absoluteString]]==false){
            [viewEntertainment setIsExist:NO];
        }else{
            NSArray *comp = [[NSArray alloc] initWithArray:[url pathComponents]];
            NSString *file = [comp objectAtIndex:[comp count]-1];
            NSString *filename = file;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *uniquePath = [documentsDirectory stringByAppendingPathComponent: filename];
            // Check for a cached version
            if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
                [viewEntertainment setIsExist:YES];
            else
                [viewEntertainment setIsExist:NO];
        }
        
        
        
        [arrayEntertainment addObject:viewEntertainment];
        
    }
    
    [self refreshView];
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

-(void)addDummyEntertainView {
    EntertainView *viewEntertainment = [[EntertainView alloc] initWithFrame:CGRectZero];
    [viewEntertainment setDummyImage];
    [viewEntertainment setDelegate:self];
    [viewEntertainment setEntertainViewType:EntertainViewType_Dummy];
    
    [arrayEntertainment addObject:viewEntertainment];
}

-(void)refreshView {
    NSInteger nPageCount = [arrayEntertainment count];
    
    CGSize sizeWindow = [[UIScreen mainScreen] bounds].size;
    
    pageControl.numberOfPages = nPageCount;
    
    CGFloat fHeightScrollView = sizeWindow.height - (Height_UITabBar + Height_UINavigationBar + Height_StatusBar + fHeight_ScrollViewBottomGap);
    CGFloat fSideGap = (scrollView.frame.size.width - fViewWidth);
    
    [scrollView setFrame:CGRectMake((sizeWindow.width - fViewWidth)/2.0, 0.0, fViewWidth, fHeightScrollView)];
    [scrollView setContentSize:CGSizeMake(nPageCount * fViewWidth + fSideGap, fHeightScrollView)];
    
    for (UIView *view in scrollView.subviews) {
        
        if ([view isKindOfClass:[EntertainView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat fCardYPoint = 9.0; // Default
    
    if(IS_IPHONE5){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            //            fCardYPoint = 70.0;
        }
        else{
        }
    }else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            //            fCardYPoint = 70.0;
            
        }
        else{
            
        }
    }
    
    for (int i=0; i<[arrayEntertainment count]; i++) {
        EntertainView *view = [arrayEntertainment objectAtIndex:i];
        
        [view setFrame:CGRectMake(i * view.frame.size.width, fCardYPoint, fViewHeight, fViewHeight)];
        //        [view setCenter:CGPointMake(svEntertainments.frame.size.width/2.0 + i * view.frame.size.width, fHeightScrollView/2.0)];
        
        [scrollView addSubview:view];
    }
    
    [scrollView setAlwaysBounceVertical:NO];
    [scrollView setAlwaysBounceHorizontal:YES];
    [scrollView setDirectionalLockEnabled:YES];
    NSString *year = nil;
    @try {
        year = [[_posts objectAtIndex:pageControl.currentPage] objectForKey:@"rb_year"];
        //        [self.view makeToast:year];
        [yearButton setTitle:year forState:UIControlStateNormal];
        
    }
    @catch (NSException *exception) {
        return;
    }
    @finally {
        return;
    }
}

#pragma mark - UIPageControl Action

-(void)pageControlValueChanged:(id)sender {
    //    [scrollView setContentOffset:CGPointMake(pageControl.currentPage * fViewWidth, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    CGFloat fPageWidth = _scrollView.frame.size.width;
    pageControl.currentPage = floor((_scrollView.contentOffset.x - fPageWidth / 3.0) / fPageWidth) + 1;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    NSLog(@"%d", pageControl.currentPage);
    NSString *year = nil;
    @try {
        year = [[_posts objectAtIndex:pageControl.currentPage] objectForKey:@"rb_year"];
        //        [self.view makeToast:year];
        [yearButton setTitle:year forState:UIControlStateNormal];
        
    }
    @catch (NSException *exception) {
        return;
    }
    @finally {
        return;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didCloseClicked:(EntertainView*)entertainView
{
    int i= 0;
    for(i = 0 ; i< [requestList count]; i++)
//    for(EntertainView *temp in requestList)
    {
        if([[entertainView getTargetURL]  isEqualToString:[[requestList objectAtIndex:i] getTargetURL]]){
//            [operationQueue cancelAllOperations];
            [[TaskList objectAtIndex:i] cancel];
            [self setThumbnail];
            break;
        }
    }
    
}


-(void)didEntertainViewClicked:(EntertainView*)entertainView
{
    currentItem = entertainView;
    
    NSURL *url = [NSURL URLWithString:[currentItem getTargetURL]];
    if([self validateUrl:[url absoluteString]]==false){
        [self.view makeToast:@"Invalid URI: The format of the URI could not be determined."
                    duration:2.0f
                    position:@"top"
                       title:nil];
        return;
    }
    NSArray *comp = [[NSArray alloc] initWithArray:[url pathComponents]];
    NSString *file = [comp objectAtIndex:[comp count]-1];
    NSString *filename = file;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *uniquePath = [documentsDirectory stringByAppendingPathComponent: filename];
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        NSLog(@"file  exist");
        NSURL *fileURL = [NSURL fileURLWithPath:uniquePath];
        UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        controller.delegate = self;
        controller.UTI = @"com.adobe.pdf";
        [controller presentPreviewAnimated:YES];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"다운로드"                                                        message:@"다운받으시겠습니까?"
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"확인", nil];
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
                [self prepareForDownload];
            }else if(buttonIndex == 2){
                
            }
        }
            break;
    }
}

- (void) prepareForDownload {
    NSString *actionContent = [NSString stringWithFormat:@"%@ : %@ ",@"레인보우 +", [currentItem getTargetURL]];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"레인보우 +"     // Event category (required)
                                                          action:@"버튼클릭"  // Event action (required)
                                                           label:actionContent          // Event label
                                                           value:nil] build]];    // Event value
    
//    ASIHTTPRequest *request;
    NSURL *url = [NSURL URLWithString:[currentItem getTargetURL]];
    
//    request = [ASIHTTPRequest requestWithURL:url];
    
    NSArray *comp = [[NSArray alloc] initWithArray:[url pathComponents]];
    NSString *file = [comp objectAtIndex:[comp count]-1];
    NSString *filename = file;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *uniquePath = [documentsDirectory stringByAppendingPathComponent: filename];
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        NSLog(@"file  exist");
        NSURL *fileURL = [NSURL fileURLWithPath:uniquePath];
        
        UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        controller.delegate = self;
        controller.UTI = @"com.adobe.pdf";
        [controller presentPreviewAnimated:YES];
    }
    else
    {
        NSLog(@"file not exist - so get a new one");
        NSProgress *p;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *URL = [NSURL URLWithString:[currentItem getTargetURL]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&p destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSURL *pathURL= [NSURL fileURLWithPath:documentPath];
            
            NSLog(@"%@",documentPath);
            
            if([[[UIDevice currentDevice] systemVersion] floatValue] > 5.0f){
                [self addSkipBackupAttributeToItemAtUrl:pathURL];
            }else{
                NSLog(@"CANNOT - CUZ VERSION IS UNDER 5.0.1");
            }
            return [NSURL fileURLWithPath:[documentPath stringByAppendingPathComponent:[response suggestedFilename]]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (error) {
                NSLog(@"File error: %@", filePath);
                [self.view makeToast:@"Download failed."
                            duration:2.0f
                            position:@"center"
                               title:nil];
            }else{
            NSLog(@"File downloaded to: %@", filePath);
                [self.view makeToast:@"Download completed."
                            duration:2.0f
                            position:@"center"
                               title:nil];
        
            }
            [self setThumbnail];
        }];
        
        [downloadTask resume];
        [currentItem.progress setProgressWithDownloadProgressOfTask:downloadTask animated:YES];
        
        
        
        [currentItem.progress setHidden:NO];
        [currentItem.close setHidden:NO];
        [requestList addObject:currentItem];
        [TaskList addObject:downloadTask];
    }
}

- (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
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
@end
