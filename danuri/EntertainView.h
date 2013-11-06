#define fViewWidth              238.0
#define fViewHeight             335.0

#define Notification_UpdateTimer        @"NotificationUpdateTimer"

#import <UIKit/UIKit.h>
enum {
    EntertainViewType_None          = 101,
    EntertainViewType_Normal        = 111,
    EntertainViewType_Dummy         = 121,
};
typedef NSUInteger EntertainViewType;

@protocol EntertainViewDelegate;

@interface EntertainView : UIView //<HTTPManagerDelegate>

-(void)setDummyImage;
-(void)setEntertainViewType:(EntertainViewType)type;
-(void)setDataFromDictionary:(NSDictionary*)dictData;
-(void)setDelegate:(id<EntertainViewDelegate>)dDelegate;

//-(NSString*)getMessageCode;
-(NSString*)getTargetURL;
-(NSString*)getYear;
//-(NSInteger)getEtmID;
//-(NSString*)getContents;
//-(NSInteger)getPlayableTime;
@property (nonatomic, strong) NSString *linkType;
@property (nonatomic, strong) NSString *imageType;
@property (nonatomic, strong) UIProgressView *progress;
@end

@protocol EntertainViewDelegate <NSObject>

-(void)didEntertainViewClicked:(EntertainView*)entertainView;

@end
