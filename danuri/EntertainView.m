#define fThumbnailWidth             236.0
#define fThumbnailHeight            329.0
#define fShadowWidth                186.0
#define fShadowHeight               14.0
#define fBottomWidth                225.0
#define fBottomHeight               81.0

#define fTitleLabelFont             13.0
#define fContentLabelFornt          10.0

#define fLabelSideGap               14.0
#define fLabelTopGap                11.0
#define fLabelBetweenGap            4.0

#define fTitleLabelHeight           15.0
#define fContentLabelHeightMax      36.0

#define ImgAddr_Entertain_pagecontrol_on                                    @"pagecontrol_on_6x6"
#define ImgAddr_Entertain_pagecontrol_off                                   @"pagecontrol_off_6x6"

#define ImgAddr_Entertain_no_image                                          @"no_image_212_291"
#define ImgAddr_Entertain_bg_small                                          @"bg_normal_320_416"
#define ImgAddr_Entertain_bg_big                                            @"bg_normal_320_416-568h@2x"
#define ImgAddr_Entertain_slide_shadow                                      @"slide_shadow"

#define RGB(r, g, b)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/100.0]

#define IS_IPHONE5                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ([UIScreen mainScreen].bounds.size.height > 480.0f)

#define stringValue(v)                  [NSString stringWithFormat:@"%d",v]



#define Color_PlaceHolder_TextColor             RGB(190, 151, 101)
#define Color_EmailTableView_BackGroundView     RGB(255, 255, 255)
#define fView_Animation_Duration                0.4f

#import <QuartzCore/QuartzCore.h>
#import "EntertainView.h"
#define Path_Folder_Entertainment               @"images/"
@interface EntertainView () {
    id<EntertainViewDelegate>       idDelegate;
    
    UIImageView                     *ivThumbnail;
    UIImageView                     *ivShadow;
    UIImageView                     *ivTimerPlay;
    
    UILabel                         *labelTitle;
    UILabel                         *labelContent;
    
    UILabel                         *labelTimer;
    
    NSDictionary                    *dictEnterData;
    
    UIActivityIndicatorView         *aivLoading;
    
    EntertainViewType               nEnterViewType;
    NSString                        *year;
    NSString                        *link;
}

@end

@implementation EntertainView
@synthesize progress;
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, fViewWidth, fViewHeight)];
    
    if (self) {
        // Initialization code
        nEnterViewType = EntertainViewType_None;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerTick:) name:Notification_UpdateTimer object:nil];
        
//        UIImage *imgShadow = [UIImage imageNamed:ImgAddr_Entertain_slide_shadow];
//        
//        ivShadow = [[UIImageView alloc] initWithImage:imgShadow];
//        [ivShadow setFrame:CGRectMake(0.0, 0.0, fShadowWidth, fShadowHeight)];
//        [ivShadow setContentMode:UIViewContentModeScaleAspectFit];
//        [ivShadow setCenter:CGPointMake(fViewWidth/2.0, fThumbnailHeight + 8.0)];
//        [ivShadow setBackgroundColor:[UIColor clearColor]];
//        
//        [self addSubview:ivShadow];
    }
    
    return self;
}

-(void)setDummyImage{
        UIImageView *ivBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -3.0, fViewWidth, fViewHeight)];
        [ivBg setContentMode:UIViewContentModeScaleAspectFit];
        [ivBg setImage:[UIImage imageNamed:@"r_01"]];
        [self addSubview:ivBg];
}

-(void)setDelegate:(id<EntertainViewDelegate>)dDelegate {
    idDelegate = dDelegate;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, fViewWidth, fViewHeight)];
}

-(void)setBounds:(CGRect)bounds {
    [super setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, fViewWidth, fViewHeight)];
}

-(void)setEntertainViewType:(EntertainViewType)type {
    nEnterViewType = type;
    
    switch (type) {
        case EntertainViewType_Normal: {
            UIImage *imgNoImage = [UIImage imageNamed:ImgAddr_Entertain_no_image];
            
            ivThumbnail = [[UIImageView alloc] initWithImage:imgNoImage];
            [ivThumbnail setFrame:CGRectMake(0.0, 0.0, fThumbnailWidth, fThumbnailHeight)];
            [ivThumbnail setContentMode:UIViewContentModeScaleAspectFit];
            [ivThumbnail setCenter:CGPointMake(fViewWidth/2.0, fThumbnailHeight/2.0)];
            [ivThumbnail setBackgroundColor:[UIColor clearColor]];
            
            UIBezierPath *bpMask = [UIBezierPath bezierPathWithRoundedRect:ivThumbnail.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(12.5, 12.5)];
            
            CAShapeLayer *caslMask = [[CAShapeLayer alloc] init];
            caslMask.frame = ivThumbnail.bounds;
            caslMask.path = bpMask.CGPath;
            ivThumbnail.layer.mask = caslMask;
            
            aivLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [aivLoading setCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)];
            [aivLoading setHidesWhenStopped:YES];
            [aivLoading setHidden:YES];
            self.progress = [[UIProgressView alloc] initWithFrame:CGRectZero];
            self.progress.frame = CGRectMake(0, ivThumbnail.frame.origin.y + ivThumbnail.frame.size.height - 5, fThumbnailWidth, 20);
            [self addSubview:ivThumbnail];
            [self addSubview:self.progress];
            [self.progress setHidden:YES];
            [self addSubview:aivLoading];
            [self bringSubviewToFront:aivLoading];
        } break;
        default: {
        } break;
    }
    
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnStart setFrame:CGRectMake(0.0, 0.0, fViewWidth, fViewHeight)];
    [btnStart addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btnStart];
}

