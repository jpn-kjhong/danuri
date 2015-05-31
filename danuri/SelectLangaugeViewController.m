//
//  SelectLangaugeViewController.m
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import "SelectLangaugeViewController.h"
#import "AppDelegate.h"
#import "SKBounceAnimation.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

CGFloat buttonScale = 1.0;
int growDir = 0;
int growCount = 0;

CGFloat buttonScaleBottom = 1.0;
int growDirBottom = 0;
int growCountBottom = 0;
float padding = 0;
int moveCount = 0.1;
@interface SelectLangaugeViewController ()
{
    NSArray *buttonArray;
}
@end

@implementation SelectLangaugeViewController
@synthesize animateTimer,bounceTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:@"언어선택화면"];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    if([[UIScreen mainScreen]bounds].size.height > 480.0000){
        padding = 70.f;

        button6.frame = CGRectMake(button6.frame.origin.x, button6.frame.origin.y + padding, button6.frame.size.width, button6.frame.size.height);
        button7.frame = CGRectMake(button7.frame.origin.x, button7.frame.origin.y + padding, button7.frame.size.width, button7.frame.size.height);
        button8.frame = CGRectMake(button8.frame.origin.x, button8.frame.origin.y + padding, button8.frame.size.width, button8.frame.size.height);
        button9.frame = CGRectMake(button9.frame.origin.x, button9.frame.origin.y + padding, button9.frame.size.width, button9.frame.size.height);
        button10.frame = CGRectMake(button10.frame.origin.x, button10.frame.origin.y + padding, button10.frame.size.width, button10.frame.size.height);
        button11.frame = CGRectMake(button11.frame.origin.x, button11.frame.origin.y + padding, button11.frame.size.width, button11.frame.size.height );
        button12.frame = CGRectMake(button12.frame.origin.x, button12.frame.origin.y + padding, button12.frame.size.width, button12.frame.size.height );
        button13.frame = CGRectMake(button13.frame.origin.x, button13.frame.origin.y + padding, button13.frame.size.width, button13.frame.size.height );
        
        
    }
    // Do any additional setup after loading the view from its nib.
//    [self performSelectorOnMainThread:@selector(addBounceAnimation) withObject:nil waitUntilDone:<#(BOOL)#>]
    buttonArray = [[NSArray alloc] initWithObjects:button2, button3, button4, button5, button6, button7, button8, button9, nil];
//    [self performSelector:@selector(buttonMove) withObject:nil afterDelay:0.0];
//    [self performSelector:@selector(buttonMove1) withObject:nil afterDelay:0.3];
//    [self performSelector:@selector(buttonMove2) withObject:nil afterDelay:0.6];
//    [self performSelector:@selector(buttonMove3) withObject:nil afterDelay:0.9];
//    [self performSelector:@selector(buttonMove4) withObject:nil afterDelay:1.2];
//    
//    [self performSelector:@selector(buttonMove5) withObject:nil afterDelay:0.0];
//    [self performSelector:@selector(buttonMove6) withObject:nil afterDelay:0.3];
//    [self performSelector:@selector(buttonMove7) withObject:nil afterDelay:0.6];
//    [self performSelector:@selector(buttonMove8) withObject:nil afterDelay:0.9];
//    [self performSelector:@selector(buttonMove9) withObject:nil afterDelay:1.2];
}

-(IBAction) buttonBounce {
	growDir = 1;
	buttonScale = 1.000000;
	bounceTimer = [NSTimer
				   scheduledTimerWithTimeInterval:0.02
				   target:self
				   selector:@selector(bounceButtons)
				   userInfo:nil
				   repeats:YES];
}

-(IBAction) buttonBounceBottom {
	growDirBottom = 1;
	buttonScaleBottom = 1.000000;
	bounceTimerBottom = [NSTimer
				   scheduledTimerWithTimeInterval:0.02
				   target:self
				   selector:@selector(bounceButtonsBottom)
				   userInfo:nil
				   repeats:YES];
}



