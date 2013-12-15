//
//  SupportViewController.m
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "SupportViewController.h"
#import "CityTableViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"
#import "SupportCell.h"
#import "StateTableViewController.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "JSON.h"
@interface SupportViewController ()

@end

@implementation SupportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"지원센터 찾기"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

    // Do any additional setup after loading the view from its nib.
//    NSDictionary *param  = @{@"city": @"gangnamgu"};
//    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    [Post globalTimelinePostsWithParameter:param withPath:@"danuri/mobile/support" Block:^(NSArray *posts, NSError *error) {
//        if (error) {
//            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
//        } else {
//            NSLog(@"%@",posts);
//            
//            _posts = posts;
//            [tableView reloadData];
//        }
//        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//        
//        
//    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path;
    if([appDelegate.type isEqualToString:@"kr"]){
        path = @"/kr.json";
    }else if([appDelegate.type isEqualToString:@"en"]){
        path = @"/en.json";
    }else if([appDelegate.type isEqualToString:@"cn"]){
        path = @"/cn.json";
    }else if([appDelegate.type isEqualToString:@"vn"]){
        path = @"/vn.json";
    }else if([appDelegate.type isEqualToString:@"ph"]){
        path = @"/ph.json";
    }else if([appDelegate.type isEqualToString:@"kh"]){
        path = @"/kh.json";
    }else if([appDelegate.type isEqualToString:@"mn"]){
        path = @"/mn.json";
    }else if([appDelegate.type isEqualToString:@"ru"]){
        path = @"/ru.json";
    }else if([appDelegate.type isEqualToString:@"jp"]){
        path = @"/jp.json";
    }else if([appDelegate.type isEqualToString:@"th"]){
        path = @"/th.json";
    }else {
        path = @"/kr.json";
    }
    
    NSString *myJsonPath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:path];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:myJsonPath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return;
    }
    cityArray = [myJSON JSONValue];
    for (NSDictionary *temp in cityArray) {
        if([[[temp objectForKey:@"attrs"] objectForKey:@"value"] isEqualToString:@"0"]){
            [cityButton setTitle:[[temp objectForKey:@"content"] objectForKey:@"text"] forState:UIControlStateNormal];
            [cityArray removeObject:temp];
            break;
        }
        
    }
//    NSString *title = [[jsonData objectForKey:@"help"] objectForKey:@"title"];
    
}


