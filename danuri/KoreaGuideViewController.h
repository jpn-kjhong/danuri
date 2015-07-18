//
//  KoreaGuideViewController.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"
#import "EntertainView.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface KoreaGuideViewController : UIViewController<UIScrollViewDelegate, EntertainViewDelegate,UIDocumentInteractionControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UIAlertViewDelegate,UIActionSheetDelegate,UIActionSheetDelegate>
{
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet CustomPageControl *pageControl;
    NSMutableArray          *arrayEntertainment;
    
    NSMutableDictionary     *dictMessageList;
    
    NSArray                 *_posts;

    __weak IBOutlet UIButton *titleButton;
    NSMutableArray          *requestList;
    NSMutableArray          *TaskList;

    UIPickerView *pktStatePicker;
    UIToolbar *mypickerToolbar;
    UIActionSheet *sheet;
    EntertainView *currentItem;

}
@end
