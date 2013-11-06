
#import "CustomPageControl.h"
@interface CustomPageControl () {
    NSString    *strActive;
    NSString    *strInActive;
}

@end

@implementation CustomPageControl

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initImage];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initImage];
    }
    
    return self;
}

-(void)initImage {
    strActive       = @"page_view_select_9_9.png";
    strInActive     = @"page_view_non_select_9_9.png";
}

-(void)setImageActive:(NSString*)active InActive:(NSString*)inActive {
//    NSLog(@"CustomPageControl - setImageActive:InActive: == %@, %@", active, inActive);
    
    if (active!= nil  && [active length] > 0) {
        if (strActive != nil) {
            strActive = nil;
        }
        
        strActive = [[NSString alloc] initWithString:active];
    }
    
    if (inActive != nil && [inActive length] > 0) {
        if (strInActive != nil) {
            strInActive = nil;
        }
        
        strInActive = [[NSString alloc] initWithString:inActive];
    }
    
    [self updateDots];
}

-(void)updateDots {
//    NSLog(@"CustomPageControl - updateDots() == %@, %@", strActive, strInActive);
    @try {
        if (strActive!= nil  && strInActive != nil) {
            for (int i = 0; i < [self.subviews count]; i++) {
                UIImageView* dot = [self.subviews objectAtIndex:i];
                
                UIImage *imgActive = [UIImage imageNamed:strActive];
                UIImage *imgInActive = [UIImage imageNamed:strInActive];
                
                CGSize sizeImage = imgActive.size;
                
                CGRect frame = dot.frame;
                frame.size = CGSizeMake(sizeImage.width, sizeImage.height);
                dot.frame = frame;
                
                if (i == self.currentPage)
                    [dot setImage:imgActive];
                else
                    [dot setImage:imgInActive];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception == %@",exception);
    }
}

-(void)setNumberOfPages:(NSInteger)numberOfPages {
//    NSLog(@"CustomPageControl - setNumberOfPages == %d", numberOfPages);
    
    [super setNumberOfPages:numberOfPages];
    [self updateDots];
}

-(void)setCurrentPage:(NSInteger)page {
//    NSLog(@"CustomPageControl - setCurrentPage == %d", page);
    
    [super setCurrentPage:page];
    [self updateDots];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
