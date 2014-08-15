//
//  KoreaStoryViewController.h
//  danuri
//
//  Created by dmlab on 2014. 8. 12..
//  Copyright (c) 2014년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebView+Javascript.h"
#import <MediaPlayer/MediaPlayer.h>

@interface KoreaStoryViewController : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIWebViewDelegate>
{
    UIPickerView *pktStatePicker;
    UIToolbar *mypickerToolbar;
    UIActionSheet *sheet;
    __weak IBOutlet UIWebView *webview;
    
}
@end

