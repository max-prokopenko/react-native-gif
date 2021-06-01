// #import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface GifView : UIView
@property (nonatomic, copy) NSString *source;    
@property (nonatomic, assign) NSString *resizeMode;

@property (nonatomic, assign) BOOL *paused;
- (void) setPaused:(BOOL *)paused;

@end

