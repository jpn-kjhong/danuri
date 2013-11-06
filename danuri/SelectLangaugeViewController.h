//
//  SelectLangaugeViewController.h
//  danuri
//
//  Created by Kjhong on 2013. 10. 26..
//  Copyright (c) 2013년 Kjhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLangaugeViewController : UIViewController
{

    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    __weak IBOutlet UIButton *button3;
    __weak IBOutlet UIButton *button4;
    
    __weak IBOutlet UIButton *button5;
    
    __weak IBOutlet UIButton *button6;
    __weak IBOutlet UIButton *button7;
    __weak IBOutlet UIButton *button8;
    __weak IBOutlet UIButton *button9;
    __weak IBOutlet UIButton *button10;
    NSTimer *animateTimer;
    NSTimer *animateTimer1;
    NSTimer *animateTimer2;
    NSTimer *animateTimer3;
    NSTimer *animateTimer4;
    
    NSTimer *animateTimerbottom;
    NSTimer *animateTimerbottom1;
    NSTimer *animateTimerbottom2;
    NSTimer *animateTimerbottom3;
    NSTimer *animateTimerbottom4;
    
	NSTimer *bounceTimer;
    NSTimer *bounceTimerBottom;
	int growCount, growDir;
	CGFloat buttonScale;
}
@property (nonatomic, retain) NSTimer *animateTimer;
@property (nonatomic, retain) NSTimer *bounceTimer;

-(void) animateButtons;
-(void) bounceButtons;
-(IBAction) buttonBounce;
-(IBAction) buttonMove;

- (IBAction)ClickButton:(UIButton *)sender;

@end
