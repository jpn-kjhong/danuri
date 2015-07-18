//
//  NoticeViewController.h
//  danuri
//
//  Created by obsidian on 2015. 7. 10..
//  Copyright (c) 2015년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "MBProgressHUD.h"
@interface NoticeViewController  : UIViewController<UIWebViewDelegate>
{
    
    __weak IBOutlet UIWebView *webview;
    NSString* _path;
    __weak IBOutlet UIActivityIndicatorView *ai;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil path:(NSString *)path;

@end