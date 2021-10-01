#import <React/RCTViewManager.h>
#import <Foundation/Foundation.h>
#import "GifView.h"

@interface GifViewManager : RCTViewManager
@end

@implementation GifViewManager {

 GifView *_gifImage;

}

RCT_EXPORT_MODULE(GifImage)

- (UIView *)view
{

  UIView *view = [[UIView alloc] init];
  _gifImage = [[GifView alloc] init];
  [view addSubview:_gifImage];
  return _gifImage;  
}
RCT_EXPORT_VIEW_PROPERTY(source, NSString);
RCT_EXPORT_VIEW_PROPERTY(resizeMode, NSString);
RCT_EXPORT_VIEW_PROPERTY(paused, BOOL);
RCT_EXPORT_VIEW_PROPERTY(onLoadEnd, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(useCPU, BOOL);
RCT_EXPORT_VIEW_PROPERTY(quality, double);

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end

