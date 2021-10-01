#import "GifView.h"
#import <SDWebImage/SDWebImage.h>

@implementation GifView {

    SDAnimatedImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
      _imageView = [SDAnimatedImageView new];
              
      _imageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
      _imageView.sd_imageTransition.duration = 0.25;
      _imageView.shouldIncrementalLoad = NO;
  }
  return self;
}

- (void)layoutSubviews
{
    _imageView.frame = self.bounds;
    
    [self addSubview:_imageView];
    [self reloadImage];
}
- (void) reloadImage {
    
    if(_source && _onLoadEnd && self.frame.size.width > 0 && _quality) {
        NSURL *url = [NSURL URLWithString:_source];
        
        CGFloat scale = UIScreen.mainScreen.scale;
        CGSize thumbnailSize = CGSizeMake(self.frame.size.width * scale * _quality, self.frame.size.height * scale * _quality);
        
        [_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveLoad context:@{SDWebImageContextImageThumbnailPixelSize : @(thumbnailSize)} progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if(self->_onLoadEnd) {
                self->_onLoadEnd(@{});
            }
        }];
    }
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
  if (![resizeMode isEqual:_resizeMode]) {
      _resizeMode = [resizeMode copy];
      
      if([_resizeMode isEqualToString:@"contain"]) {
          _imageView.contentMode = UIViewContentModeScaleAspectFit;
      } else if ([_resizeMode isEqualToString:@"cover"]) {
          _imageView.contentMode = UIViewContentModeScaleAspectFill;
      }
  }
}

- (void)setPaused:(BOOL *)paused
{
    if(paused != _paused) {
        _paused = paused;
        if(paused) {
            [_imageView stopAnimating];
        } else {
            [_imageView startAnimating];
        }        
    }
}

- (void)setOnLoadEnd:(RCTDirectEventBlock)onLoadEnd {
    if (![onLoadEnd isEqual:_onLoadEnd]) {
        _onLoadEnd = [onLoadEnd copy];
        [self reloadImage];
    }
}

- (void)setUseCPU:(BOOL)useCPU
{
    if (_useCPU != useCPU) {
        _useCPU = useCPU;
        if (useCPU) {
            _imageView.maxBufferSize = 1;
        }
    }
}

- (void)setQuality:(double)quality
{
    _quality = quality;
    [self reloadImage];
}

@end
