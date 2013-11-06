//
//  EmergencyViewController.h
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface EmergencyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *tableView;
    NSMutableArray *numbers;

    NSMutableArray *contents1;
    NSMutableArray *contents2;

    NSString *currentNumber;
}
@end
