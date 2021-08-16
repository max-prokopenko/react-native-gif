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
  dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:self->_source];
        [self loadAnimatedImageWithURL:url completion:^(FLAnimatedImage *animatedImage) {
            self->_image = animatedImage;
            NSInteger cMode = UIViewContentModeScaleAspectFit;
            if([self->_resizeMode isEqualToString:@"contain"]) {
                cMode = UIViewContentModeScaleAspectFit;
            } else if ([self->_resizeMode isEqualToString:@"cover"]) {
                cMode = UIViewContentModeScaleAspectFill;
            }
            self->_imageView.contentMode = cMode;
            self->_imageView.animatedImage = self->_image;
            if(self->_paused) {
              [self->_imageView stopAnimating];
            }
            if (self->_onLoadEnd) {
              self->_onLoadEnd(@{});
            }
        }];
  });
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSArray *const pathComponents = url.pathComponents;
    NSString *filename = [pathComponents componentsJoinedByString:@"_"];
    NSString *const diskPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}

- (void) setPaused:(BOOL *)paused {
    _paused = paused;
    if(paused) {
            [_imageView stopAnimating];
        
    } else {
            [_imageView startAnimating];
    }
}


@end
