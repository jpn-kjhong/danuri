//
//  UIWebView+Javascript.m
//  danuri
//
//  Created by dmlab on 2014. 8. 13..
//  Copyright (c) 2014년 Kjhong. All rights reserved.
//

#import "UIWebView+Javascript.h"
#import "JSON.h"
@implementation UIWebView (Javascript)

static BOOL diagStat = NO;

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
    
    //    NSLog(@"javascript ConfirmPanel : %@",message);
    
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"예", @"예") otherButtonTitles:NSLocalizedString(@"아니오", @"아니오"), nil];
    
    [confirmDiag show];
    
    //버튼 누르기전까지 지연.
    
    while (confirmDiag.hidden == NO && confirmDiag.superview != nil) {
        
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
    return diagStat;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //index 0 : YES , 1 : NO
    if (buttonIndex == 0){
        
        //return YES;
        
        diagStat = YES;
        
    } else if (buttonIndex == 1) {
        
        //return NO;
        
        diagStat = NO;
        
    }
}

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
    NSLog(@"javascript alert : %@",message);

    NSDictionary *jsonData = [message JSONValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:JavascriptCall object:self userInfo:jsonData];

}

@end