-(void)startIndicator {
    [aivLoading setHidden:NO];
    [aivLoading startAnimating];
}

-(void)stopIndicator {
    [aivLoading setHidden:YES];
    [aivLoading stopAnimating];
}

-(void)setDataFromDictionary:(NSDictionary*)dictData {
//    NSLog(@"EntertainView - setDataFromDictionary == %@", dictData);
    
    if (dictData != nil && [dictData isKindOfClass:[NSDictionary class]]) {
        dictEnterData = [[NSDictionary alloc] initWithDictionary:dictData];
        
        [self createEntertainmentFolder];
        
        NSString *strThumbnail = [dictEnterData objectForKey:self.imageType];
        
        if (strThumbnail != nil && [strThumbnail length] > 7) {
            NSString *strFileName = [strThumbnail lastPathComponent];
            NSString *strFilePath = [self getDocumentPath:strFileName];
            
            NSFileManager *mFileManager = [NSFileManager defaultManager];
            
            if ([mFileManager fileExistsAtPath:strFilePath]) {
                UIImage *imageThumbnail = [UIImage imageWithContentsOfFile:strFilePath];
                
                if (imageThumbnail !=nil) {
                    [ivThumbnail setImage:imageThumbnail];
                } else {
                    [self loadImage:strThumbnail];
                }
            } else {
                [self loadImage:strThumbnail];
            }
        }
        link = [dictEnterData objectForKey:self.linkType];
        year = [dictEnterData objectForKey:@"rb_year"];

    }
}

-(void)loadImage:(NSString*)strURL {
    [self startIndicator];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *dataImage = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:strURL]] ;
        UIImage *imageThumbnail = [UIImage imageWithData:dataImage];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (imageThumbnail !=nil) {
                
                [ivThumbnail setImage:imageThumbnail];
                
                NSString *strFileName = [strURL lastPathComponent];
                NSString *strFilePath = [self getDocumentPath:strFileName];
                
                NSFileManager *mFileManager = [NSFileManager defaultManager];
                
                if (![mFileManager fileExistsAtPath:strFilePath]) {
                    [dataImage writeToFile:strFilePath atomically:YES];
                }
            }
            
            [self stopIndicator];
        });
    });
}

-(void)startButtonClicked:(id)sender {
    switch (nEnterViewType) {
        case EntertainViewType_Normal: {
            if (idDelegate != nil && [idDelegate respondsToSelector:@selector(didEntertainViewClicked:)]) {
                [idDelegate didEntertainViewClicked:self];
            }
        } break;
        case EntertainViewType_Dummy: {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil // Alert Title Removed
                                                                message:@"페이지 없음"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        } break;
        default:
            break;
    }
}

-(NSString*)getTargetURL {
    NSString *strURL = nil;
    
    if (dictEnterData != nil) {
        strURL = [dictEnterData objectForKey:self.linkType];
    }
    
    return strURL;
}

-(NSString*)getYear {
    NSString *strYear = nil;
    
    if (dictEnterData != nil) {
        strYear = [dictEnterData objectForKey:@"rb_year"];
    }
    
    return strYear;
}


-(NSString*)getTitle {
    NSString *strTitle = nil;
    
    if (dictEnterData != nil) {
        strTitle = [dictEnterData objectForKey:@"rb_pdf_link"];
    }
    
    return strTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Document Folder Path

-(void)createEntertainmentFolder {
    NSFileManager *mFileManager = [NSFileManager defaultManager];
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strDocumentPath = [arrayPaths objectAtIndex:0];
    NSString *strEntertainmentPath = [strDocumentPath stringByAppendingPathComponent:Path_Folder_Entertainment];
    NSString *strEntertainmentPathEtmID = [strEntertainmentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [self getTitle]]];
    
    NSError *error = nil;
    
    if ([mFileManager fileExistsAtPath:strEntertainmentPath]) {
        if (![mFileManager fileExistsAtPath:strEntertainmentPathEtmID]) {
            [mFileManager createDirectoryAtPath:strEntertainmentPathEtmID withIntermediateDirectories:YES attributes:nil error:&error];
        }
    } else {
        [mFileManager createDirectoryAtPath:strEntertainmentPathEtmID withIntermediateDirectories:YES attributes:nil error:&error];
    }
}

-(NSString*)getDocumentPath:(NSString*)filename {
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strDocumentPath = [arrayPaths objectAtIndex:0];
    NSString *strEntertainmentPath = [strDocumentPath stringByAppendingPathComponent:Path_Folder_Entertainment];
    NSString *strEntertainmentPathEtmID = [strEntertainmentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [self getTitle]]];
    
    return [strEntertainmentPathEtmID stringByAppendingPathComponent:filename];
}

@end
