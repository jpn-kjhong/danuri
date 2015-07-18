//
//  NoticeViewController.m
//  danuri
//
//  Created by obsidian on 2015. 7. 10..
//  Copyright (c) 2015년 Kjhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeViewController.h"

#import "AppDelegate.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil path:(NSString *)path

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _path = path;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"공지사항"];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    NSURL *myURL = [NSURL URLWithString:_path];
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
    [webview loadRequest:myURLReq];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ai startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [ai stopAnimating];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [ai stopAnimating];

}

@end
