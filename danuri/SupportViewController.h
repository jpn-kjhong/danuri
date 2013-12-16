//
//  SupportViewController.h
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface SupportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UIButton *cityButton;
    __weak IBOutlet UIButton *stateButton;
    
    __weak IBOutlet UIButton *searchButton;
    __weak IBOutlet UITableView *tableView;
    
    FPPopoverController *cityPopover;
    FPPopoverController *statePopover;
    NSString *cityString;
    NSMutableArray *cityArray;
    NSString *stateString;
    NSMutableArray *stateArray;
    
    NSArray                 *_posts;
    NSArray                 *_sigungu;

    NSString                *stateCode;
    NSString                *attrs;
    
    NSInteger              currentCityIndex;
    NSString                *currentNumber;
    NSString                *currentLink;
    NSArray                 *cityList;

}
-(void)selectedTableRow:(NSInteger)row rowData:(NSString *)data;
-(void)selectedStateTableRow:(NSInteger)row rowData:(NSDictionary *)data;

@end
