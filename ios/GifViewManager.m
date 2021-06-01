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

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end

// https://media.tenor.com/images/694537a63a62edc1fa7d8c7ed9dfb5de/tenor.gif
