//
//  HelpCenterViewController.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface HelpCenterViewController : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    __weak IBOutlet UIButton *titleButton;
    __weak IBOutlet UIButton *callButton;
    __weak IBOutlet UIImageView *callImage;
    __weak IBOutlet UILabel *callTitle;
    __weak IBOutlet UILabel *callDes;
    __weak IBOutlet UILabel *callNumber;
    
    __weak IBOutlet UIButton *emerButton;
    
    __weak IBOutlet UIImageView *emerImage;
    __weak IBOutlet UILabel *emerTitleLabel;
    UIPickerView *pktStatePicker;
    UIToolbar *mypickerToolbar;
    UIActionSheet *sheet;

}
@end