- (IBAction)clickCityButton:(id)sender {
    [self closePopover];
    CityTableViewController *controller = [[CityTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    controller.cityArray = cityArray;
    cityPopover = [[FPPopoverController alloc] initWithViewController:controller] ;
    cityPopover.tint = FPPopoverDefaultTint;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cityPopover.contentSize = CGSizeMake(300, 400);
    }
    else {
        cityPopover.contentSize = CGSizeMake(200, 250);
    }
    
    //sender is the UIButton view
    cityPopover.arrowDirection = FPPopoverNoArrow;
    [cityPopover presentPopoverFromPoint: CGPointMake(self.view.center.x - 50, stateButton.frame.origin.y + stateButton.frame.size.height + 5)];
    
    [self.view insertSubview:cityPopover.view aboveSubview:stateButton];
    currentCityIndex = 0;
    [stateButton setEnabled:NO];
}

-(void)selectedTableRow:(NSInteger)row rowData:(NSDictionary *)data
{
    [self closePopover];
    NSLog(@"SELECTED ROW %d data %@",row, data);
    currentCityIndex = row;
    [cityButton setTitle:[[data objectForKey:@"content"] objectForKey:@"text"] forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stateButton setEnabled:YES];
    [stateButton setTitle:@"" forState:UIControlStateNormal];
    stateCode =@"";
}

- (IBAction)clickStateClick:(id)sender {
    [self closePopover];
    StateTableViewController *controller = [[StateTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    controller.cityIndex = currentCityIndex;
    statePopover = [[FPPopoverController alloc] initWithViewController:controller] ;
    statePopover.tint = FPPopoverDefaultTint;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        statePopover.contentSize = CGSizeMake(300, 400);
    }
    else {
        statePopover.contentSize = CGSizeMake(200, 250);
    }
    
    //sender is the UIButton view
    statePopover.arrowDirection = FPPopoverNoArrow;
    [statePopover presentPopoverFromPoint: CGPointMake(self.view.center.x + 50, stateButton.frame.origin.y + stateButton.frame.size.height + 5)];
    
    [self.view insertSubview:statePopover.view aboveSubview:stateButton];
    
}

-(void)selectedStateTableRow:(NSInteger)row rowData:(NSDictionary *)data
{
    [self closePopover];
    NSLog(@"SELECTED ROW %d data code %@",row, data);
    stateCode = [data objectForKey:@"code"];
    [stateButton setTitle:[data objectForKey:@"state"] forState:UIControlStateNormal];
    [stateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)closePopover
{
    if(cityPopover!= nil){
        [cityPopover dismissPopoverAnimated:YES];
        cityPopover = nil;
    }
    
    if(statePopover!= nil){
        [statePopover dismissPopoverAnimated:YES];
        statePopover = nil;
    }
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    if([stateCode isEqualToString:@""] || stateCode ==nil)
    {
        [self.view makeToast:@"입력정보가 부족합니다."
                    duration:2.0f
                    position:@"top"
                       title:nil];
        return;
    }
    _posts = [NSMutableArray array];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    http://1.209.82.166:8180/danuri/mobile/support?city=gunposi
    NSDictionary *param  = @{@"language": appDelegate.type,@"mbidx": stateCode};
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [Post globalTimelinePostsWithParameter:param withPath:@"include/json/center_json.asp" Block:^(NSArray *posts, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            NSLog(@"%@",posts);
            
            _posts = posts;
            [tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_posts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellAdIdentifier = @"SupportCell";
    SupportCell *cell = (SupportCell *)[_tableView dequeueReusableCellWithIdentifier:CellAdIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SupportCell" owner:self options:nil];
        cell = (SupportCell *)[nib objectAtIndex:0];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *country;
    if([appDelegate.type isEqualToString:@"kr"]){
        country = @"";
    }else if ([appDelegate.type isEqualToString:@"jp"]){
        country = @"_jp";
    }else if ([appDelegate.type isEqualToString:@"cn"]){
        country = @"_cn";
    }else{
        country = @"_en";
    }
    NSString *mbAddress;
    NSString *mbAddressNew;
    if([appDelegate.type isEqualToString:@"kr"]){
        mbAddress = [NSString stringWithFormat:@"%@",@"mbAddress"];
        mbAddressNew = [NSString stringWithFormat:@"%@",@"mbAddressNew"];
    }else{
        mbAddress = [NSString stringWithFormat:@"%@%@",@"mb_Address",country];
        mbAddressNew = [NSString stringWithFormat:@"%@%@",@"mb_AddressNew",country];
    }
    cell.address.text = [[_posts objectAtIndex:indexPath.row] objectForKey:mbAddress];
    cell.subAddress.text = [[_posts objectAtIndex:indexPath.row] objectForKey:mbAddressNew];
    cell.number.text = [[_posts objectAtIndex:indexPath.row] objectForKey:@"mbPhone"];
//    cell.link = [[_posts objectAtIndex:indexPath.row] objectForKey:@"link"];
    cell.link = [NSString stringWithFormat:@"http://liveinkorea.kr/center/default.asp?pzt=ct&cc=%@",stateCode];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentNumber = [[_posts objectAtIndex:indexPath.row] objectForKey:@"mbPhone"];

    currentLink = [NSString stringWithFormat:@"http://liveinkorea.kr/center/default.asp?pzt=ct&cc=%@",[[_posts objectAtIndex:indexPath.row] objectForKey:@"mbidx"]];

    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"통화연결"                                                        message:@"통화하시겠습니까?"
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"통화",@"홈페이지 가기", nil];
    [alertView setTag:0];
    alertView.delegate = self;
    [alertView show];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (void) callWithOpenURL:(NSString *)phoneNumber {
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) OpenLink:(NSString *)_url {
    NSURL *url = [NSURL URLWithString:_url];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma -
#pragma alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
    NSLog(@"%d %d",alertView.tag,buttonIndex);
    
    
    switch (alertView.tag) {
        case 0:
        {
            if(buttonIndex == 1) {
                [self callWithOpenURL:currentNumber];
            }else if(buttonIndex == 2){
                [self OpenLink:currentLink];
            }
            
        }
            break;
    }
}


@end
