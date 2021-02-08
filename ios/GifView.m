// #import <Foundation/Foundation.h>
// #import <React/RCTViewManager.h>

// #import "UIView+React.h"
#import "FLAnimatedImage.h"
#import "GifView.h"
#import <React/RCTLog.h>

@implementation GifView {

  FLAnimatedImageView *_imageView;
  FLAnimatedImage *_image;

}
- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    _imageView = [[FLAnimatedImageView alloc] init];        
  }
  return self;
}
- (void)layoutSubviews
{
  _imageView.frame = self.bounds;
  [self addSubview:_imageView];
}

- (void)setSource:(NSString *)source
{
  if (![source isEqual:_source]) {
    _source = [source copy];
    [self reloadImage];
  }
}
- (void)setResizeMode:(NSString *)resizeMode
{
  if(![resizeMode isEqual:_resizeMode]) {
    _resizeMode = resizeMode;
    [self reloadImage];
  }
}

-(void)reloadImage {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
   NSData *_imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_source]];
    if(_imageData == nil) {
      _imageData = [NSData dataWithContentsOfFile:[NSURL URLWithString:_source]];
    }
    _image = [FLAnimatedImage animatedImageWithGIFData:_imageData];
    if([_resizeMode isEqualToString:@"contain"]) {
      _imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else if ([_resizeMode isEqualToString:@"cover"]) {
      _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    _imageView.animatedImage = _image;  
  });
}


@end
