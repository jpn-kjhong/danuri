
#import <UIKit/UIKit.h>

@interface ModalWebViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;  
    
    UIButton *optionBtn;
    UIButton *closeBarBtn;
}
@property (strong, nonatomic) NSString* urlString;

@end
