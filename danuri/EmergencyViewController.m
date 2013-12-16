//
//  EmergencyViewController.m
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "EmergencyViewController.h"
#import "EmergencyCell.h"
#import "JSON.h"
#import "AppDelegate.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

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
    [tracker set:kGAIScreenName value:@"긴급연락처"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path;
    if([appDelegate.type isEqualToString:@"kr"]){
        path = @"/kr_call.json";
    }else if([appDelegate.type isEqualToString:@"en"]){
        path = @"/en_call.json";
    }else if([appDelegate.type isEqualToString:@"cn"]){
        path = @"/cn_call.json";
    }else if([appDelegate.type isEqualToString:@"vn"]){
        path = @"/vn_call.json";
    }else if([appDelegate.type isEqualToString:@"ph"]){
        path = @"/ph_call.json";
    }else if([appDelegate.type isEqualToString:@"kh"]){
        path = @"/kh_call.json";
    }else if([appDelegate.type isEqualToString:@"mn"]){
        path = @"/mn_call.json";
    }else if([appDelegate.type isEqualToString:@"ru"]){
        path = @"/ru_call.json";
    }else if([appDelegate.type isEqualToString:@"jp"]){
        path = @"/jp_call.json";
    }else if([appDelegate.type isEqualToString:@"th"]){
        path = @"/th_call.json";
    }else {
        path = @"/kr_call.json";
    }
    
    NSString *myJsonPath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingString:path];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:myJsonPath encoding:NSUTF8StringEncoding error:NULL];
    if (!myJSON) {
        NSLog(@"File couldn't be read!");
        return;
    }
    NSArray *callArray = [myJSON JSONValue];
    
    // Do any additional setup after loading the view from its nib.
    numbers = [NSMutableArray arrayWithCapacity:2];
    contents1 = [NSMutableArray array];
    contents2 = [NSMutableArray array];

    [contents1 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:2] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:2] objectForKey:@"title"],@"title",[[callArray objectAtIndex:2] objectForKey:@"subtitle"],@"detail",@"1577-1366",@"number", nil]];
    [contents1 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:3] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:3] objectForKey:@"title"],@"title",[[callArray objectAtIndex:3] objectForKey:@"subtitle"],@"detail",@"119",@"number", nil]];
    [contents1 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:4] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:4] objectForKey:@"title"],@"title",[[callArray objectAtIndex:4] objectForKey:@"subtitle"],@"detail",@"1339",@"number", nil]];
    [contents1 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:5] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:5] objectForKey:@"title"],@"title",[[callArray objectAtIndex:5] objectForKey:@"subtitle"],@"detail",@"112",@"number", nil]];
    
    [numbers addObject:contents1];

    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:6] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:6] objectForKey:@"title"],@"title",[[callArray objectAtIndex:6] objectForKey:@"subtitle"],@"detail",@"1345",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:7] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:7] objectForKey:@"title"],@"title",[[callArray objectAtIndex:7] objectForKey:@"subtitle"],@"detail",@"1544-1199",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:8] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:8] objectForKey:@"title"],@"title",[[callArray objectAtIndex:8] objectForKey:@"subtitle"],@"detail",@"1357",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:9] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:9] objectForKey:@"title"],@"title",[[callArray objectAtIndex:9] objectForKey:@"subtitle"],@"detail",@"1577-1391",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:10] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:10] objectForKey:@"title"],@"title",[[callArray objectAtIndex:10] objectForKey:@"subtitle"],@"detail",@"110",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:11] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:11] objectForKey:@"title"],@"title",[[callArray objectAtIndex:11] objectForKey:@"subtitle"],@"detail",@"1332",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:12] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:12] objectForKey:@"title"],@"title",[[callArray objectAtIndex:12] objectForKey:@"subtitle"],@"detail",@"1372",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:13] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:13] objectForKey:@"title"],@"title",[[callArray objectAtIndex:13] objectForKey:@"subtitle"],@"detail",@"129",@"number", nil]];
    [contents2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[callArray objectAtIndex:14] objectForKey:@"icon"],@"image",[[callArray objectAtIndex:14] objectForKey:@"title"],@"title",[[callArray objectAtIndex:14] objectForKey:@"subtitle"],@"detail",@"1350",@"number", nil]];
    
    [numbers addObject:contents2];
    
    NSLog(@"%@",numbers);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)_tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0 ){
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30)];
//        /* Create custom view to display section header... */
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, _tableView.frame.size.width, 18)];
//        [title setFont:[UIFont boldSystemFontOfSize:20]];
//        title.textAlignment = NSTextAlignmentCenter;
//        NSString *titleString =@"긴급연락처 안내";
//        /* Section header is in 0th index... */
//        [title setText:titleString];
//        title.textColor = RGB(189, 235, 80);
//
//        [view addSubview:title];
//        
//        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, _tableView.frame.size.width, 12)];
//        [subTitle setFont:[UIFont boldSystemFontOfSize:10]];
//        subTitle.textAlignment = NSTextAlignmentCenter;
//        NSString *subTitleString =@"Emergency Telephone Numbers";
//        /* Section header is in 0th index... */
//        [subTitle setText:subTitleString];
//        subTitle.textColor = RGB(189, 235, 80);
//
//        [view addSubview:subTitle];
//        [view setBackgroundColor:[UIColor whiteColor]];
        UIImage *image = [UIImage imageNamed:@"banner_01"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30)];
        
        UIImageView *myImage = [[UIImageView alloc] initWithImage:image];
        [view addSubview:myImage];
        
        return view;
    }else{
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30)];
//        /* Create custom view to display section header... */
//        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, _tableView.frame.size.width, 18)];
//        [title setFont:[UIFont boldSystemFontOfSize:20]];
//        title.textAlignment = NSTextAlignmentCenter;
//        NSString *titleString =@"생활서비스 연락처 안내";
//        /* Section header is in 0th index... */
//        [title setText:titleString];
//        title.textColor = RGB(189, 235, 80);
//        
//        [view addSubview:title];
//        
//        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, _tableView.frame.size.width, 12)];
//        [subTitle setFont:[UIFont boldSystemFontOfSize:10]];
//        subTitle.textAlignment = NSTextAlignmentCenter;
//        NSString *subTitleString =@"Telephone Numbers for Assistance";
//        /* Section header is in 0th index... */
//        [subTitle setText:subTitleString];
//        subTitle.textColor = RGB(189, 235, 80);
//        
//        [view addSubview:subTitle];
//        [view setBackgroundColor:[UIColor whiteColor]];
        UIImage *image = [UIImage imageNamed:@"banner_02"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30)];
        
        UIImageView *myImage = [[UIImageView alloc] initWithImage:image];
        [view addSubview:myImage];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [numbers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[numbers objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellAdIdentifier = @"EmergencyCell";
    EmergencyCell *cell = (EmergencyCell *)[_tableView dequeueReusableCellWithIdentifier:CellAdIdentifier];
    
    if (cell == nil) {
//        cell = [[EmergencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellAdIdentifier Delegate:self] ];
//        cell = [[EmergencyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellAdIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EmergencyCell" owner:self options:nil];
        cell = (EmergencyCell *)[nib objectAtIndex:0];
    }
    
    NSString *imageName =[[[numbers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"image"];
    UIImage *image = [UIImage imageNamed:imageName];
    
    cell.thumbnail.image = image;
    cell.title.text = [[[numbers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detail.text = [[[numbers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"detail"];
    cell.number.text = [[[numbers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"number"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    currentNumber = [[[numbers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"number"];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"통화연결"                                                        message:@"통화하시겠습니까?"
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"통화", nil];
    [alertView setTag:0];
    alertView.delegate = self;
    [alertView show];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void) callWithOpenURL:(NSString *)phoneNumber {
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
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
            }else{
                
            }
            
        }
            break;
    }
}
@end
