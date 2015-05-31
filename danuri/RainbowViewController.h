//
//  RainbowViewController.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"
#import "EntertainView.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
@interface RainbowViewController : UIViewController<UIScrollViewDelegate, EntertainViewDelegate, UIDocumentInteractionControllerDelegate ,UIAlertViewDelegate, UIActionSheetDelegate>
{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet CustomPageControl *pageControl;
    __weak IBOutlet UIButton *yearButton;
    
    NSMutableArray          *arrayEntertainment;
    
    NSMutableDictionary     *dictMessageList;
    
    NSArray                 *_posts;
    bool                    firstConnect;
    NSMutableArray          *requestList;
//    UIPickerView *pktStatePicker;
    UIToolbar *mypickerToolbar;
    UIActionSheet *sheet;
    EntertainView *currentItem;
    NSString *currentLanguage;
}

@end
