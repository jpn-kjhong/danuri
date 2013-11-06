//
//  KoreanMovieViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "KoreanMovieViewController.h"
#import "ConsultViewController.h"
#import "SelectLangaugeViewController.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "SupportViewController.h"
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
    UIButton *naviBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 37)] ;
    [naviBarBtn setImage:[UIImage imageNamed:@"lang"] forState:UIControlStateNormal];
    [naviBarBtn setImage:[UIImage imageNamed:@"lang_p"] forState:UIControlStateHighlighted];
    [naviBarBtn addTarget:self action:@selector(backToIntro) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:naviBarBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view from its nib.
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
