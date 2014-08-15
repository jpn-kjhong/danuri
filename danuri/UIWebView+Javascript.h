//
//  UIWebView+Javascript.h
//  danuri
//
//  Created by dmlab on 2014. 8. 13..
//  Copyright (c) 2014년 Kjhong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebView;
@class WebFrame;
@interface UIWebView (Javascript)
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame;
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame;
@end