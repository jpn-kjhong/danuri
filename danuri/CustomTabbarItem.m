

#import "CustomTabbarItem.h"


@implementation CustomTabBarItem

@synthesize customHighlightedImage;
@synthesize customStdImage;

-(id)init
{
    if (self = [super init]) {
        [self setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    }
    return self;
}

-(UIImage *) selectedImage
{
    return self.customHighlightedImage;
}

-(UIImage *) unselectedImage
{
    return self.customStdImage;
}

@end
