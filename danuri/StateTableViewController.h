//
//  StateTableViewController.h
//  danuri
//
//  Created by Hong kijoo on 13. 10. 27..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SupportViewController;

@interface StateTableViewController : UITableViewController
{
    NSArray *dataArray;
    NSMutableArray *cityArray;
    NSMutableArray *stateArray;

    NSMutableDictionary *stateDic;
}
@property(nonatomic,assign) SupportViewController *delegate;
@property NSInteger cityIndex;
- (id)initWithStyle:(UITableViewStyle)style delegate:(id)delegate;
@end
