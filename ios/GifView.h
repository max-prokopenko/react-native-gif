// #import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <React/RCTView.h>

@interface GifView : UIView
@property (nonatomic, copy) NSString *source;    
@property (nonatomic, copy) NSString *resizeMode;

@property (nonatomic, assign) BOOL *paused;

@property (nonatomic, assign) BOOL useCPU;
@property (nonatomic, assign) double quality;

@property (nonatomic, copy) RCTDirectEventBlock onLoadEnd;

@end

