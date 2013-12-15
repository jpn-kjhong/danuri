//
//  CityTableViewController.h
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SupportViewController;
@interface CityTableViewController : UITableViewController
{
    NSArray *dataArray;
//    NSMutableArray *cityArray;
}
@property(nonatomic,assign) SupportViewController *delegate;
@property(nonatomic,strong) NSMutableArray *cityArray;

- (id)initWithStyle:(UITableViewStyle)style delegate:(id)delegate;
@end
