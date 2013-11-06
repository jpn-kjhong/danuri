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
    // Do any additional setup after loading the view from its nib.
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(backToIntro) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
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


@end