-(IBAction) buttonMove {
	animateTimer = [NSTimer
					scheduledTimerWithTimeInterval:0.0001
					target:self
					selector:@selector(animateButtons)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMove1 {
	animateTimer1 = [NSTimer
					scheduledTimerWithTimeInterval:0.0001
					target:self
					selector:@selector(animateButtons1)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMove2 {
	animateTimer2 = [NSTimer
					scheduledTimerWithTimeInterval:0.0001
					target:self
					selector:@selector(animateButtons2)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMove3 {
	animateTimer3 = [NSTimer
					scheduledTimerWithTimeInterval:0.0001
					target:self
					selector:@selector(animateButtons3)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMove4 {
	animateTimer4 = [NSTimer
					scheduledTimerWithTimeInterval:0.0001
					target:self
					selector:@selector(animateButtons4)
					userInfo:nil
					repeats:YES];
}

-(IBAction) buttonMove5 {
	animateTimerbottom = [NSTimer
                     scheduledTimerWithTimeInterval:0.0001
                     target:self
                     selector:@selector(animateButtons5)
                     userInfo:nil
                     repeats:YES];
}

-(IBAction) buttonMove6 {
	animateTimerbottom1 = [NSTimer
                     scheduledTimerWithTimeInterval:0.0001
                     target:self
                     selector:@selector(animateButtons6)
                     userInfo:nil
                     repeats:YES];
}

-(IBAction) buttonMove7 {
	animateTimerbottom2 = [NSTimer
                     scheduledTimerWithTimeInterval:0.0001
                     target:self
                     selector:@selector(animateButtons7)
                     userInfo:nil
                     repeats:YES];
}

-(IBAction) buttonMove8 {
	animateTimerbottom3 = [NSTimer
                     scheduledTimerWithTimeInterval:0.0001
                     target:self
                     selector:@selector(animateButtons8)
                     userInfo:nil
                     repeats:YES];
}

-(IBAction) buttonMove9 {
	animateTimerbottom4 = [NSTimer
                     scheduledTimerWithTimeInterval:0.0001
                     target:self
                     selector:@selector(animateButtons9)
                     userInfo:nil
                     repeats:YES];
}


-(void) animateButtons {
    if(animateTimer == nil)
        return;
     CGRect frame = [button1 frame];
	frame.origin.y = frame.origin.y-0.05 ;
	button1.frame = frame;

	if (frame.origin.y <= 80.00000) {
		[animateTimer invalidate];
        animateTimer = nil;
    }
    
}
-(void) animateButtons1 {
    if(animateTimer1 == nil)
        return;
	CGRect frame2 = [button2 frame];
	frame2.origin.y = frame2.origin.y-0.075 ;
	button2.frame = frame2;
    
	if (frame2.origin.y <= 30.00000) {
		[animateTimer1 invalidate];
        animateTimer1 = nil;
	}
}

-(void) animateButtons2 {
    
    if(animateTimer2 == nil)
        return;
	CGRect frame = [button3 frame];

	frame.origin.y = frame.origin.y-0.05;
	button3.frame = frame;
    
	if (frame.origin.y <= 80.00000) {
		[animateTimer2 invalidate];
        animateTimer2 = nil;
	}
}

-(void) animateButtons3 {
    
    if(animateTimer3 == nil)
        return;
	CGRect frame = [button4 frame];
    
	frame.origin.y = frame.origin.y-0.075 ;
	button4.frame = frame;
    
	if (frame.origin.y <= 30.00000) {
		[animateTimer3 invalidate];
        animateTimer3 = nil;
	}
}

-(void) animateButtons4 {
    
    if(animateTimer4 == nil)
        return;
	CGRect frame = [button5 frame];
    
	frame.origin.y = frame.origin.y-0.05 ;
	button5.frame = frame;
    
	if (frame.origin.y <= 80.00000) {
		[animateTimer4 invalidate];
        animateTimer4 = nil;
        [self buttonBounce];
	}
}

-(void) animateButtons5 {
    
    if(animateTimerbottom == nil)
        return;
	CGRect frame = [button6 frame];
    
	frame.origin.y = frame.origin.y+0.05 ;
	button6.frame = frame;
    
	if (frame.origin.y >= 320.00000 + padding) {
		[animateTimerbottom invalidate];
        animateTimerbottom = nil;
	}
}

-(void) animateButtons6 {
    
    if(animateTimerbottom1 == nil)
        return;
	CGRect frame = [button7 frame];
    
	frame.origin.y = frame.origin.y+0.075 ;
	button7.frame = frame;
    
	if (frame.origin.y >= 370.00000 + padding) {
		[animateTimerbottom1 invalidate];
        animateTimerbottom1 = nil;
	}
}

-(void) animateButtons7 {
    
    if(animateTimerbottom2 == nil)
        return;
	CGRect frame = [button8 frame];
    
	frame.origin.y = frame.origin.y+0.05 ;
	button8.frame = frame;
    
	if (frame.origin.y >= 320.00000 + padding) {
		[animateTimerbottom2 invalidate];
        animateTimerbottom2 = nil;
	}
}

-(void) animateButtons8 {
    
    if(animateTimerbottom3 == nil)
        return;
	CGRect frame = [button9 frame];
    
	frame.origin.y = frame.origin.y+0.075 ;
	button9.frame = frame;
    
	if (frame.origin.y >= 370.00000 + padding) {
		[animateTimerbottom3 invalidate];
        animateTimerbottom3 = nil;
	}
}

-(void) animateButtons9 {
    
    if(animateTimerbottom4 == nil)
        return;
	CGRect frame = [button10 frame];
    
	frame.origin.y = frame.origin.y+0.05 ;
	button10.frame = frame;
    
	if (frame.origin.y >= 320.00000 + padding) {
		[animateTimerbottom4 invalidate];
        animateTimerbottom4 = nil;
        [self buttonBounceBottom];
	}
}




-(void) bounceButtons {
	
	if(bounceTimer == nil)
        return;
    
	if (buttonScale >= 1.400000) {
		growDir = 0;
	}
	if (buttonScale <= 0.800000) {
		growDir = 1;
	}
	switch (growDir) {
        case 0:
			buttonScale = buttonScale - 0.1f;
			break;
        case 1:
			buttonScale = buttonScale + 0.1f;
			if (buttonScale == 1.00000) {
				[bounceTimer invalidate];
                bounceTimer = nil;
			}
			break;
	}
	
	CGAffineTransform transform = CGAffineTransformMakeScale(buttonScale, buttonScale);
	button1.transform = transform;
	button2.transform = transform;
	button3.transform = transform;
	button4.transform = transform;
    button5.transform = transform;

	
}

-(void) bounceButtonsBottom {
	
	if(bounceTimerBottom == nil)
        return;
	if (buttonScaleBottom >= 1.400000) {
		growDirBottom = 0;
	}
	if (buttonScaleBottom <= 0.800000) {
		growDirBottom = 1;
	}
	switch (growDirBottom) {
        case 0:
			buttonScaleBottom = buttonScaleBottom - 0.1f;
			break;
        case 1:
			buttonScaleBottom = buttonScaleBottom + 0.1f;
			if (buttonScaleBottom == 1.00000) {
				[bounceTimerBottom invalidate];
                bounceTimerBottom = nil;
			}
			break;
	}
	
	CGAffineTransform transform = CGAffineTransformMakeScale(buttonScaleBottom, buttonScaleBottom);
	button6.transform = transform;
	button7.transform = transform;
	button8.transform = transform;
	button9.transform = transform;
    button10.transform = transform;
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickButton:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"[tag] = %d", [sender tag]);
    switch ([sender tag]) {
        case 1:
            appDelegate.type = @"kr";
            break;
        case 2:
            appDelegate.type = @"en";
            break;
        case 3:
            appDelegate.type = @"cn";
            break;
        case 4:
            appDelegate.type = @"vn";
            break;
        case 5:
            appDelegate.type = @"ph";
            break;
        case 6:
            appDelegate.type = @"kh";
            break;
        case 7:
            appDelegate.type = @"mn";
            break;
        case 8:
            appDelegate.type = @"ru";
            break;
        case 9:
            appDelegate.type = @"jp";
            break;
        case 10:
            appDelegate.type = @"th";
            break;
        case 11:
            appDelegate.type = @"la";
            break;
        case 12:
            appDelegate.type = @"ne";
            break;
        case 13:
            appDelegate.type = @"uz";
            break;
        default:
            appDelegate.type = @"kr";
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SuccessCertification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
