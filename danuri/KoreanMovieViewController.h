//
//  KoreanMovieViewController.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface KoreanMovieViewController : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>{
    
    __weak IBOutlet UIButton *familyButton;
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UIImageView *familyImage;
    
    __weak IBOutlet UIButton *homeButton;
    __weak IBOutlet UILabel *homeLabel;
    
    __weak IBOutlet UIImageView *homeImage;
    
    
    
    UIPickerView *pktStatePicker;
    UIToolbar *mypickerToolbar;
    UIActionSheet *sheet;
}

@end
