//
//  SupportCell.h
//  danuri
//
//  Created by Hong kijoo on 13. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *subAddress;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) NSString *link;
@end
