//
//  KoreaGuideViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "KoreaGuideViewController.h"
#import "SelectLangaugeViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "ModalWebViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#define Height_UITabBar                         54
#define Height_UINavigationBar                  44
#define Height_StatusBar                        20
#define fHeight_ScrollViewBottomGap     12.0

#define ImgAddr_Entertain_pagecontrol_on                                    @"pagecontrol_on_6x6"
#define ImgAddr_Entertain_pagecontrol_off                                   @"pagecontrol_off_6x6"

#define fViewWidth              238.0
#define fViewHeight             335.0

@interface KoreaGuideViewController ()
{
    ASINetworkQueue *networkQueue;
    
}
@end

@implementation KoreaGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(backToIntro) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	[networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
	[networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
	[networkQueue setShowAccurateProgress:YES];
	[networkQueue setDelegate:self];
    
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *param  = @{@"language": appDelegate.type};
    _posts = [NSMutableArray array];
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [Post globalTimelinePostsWithParameter:param withPath:@"include/json/guidebook_json.asp" Block:^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"%@",posts);
            
            _posts = posts;
            [self setThumbnail];
            //            [self.tableView reloadData];
        }
        
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        //        [_activityIndicatorView stopAnimating];
        //        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}


- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
    NSLog(@"%@", request);
    NSArray *comp = [[NSArray alloc] initWithArray:[request.url pathComponents]];
    NSString *file = [comp objectAtIndex:[comp count]-1];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *uniquePath = [documentsDirectory stringByAppendingPathComponent: file];
    NSURL *fileURL = [NSURL fileURLWithPath:uniquePath];
    
    UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    controller.delegate = self;
    controller.UTI = @"com.adobe.pdf";
    //CGRect rect = CGRectMake(0, 0, 300, 300);
    [controller presentPreviewAnimated:YES];
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download pdf" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller willBeginSendingToApplication: (NSString *) application {
}

- (void) documentInteractionController: (UIDocumentInteractionController *) controller didEndSendingToApplication: (NSString *) application {
    
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
}

-(UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
	
	return self;
}


- (void) backToIntro{
    SelectLangaugeViewController *sel = [[SelectLangaugeViewController alloc] initWithNibName:@"SelectLangaugeViewController" bundle:nil];
    [self.navigationController presentViewController:sel animated:NO completion:^{
        
        
    }
     ];
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
        viewEntertainment.imageType =@"gb_app_image";
        viewEntertainment.linkType =@"gb_pdf_link";
        [viewEntertainment setDelegate:self];
        [viewEntertainment setEntertainViewType:EntertainViewType_Normal];
        [viewEntertainment setDataFromDictionary:dictEntData];
        
        [arrayEntertainment addObject:viewEntertainment];
    }
    [self refreshView];
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
    
    [scrollView setFrame:CGRectMake((sizeWindow.width - fViewWidth)/2.0, 20.0, fViewWidth, fHeightScrollView)];
    [scrollView setContentSize:CGSizeMake(nPageCount * fViewWidth + fSideGap, fHeightScrollView)];
    
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[EntertainView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat fCardYPoint = 9.0; // Default
    
    if (sizeWindow.height > 480.0) {
        fCardYPoint = 50.0;
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
}

#pragma mark - UIPageControl Action

-(void)pageControlValueChanged:(id)sender {

    [scrollView setContentOffset:CGPointMake(pageControl.currentPage * fViewWidth, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    CGFloat fPageWidth = _scrollView.frame.size.width;
    pageControl.currentPage = floor((_scrollView.contentOffset.x - fPageWidth / 3.0) / fPageWidth) + 1;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didEntertainViewClicked:(EntertainView*)entertainView
{
    ASIHTTPRequest *request;
    NSURL *url = [NSURL URLWithString:[entertainView getTargetURL]];
    
	request = [ASIHTTPRequest requestWithURL:url];
    
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
        [request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:file]];
        [request setDownloadProgressDelegate:entertainView.progress];
        [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];
        [networkQueue addOperation:request];
        [entertainView.progress setHidden:NO];
        [networkQueue go];
    }
}

@end
