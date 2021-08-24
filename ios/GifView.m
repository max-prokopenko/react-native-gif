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
      _imageView.shouldIncrementalLoad = NO;
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
      NSURL *url = [NSURL URLWithString:_source];
      
      CGSize thumbnailSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
      
      [_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveLoad context:@{SDWebImageContextImageThumbnailPixelSize : @(thumbnailSize)}];
            
  }
}

@end
